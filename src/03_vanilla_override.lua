-- Balatro Odyssey: Standard Vanilla Overrides & Hooks
-- Consolidates critical game logic and patches known injector bugs.

-- 1. Game Setup & Pool Management
local old_get_blind_amount = get_blind_amount
function get_blind_amount(ante)
    -- Blizzard (#436): freeze next round's blind (uses previous ante's value for 3 calls)
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_blizzard_frozen and G.GAME.modifiers.odyssey_blizzard_frozen > 0 then
        G.GAME.modifiers.odyssey_blizzard_frozen = G.GAME.modifiers.odyssey_blizzard_frozen - 1
        return old_get_blind_amount(math.max(1, ante - 1)) * 3
    end
    local amount = old_get_blind_amount(ante)
    -- Odyssey Scale: Base points grow 3x faster to compensate for 1000 Jokers power creep.
    return amount * 3
end

-- 2. Currency & Stat Easing
local old_ease_dollars = ease_dollars
function ease_dollars(amount, instant)
    if G.GAME.bankrupt_at and (G.GAME.dollars + amount < G.GAME.bankrupt_at) then return end
    -- Mirror Universe (#394): double all money gains and losses
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_mirror_universe then
        amount = amount * 2
    end
    old_ease_dollars(amount, instant)
end

-- 3. Card & Hand Logic Consolidation
local old_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if G.GAME and G.GAME.modifiers.odyssey_chameleon and not bypass_debuff then return true end
    -- Hot Cold (#344): Hearts and Spades swap suits for scoring
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_hot_cold and not bypass_debuff then
        local s = self.base and self.base.suit
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and s then
            if s == 'Hearts' then
                if suit == 'Spades' then return true end
                if suit == 'Hearts' then return false end
            elseif s == 'Spades' then
                if suit == 'Hearts' then return true end
                if suit == 'Spades' then return false end
            end
        end
    end
    -- Square Circle (#343): Diamonds count as black suits (Spades/Clubs)
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_square_circle and not bypass_debuff then
        local s = self.base and self.base.suit
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and s == 'Diamonds' then
            if suit == 'Spades' or suit == 'Clubs' then return true end
            if suit == 'Diamonds' then return false end
        end
    end
    -- Spade Anomaly (#361): Spades count as Hearts for Flushes
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_spade_heart and not bypass_debuff then
        local s = self.base and self.base.suit
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and s == 'Spades' then
            if suit == 'Hearts' then return true end
            if suit == 'Spades' then return false end
        end
    end
    -- Heart Anomaly (#362): Hearts count as Clubs for Flushes
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_heart_club and not bypass_debuff then
        local s = self.base and self.base.suit
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and s == 'Hearts' then
            if suit == 'Clubs' then return true end
            if suit == 'Hearts' then return false end
        end
    end
    -- Club Anomaly (#363): Clubs count as Diamonds for Flushes
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_club_diamond and not bypass_debuff then
        local s = self.base and self.base.suit
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and s == 'Clubs' then
            if suit == 'Diamonds' then return true end
            if suit == 'Clubs' then return false end
        end
    end
    -- Diamond Anomaly (#364): Diamonds count as Spades for Flushes
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_diamond_spade and not bypass_debuff then
        local s = self.base and self.base.suit
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and s == 'Diamonds' then
            if suit == 'Spades' then return true end
            if suit == 'Diamonds' then return false end
        end
    end
    -- Function Collapse (#397): Face cards (J/Q/K) have no suit
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_faceless_suits and not bypass_debuff then
        local id = self.base and self.base.id
        local is_wild = self.ability and self.ability.effect == 'Wild Card'
        if not is_wild and id and (id == 11 or id == 12 or id == 13) then
            return false
        end
    end
    return old_is_suit(self, suit, bypass_debuff, flush_calc)
end

local old_get_cost = Card.get_cost
function Card:get_cost()
    local cost = old_get_cost(self)
    if G.GAME.odyssey_astronomer_planets_free and self.ability.set == 'Planet' then return 0 end

    -- Deflation: reduce shop prices over time (min $1)
    local discount = G.GAME.odyssey_deflation_discount or 0
    if discount > 0 then
        cost = math.max(1, cost - discount)
    end

    -- Odyssey Coupon Joker (j_economy_coupon)
    if G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.key == 'j_odyssey_j_economy_coupon' and j.ability.extra and j.ability.extra.active then
                return 0
            end
        end
    end
    
    return cost
end

local old_set_cost = Card.set_cost
function Card:set_cost()
    old_set_cost(self)
    -- Pawn Shop: Consumables sell for $5
    if G.GAME and G.GAME.odyssey_pawn_shop_active and G.GAME.odyssey_pawn_shop_active > 0 then
        if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' then
            self.sell_cost = 5
            self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
        end
    end
    -- Mortal Immortal (#347): Eternal Jokers sell for $0
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_can_sell_eternal then
        if self.ability and self.ability.eternal then
            self.sell_cost = 0
            self.sell_cost_label = self.facing == 'back' and '?' or 0
        end
    end
end

local old_can_sell_card = Card.can_sell_card
function Card:can_sell_card(context)
    -- Mortal Immortal (#347): Allow selling Eternal Jokers (for $0)
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_can_sell_eternal then
        if self.ability and self.ability.eternal then
            if (G.play and #G.play.cards > 0) or
               (G.CONTROLLER.locked) or
               (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then return false end
            if self.area and self.area.config.type == 'joker' then
                return true
            end
        end
    end
    return old_can_sell_card(self, context)
end

-- 4. Safety Fixes (Lovely/Injector Stability)
local old_ebcb = ease_background_colour_blind
function ease_background_colour_blind(state, blindname)
    local b_name = blindname or (G.GAME.blind and G.GAME.blind.name) or ''
    -- Safety check: Avoid "attempt to index field 'boss' (a nil value)" in common_events.lua
    for _, v in pairs(G.P_BLINDS) do
        if v.name == b_name and not v.boss then
            ease_background_colour{new_colour = G.C.BLIND['Small'], contrast = 1}
            return
        end
    end
    old_ebcb(state, b_name)
end

local old_reroll_boss = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e)
    if not G.blind_select_opts or not G.blind_select_opts.boss then return end
    old_reroll_boss(e)
end

-- 5. Round Timer Initializer
local old_set_blind = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
    old_set_blind(self, blind, reset, silent)
    G.GAME.last_hand_time = G.TIMERS.REAL
end

-- 6. Blind Mechanics Overrides
-- A Espaguetificação: Jokers don't give Mult (Only Chips/XMult)
local old_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
    local ret = old_calculate_joker(self, context)
    if ret and G.GAME.blind and G.GAME.blind.key == 'blind_odyssey_blind_64' then
        if ret.mult_mod then ret.mult_mod = nil end
        if ret.mult then ret.mult = nil end
    end
    return ret
end

-- 7. Perma-Mult & Perma-Bonus Logic for Playing Cards
local old_get_chip_mult = Card.get_chip_mult
function Card:get_chip_mult()
    local mult = old_get_chip_mult(self)
    if self.debuff then return 0 end
    if self.ability.set == 'Joker' then return 0 end
    return mult + (self.ability.perma_mult or 0)
end

-- 8. Joker 365: Rank Shift (Aces <-> 2s chip values)
local old_get_chip_bonus = Card.get_chip_bonus
function Card:get_chip_bonus()
    local bonus = old_get_chip_bonus(self)
    if G.GAME and G.GAME.modifiers and G.GAME.modifiers.odyssey_rank_shift then
        if not self.debuff and self.ability.effect ~= 'Stone Card' then
            if self.base.id == 14 then
                -- Ace counts as 2: nominal 11 → 2
                return 2 + self.ability.bonus + (self.ability.perma_bonus or 0)
            elseif self.base.id == 2 then
                -- 2 counts as Ace: nominal 2 → 11
                return 11 + self.ability.bonus + (self.ability.perma_bonus or 0)
            end
        end
    end
    return bonus
end

-- 9. Pasteur Spectral: Permanent debuff immunity (perma_debuff_immune flag)
local old_set_debuff = Card.set_debuff
function Card:set_debuff(should_debuff)
    if should_debuff and self.ability and self.ability.perma_debuff_immune then
        return -- Card is immune to Boss Blind debuffs (Pasteur spectral)
    end
    return old_set_debuff(self, should_debuff)
end

local old_level_up_hand = level_up_hand
function level_up_hand(card, hand, instant, amount)
    local amt = amount or 1
    -- Futurist: Double level up amount
    if G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.key == 'j_odyssey_j_professions_futurist' and not j.debuff then
                amt = amt * 2
                j:juice_up()
                break
            end
        end
    end
    old_level_up_hand(card, hand, instant, amt)
end

local old_generate_UIBox_ability_table = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    local res = old_generate_UIBox_ability_table(self)
    if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and self.ability.perma_mult and self.ability.perma_mult ~= 0 then
        -- Inject perma_mult into loc_vars if needed
    end
    return res
end

-- Mechanic Voucher: force Enhanced type for playing cards generated in the shop/packs
local old_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.GAME and G.GAME.odyssey_mechanic_active and _type == 'Base'
        and area and (area == G.shop_jokers or area == G.pack_cards) then
        _type = 'Enhanced'
    end
    return old_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end

-- Magician / Illusionist Voucher: hooks for Tarot card usage
local old_use_consumeable = Card.use_consumeable
function Card:use_consumeable(area, copier)
    -- Capture state before original runs (card may be destroyed after)
    local is_tarot = self.config and self.config.center and self.config.center.set == 'Tarot'
    local center_key = self.config and self.config.center_key
    local is_second_use = self.ability and self.ability.odyssey_second_use

    old_use_consumeable(self, area, copier)

    if not is_tarot or copier then return end

    -- Magician Voucher: give $1 per tarot used
    local reward = G.GAME and G.GAME.face_card_tarot_reward or 0
    if reward > 0 then
        ease_dollars(reward)
    end

    -- Illusionist Voucher: re-add tarot to consumables for a second use
    if G.GAME and G.GAME.tarot_double_use and not is_second_use and center_key then
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
            if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
                local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, center_key)
                new_card.ability.odyssey_second_use = true
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
            return true
        end}))
    end
end

-- Zero Gravity (#181): Wraparound Straight (K-A-2-3-4 and Q-K-A-2-3)
local old_get_straight = get_straight
function get_straight(hand)
    local ret = old_get_straight(hand)
    if #ret > 0 then return ret end -- already a valid straight, no need to check

    -- Only activate if Zero Gravity joker is present and not debuffed
    if not (G.jokers and G.jokers.cards) then return ret end
    local zero_gravity_active = false
    for _, j in ipairs(G.jokers.cards) do
        if j.config and j.config.center and
           j.config.center.key == 'j_odyssey_j_celestial_zero_gravity' and
           not j.debuff then
            zero_gravity_active = true
            break
        end
    end
    if not zero_gravity_active then return ret end

    local four_fingers = next(find_joker('Four Fingers'))
    local needed = 5 - (four_fingers and 1 or 0)
    if #hand ~= needed then return ret end

    -- Build rank → cards map (same as vanilla)
    local IDS = {}
    for i = 1, #hand do
        local id = hand[i]:get_id()
        if id > 1 and id < 15 then
            IDS[id] = IDS[id] or {}
            IDS[id][#IDS[id]+1] = hand[i]
        end
    end

    -- Wraparound sequences crossing the K(13)→A(14)→2 boundary
    -- Vanilla already handles: A-2-3-4-5, 10-J-Q-K-A — these are the new cases
    local sequences = needed == 5
        and { {13,14,2,3,4}, {12,13,14,2,3} }   -- K-A-2-3-4 and Q-K-A-2-3
        or  { {13,14,2,3},   {12,13,14,2}   }   -- K-A-2-3 and Q-K-A-2 (Four Fingers)

    for _, seq in ipairs(sequences) do
        local t = {}
        local valid = true
        for _, rank in ipairs(seq) do
            if IDS[rank] then
                for _, v in ipairs(IDS[rank]) do t[#t+1] = v end
            else
                valid = false
                break
            end
        end
        if valid then
            table.insert(ret, t)
            return ret
        end
    end

    return ret
end

-- 10. Chromatic Anomaly (#367): Extra polychrome roll during edition polling
local old_poll_edition = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed)
    local result = old_poll_edition(_key, _mod, _no_neg, _guaranteed)
    if not result
        and G.GAME and G.GAME.modifiers
        and G.GAME.modifiers.odyssey_chromatic_rate
        and G.GAME.modifiers.odyssey_chromatic_rate > 1 then
        local rate = G.GAME.modifiers.odyssey_chromatic_rate
        local extra_poll = pseudorandom(pseudoseed((_key or 'chromatic') .. '_odyssey_poly'))
        if extra_poll > 1 - 0.006 * rate then
            return { polychrome = true }
        end
    end
    return result
end

