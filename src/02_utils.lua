----------------------------------------------
-- UTILITY FUNCTIONS
----------------------------------------------

-- Helper: Count total number of Jokers
function count_jokers()
    return #G.jokers.cards
end

-- Helper: Get number of empty Joker slots
function get_empty_slots()
    return G.jokers.config.card_limit - #G.jokers.cards
end

-- Helper: Get current deck size
function get_deck_size()
    return #G.playing_cards
end

-- Helper: Check if card is specific suit
function is_suit(card, suit)
    return card:is_suit(suit)
end

-- Helper: Check if card is specific rank
function is_rank(card, rank)
    return card.base.value == rank
end

-- Helper: Get Joker by key
function get_joker_by_key(key)
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == key then
            return G.jokers.cards[i]
        end
    end
    return nil
end

-- Helper: Count Jokers of specific rarity
function count_jokers_by_rarity(rarity)
    local count = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.rarity == rarity then
            count = count + 1
        end
    end
    return count
end

-- Helper: Get neighbor Joker (supports Connector bridging)
function get_joker_neighbor(card, direction)
    local my_pos = nil
    for i=1, #G.jokers.cards do
        if G.jokers.cards[i] == card then my_pos = i break end
    end
    if not my_pos then return nil end
    
    local step = direction == 'left' and -1 or 1
    local target_pos = my_pos + step
    
    local target = G.jokers.cards[target_pos]
    if target and target.config.center.key == 'j_odyssey_j_pos_connector' then
        target_pos = target_pos + step
        target = G.jokers.cards[target_pos]
    end
    
    return target
end

-- Helper: Check if only one Joker of this type exists
function is_unique_joker(card)
    local duplicates = 0
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] and G.jokers.cards[i] ~= card and G.jokers.cards[i].ability.name == card.ability.name then
            duplicates = duplicates + 1
        end
    end
    return duplicates == 0
end

-- Helper: Flip animation for tarot card modifications on playing cards.
-- cards: pre-sliced array of playing cards to animate.
-- effect_fn(cards): called between flip-down and flip-up; receives the cards array.
function tarot_flip_cards(cards, effect_fn)
    local n = #cards
    if n == 0 then return end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1'); return true
    end}))
    for i = 1, n do
        local c = cards[i]
        local p = 1.15 - (i - 0.999) / (n - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
            c:flip(); play_sound('card1', p); c:juice_up(0.3, 0.3); return true
        end}))
    end
    delay(0.2)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
        effect_fn(cards); return true
    end}))
    for i = 1, n do
        local c = cards[i]
        local p = 0.85 + (i - 0.999) / (n - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
            c:flip(); play_sound('tarot2', p, 0.6); c:juice_up(0.3, 0.3); return true
        end}))
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        G.hand:unhighlight_all(); return true
    end}))
    delay(0.5)
end

-- Helper: Utility function for localization
function create_loc_text(key, name, text)
    return {
        name = name,
        text = text
    }
end

-- Sorte Azarada: Override pseudorandom to fail checks for luck cards
local old_pseudorandom = pseudorandom
function pseudorandom(seed, min, max)
    if G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.key == 'j_odyssey_j_paradox_unlucky_luck' and not j.debuff then
                if seed == 'undead_retrigger' or seed == 'light_money' or seed == 'magic_tarot' then
                    return 0.99 -- Fail the check (usually check is < prob)
                end
            end
        end
    end
    return old_pseudorandom(seed, min, max)
end

-- Vanilla Omission implementation
function BalatroOdyssey.apply_config()
    local config = BalatroOdyssey.config
    local hide_vanilla = (config and config.hide_vanilla ~= false)

    -- If we want to hide vanilla:
    if hide_vanilla then
        -- 1. Mark vanilla centers as omit
        if G.P_CENTERS then
            for k, v in pairs(G.P_CENTERS) do
                if v.set and not string.find(string.lower(k), "odyssey") then
                    local to_replace = {Joker = true, Tarot = true, Planet = true, Spectral = true, Voucher = true, Enhanced = true}
                    if to_replace[v.set] then
                        v.omit = true
                    end
                end
            end
        end
        
        -- 2. Clean vanilla from pools
        if G.P_CENTER_POOLS then
            local replace_sets = {Joker = true, Tarot = true, Planet = true, Spectral = true, Voucher = true, Enhanced = true, Tarot_Planet = true, Consumeables = true}
            for pool_name, pool in pairs(G.P_CENTER_POOLS) do
                if replace_sets[pool_name] then
                    for i = #pool, 1, -1 do
                        if pool[i].key and not string.find(string.lower(pool[i].key), "odyssey") then
                            table.remove(pool, i)
                        end
                    end
                end
            end
        end
        
        -- 3. Clean rarity pools
        if G.P_JOKER_RARITY_POOLS then
            for r = 1, 4 do
                local r_pool = G.P_JOKER_RARITY_POOLS[r]
                if r_pool then
                    for i = #r_pool, 1, -1 do
                        if r_pool[i].key and not string.find(string.lower(r_pool[i].key), "odyssey") then
                            table.remove(r_pool, i)
                        end
                    end
                end
            end
        end
    else
        -- IF WE WANT TO SHOW VANILLA:
        -- Ensure they are NOT omitted (though we can't easily rebuild pools without restart)
        if G.P_CENTERS then
            for k, v in pairs(G.P_CENTERS) do
                if v.set and not string.find(string.lower(k), "odyssey") then
                    v.omit = nil
                end
            end
        end
    end
end

-- ODYSSEY CUSTOM: Robust n-of-a-kind helper for custom hands
function get_n_of_a_kind(hand, n)
    local ranks = {}
    for i = 1, #hand do
        local r = hand[i]:get_id()
        if r > 0 then
            ranks[r] = ranks[r] or {}
            table.insert(ranks[r], hand[i])
        end
    end
    local results = {}
    -- Sort ranks to ensure deterministic order (highest rank first like vanilla)
    local sorted_ranks = {}
    for r, group in pairs(ranks) do
        table.insert(sorted_ranks, {rank = r, group = group})
    end
    table.sort(sorted_ranks, function(a, b) return a.rank > b.rank end)

    for _, item in ipairs(sorted_ranks) do
        if #item.group >= n then
            -- If it's more than n, we only return first n cards to match vanilla behavior
            local group = {}
            for i = 1, n do
                table.insert(group, item.group[i])
            end
            table.insert(results, group)
        end
    end
    return results
end

-- Safety patch for create_popup_UIBox_tooltip to prevent crash when localization is missing
-- Some game parts expect tooltip.text to be a table, but localize returns a string "ERROR" on failure
local old_create_popup_UIBox_tooltip = create_popup_UIBox_tooltip
function create_popup_UIBox_tooltip(tooltip)
    if tooltip and type(tooltip.text) == 'string' then
        tooltip.text = {tooltip.text}
    end
    return old_create_popup_UIBox_tooltip(tooltip)
end

-- Hook for global Odyssey mechanics (like per-hand Tarot buffs)
SMODS.current_mod.calculate = function(self, context)
    if not context or type(context) ~= 'table' then return end
    
    -- Per-hand scoring buffs
    if context.joker_main then
        local chips = 0
        local mult = G.GAME.magician_mult or 0
        local x_mult = G.GAME.rogue_x_mult or 1

        -- Spectral: Einstein (41) - Convert chip score to mult for one hand
        if G.GAME.odyssey_einstein_active then
            G.GAME.odyssey_einstein_active = nil -- Consume
            local einstein_chips = 0
            if context.scoring_name and G.GAME.hands[context.scoring_name] then
                einstein_chips = einstein_chips + (G.GAME.hands[context.scoring_name].chips or 0)
            end
            for _, c in ipairs(context.scoring_hand or {}) do
                einstein_chips = einstein_chips + (c:get_chip_bonus() or 0)
            end
            mult = mult + einstein_chips
        end
        
        -- Spectral: Supernova (1), Zero Absoluto (14), Planck (15)
        x_mult = x_mult * (G.GAME.odyssey_spectral_1_xmult or 1)
        x_mult = x_mult * (G.GAME.odyssey_spectral_14_xmult or 1)
        x_mult = x_mult * (G.GAME.odyssey_spectral_15_xmult or 1)
        
        -- Spectral: Oppenheimer (50) X10 next hand
        if G.GAME.odyssey_spectral_50_next_xmult then
            x_mult = x_mult * G.GAME.odyssey_spectral_50_next_xmult
            G.GAME.odyssey_spectral_50_next_xmult = nil -- Consume
        end

        -- Spectral: Yang (94) X1.5 for 5-card hands
        if G.GAME.odyssey_yang_active and #context.full_hand == 5 then
            x_mult = x_mult * 1.5
        end

        -- Spectral: Zuckerberg (72) - Social Network: +3 Mult per adjacent active Joker
        if G.GAME.odyssey_zuckerberg_active and G.jokers and G.jokers.cards then
            local jokers = G.jokers.cards
            for i = 1, #jokers do
                if not jokers[i].debuff then
                    if i > 1 and not jokers[i-1].debuff then mult = mult + 3 end
                    if i < #jokers and not jokers[i+1].debuff then mult = mult + 3 end
                end
            end
        end

        -- Spectral: Darwin (54) +1 chip per scored card
        if G.GAME.odyssey_darwin_active then
            chips = chips + #(context.scoring_hand or {})
        end

        -- Spectral: Babbage (64) X5 next hand (consume)
        if G.GAME.odyssey_babbage_xmult then
            x_mult = x_mult * G.GAME.odyssey_babbage_xmult
            G.GAME.odyssey_babbage_xmult = nil
        end

        -- Spectral: Hadfield (86) X2 next hand (consume)
        if G.GAME.odyssey_hadfield_xmult then
            x_mult = x_mult * G.GAME.odyssey_hadfield_xmult
            G.GAME.odyssey_hadfield_xmult = nil
        end

        -- Spectral: Hopper (66) 10% chance X100
        if G.GAME.odyssey_hopper_active and pseudorandom('hopper') < 0.1 then
            x_mult = x_mult * 100
        end

        -- Spectral: Drake (35) X2 each hand this round
        if G.GAME.odyssey_drake_active then
            x_mult = x_mult * 2
        end

        -- Spectral: Cristoforetti (89) +5 stacking Mult per hand this round
        if G.GAME.odyssey_cristoforetti_active then
            G.GAME.odyssey_cristoforetti_stacks = (G.GAME.odyssey_cristoforetti_stacks or 0) + 5
            mult = mult + G.GAME.odyssey_cristoforetti_stacks
        end

        if chips > 0 or mult > 0 or x_mult > 1 then
            return {
                message = "Odyssey!",
                chips = chips > 0 and chips or nil,
                mult = mult > 0 and mult or nil,
                x_mult = x_mult > 1 and x_mult or nil,
                colour = G.C.PURPLE
            }
        end
    end

    -- Spectral: Sharma (95) +$1 per Joker per hand
    if context.after and G.GAME.odyssey_sharma_active then
        ease_dollars(#G.jokers.cards)
    end

    -- Spectral: Newton (40) +1 hand per unscored card played
    if context.after and G.GAME.odyssey_newton_active and context.full_hand and context.scoring_hand then
        local unscored = #context.full_hand - #context.scoring_hand
        if unscored > 0 then ease_hands_played(unscored) end
    end

    -- Spectral: Nakamoto (73) ±50% money each hand
    if context.after and G.GAME.odyssey_nakamoto_active and (G.GAME.dollars or 0) > 0 then
        local delta = math.floor(G.GAME.dollars * 0.5)
        local sign = pseudorandom('nakamoto') > 0.5 and 1 or -1
        ease_dollars(delta * sign)
    end

    -- Bard Retrigger
    if context.repetition and context.cardarea == G.play then
        -- Spectral: Penrose (47) 25% chance retrigger per scored card
        if G.GAME.odyssey_penrose_active and pseudorandom('penrose') < 0.25 then
            return { message = "Penrose!", repetitions = 1, card = context.other_card }
        end
        -- Spectral: Marconi (61) retrigger cards sharing rank with another scored card
        if G.GAME.odyssey_marconi_active and context.other_card then
            local card_rank = context.other_card.base.value
            for _, c in ipairs(context.scoring_hand or {}) do
                if c ~= context.other_card and c.base.value == card_rank then
                    return { message = "Sinal!", repetitions = 1, card = context.other_card }
                end
            end
        end
        if G.GAME.bard_retrigger and G.GAME.bard_retrigger > 0 then
            return {
                message = "Bard!",
                repetitions = 1,
                card = context.other_card
            }
        end
    end

    -- Reset round-based effects
    if context.end_of_round and not context.other_card then
        G.GAME.odyssey_spectral_1_xmult = 1
        G.GAME.odyssey_galileo_active = nil
        G.GAME.odyssey_newton_active = nil
        G.GAME.odyssey_einstein_active = nil
        G.GAME.odyssey_drake_active = nil

        -- Spectral: Curie (53) randomize ranks of all deck cards
        if G.GAME.odyssey_curie_active then
            local ranks = {'2','3','4','5','6','7','8','9','T','J','Q','K','A'}
            for i=1, #G.playing_cards do
                local nr = pseudorandom_element(ranks, pseudoseed('curie_eor'..i))
                local sp = G.playing_cards[i].base.suit:sub(1,1)
                if G.P_CARDS[sp..'_'..nr] then
                    G.playing_cards[i]:set_base(G.P_CARDS[sp..'_'..nr])
                end
            end
        end

        -- Reset per-round stacking effects
        G.GAME.odyssey_cristoforetti_stacks = 0
        G.GAME.odyssey_heisenberg_active = nil

        -- Deflation: accumulate shop price discount
        if (G.GAME.odyssey_deflation_active or 0) > 0 then
            G.GAME.odyssey_deflation_discount = (G.GAME.odyssey_deflation_discount or 0) + 1
        end
        
        -- Reset Tarot buffs
        G.GAME.magician_mult = 0
        G.GAME.rogue_x_mult = 1
        G.GAME.bard_retrigger = 0

        -- Safety: Turn all cards face up when winning a round to prevent permanent flip bugs
        -- Specifically helpful for Endless mode transition.
        if G.playing_cards then
            for k, v in ipairs(G.playing_cards) do
                v.facing = 'front'
                v.sprite_facing = 'front'
            end
        end
    end
end

-- Reveal all Odyssey content (Jokers, Vouchers, Decks, etc.) in the Collections menu
function BalatroOdyssey.reveal_all_content()
    -- Prefix for Odyssey content
    local function is_odyssey_key(k)
        if not k then return false end
        return type(k) == 'string' and k:find('odyssey_') ~= nil
    end

    -- Mark discovered in individual centers
    for k, v in pairs(G.P_CENTERS) do
        if is_odyssey_key(k) then
            v.discovered = false
            v.unlocked = true
            v.alerted = true
        end
    end
    
    -- Mark discovered in Blinds
    for k, v in pairs(G.P_BLINDS) do
        if is_odyssey_key(k) then
            v.discovered = false
            v.unlocked = true
        end
    end

    -- Update profile metadata if available
    local profile = (G and G.SETTINGS and G.SETTINGS.profile and G.PROFILES) and G.PROFILES[G.SETTINGS.profile] or nil
    if profile then
        profile.meta = profile.meta or { unlocked = {}, discovered = {}, alerted = {} }
        profile.meta.unlocked = profile.meta.unlocked or {}
        profile.meta.discovered = profile.meta.discovered or {}
        profile.meta.alerted = profile.meta.alerted or {}
        
        for k, v in pairs(G.P_CENTERS) do
            if is_odyssey_key(k) then
                profile.meta.unlocked[k] = true
                profile.meta.discovered[k] = false
                profile.meta.alerted[k] = false
            end
        end
        for k, v in pairs(G.P_BLINDS) do
            if is_odyssey_key(k) then
                profile.meta.unlocked[k] = true
                profile.meta.discovered[k] = false
            end
        end
    end
end

-- ODYSSEY ADJACENCY HELPERS
function BalatroOdyssey.get_card_index(card, area)
    if not area or not area.cards then return nil end
    for i = 1, #area.cards do
        if area.cards[i] == card then return i end
    end
    return nil
end

function BalatroOdyssey.is_adjacent(card1, card2, area)
    local idx1 = BalatroOdyssey.get_card_index(card1, area)
    local idx2 = BalatroOdyssey.get_card_index(card2, area)
    if idx1 and idx2 and math.abs(idx1 - idx2) == 1 then
        return true
    end
    return false
end

function BalatroOdyssey.get_adjacent_cards(card, area)
    local idx = BalatroOdyssey.get_card_index(card, area)
    local adjacent = {}
    if not idx or not area or not area.cards then return adjacent end
    if area.cards[idx-1] then table.insert(adjacent, area.cards[idx-1]) end
    if area.cards[idx+1] then table.insert(adjacent, area.cards[idx+1]) end
    return adjacent
end


-- Safety patch for create_popup_UIBox_tooltip to prevent crash when localization is missing

----------------------------------------------
-- ODYSSEY ENGINE MONITOR & LOGGING SYSTEM
----------------------------------------------
-- Sistema centralizado para rastrear cada ação dos 1000 Jokers e itens.

ODYSSEY_LOG = {
    info = function(cat, msg) print("[ODYSSEY INFO][" .. cat .. "] " .. msg) end,
    warn = function(cat, msg) print("[ODYSSEY WARN][" .. cat .. "] " .. msg) end,
    err  = function(cat, msg) print("[ODYSSEY ERROR][" .. cat .. "] " .. msg) end,
    debug = function(card, context, ret)
        local key = (card.config and card.config.center and card.config.center.key) or "unknown"
        if not key:find("odyssey") then return end -- Só loga itens do mod
        
        local ctx_name = "Unknown"
        if context.joker_main then ctx_name = "Main Scoring"
        elseif context.before then ctx_name = "Before Hand"
        elseif context.after then ctx_name = "After Hand"
        elseif context.end_of_round then ctx_name = "End of Round"
        elseif context.discard then ctx_name = "Discard"
        elseif context.individual then ctx_name = "Individual Card"
        elseif context.repetition then ctx_name = "Repetition/Retrigger"
        elseif context.setting_blind then ctx_name = "Setting Blind"
        elseif context.selling_self then ctx_name = "Selling Joker"
        elseif context.skip_blind then ctx_name = "Skip Blind"
        elseif context.open_booster then ctx_name = "Open Booster"
        elseif context.buying_card then ctx_name = "Buying Card"
        end

        local res = "Ignored"
        if ret then
            res = "SUCCESS -> "
            if type(ret) == "table" then
                for k, v in pairs(ret) do
                    if k ~= "card" then res = res .. k .. ": " .. tostring(v) .. " | " end
                end
            end
        end
        if ret then
            print("[ODYSSEY DEBUG][" .. key .. "] Context: " .. ctx_name .. " | Result: " .. res)
        end
    end
}

-- 1. Hook de Cálculo de Jokers (Com Proteção contra Crash)
local card_calc_joker_ref = Card.calculate_joker
function Card.calculate_joker(self, context)
    -- Tenta executar o cálculo original
    local status, ret = pcall(card_calc_joker_ref, self, context)
    
    if not status then
        -- Se o Joker do mod deu erro de código, logamos o erro detalhado em vez de fechar o jogo
        ODYSSEY_LOG.err("CRASH PROTECT", "Joker " .. (self.config.center.key or "unknown") .. " crashed! Error: " .. tostring(ret))
        return nil
    end

    -- Se for um item do Odyssey, logamos o comportamento
    if self.config.center.key and self.config.center.key:find("odyssey") then
        ODYSSEY_LOG.debug(self, context, ret)
    end

    -- Chain Reaction (#225): count activations of OTHER jokers during main scoring
    if context and context.joker_main and ret ~= nil
       and self.config and self.config.center
       and self.config.center.key ~= 'j_odyssey_j_chaos_chain_reaction'
       and not context.blueprint then
        G.GAME.odyssey_chain_activations = (G.GAME.odyssey_chain_activations or 0) + 1
    end

    return ret
end

-- 2. Hook de Uso de Consumíveis
local card_use_consumeable_ref = Card.use_consumeable
function Card.use_consumeable(self, area, copier)
    local key = self.config.center.key or "unknown"
    if key:find("odyssey") then
        ODYSSEY_LOG.info("CONSUMABLE", "Using " .. key .. " (Area: " .. (area and area.config.type or "nil") .. ")")
    end
    
    local status, ret = pcall(card_use_consumeable_ref, self, area, copier)
    if not status then
        ODYSSEY_LOG.err("CRASH PROTECT", "Consumable " .. key .. " crashed! Error: " .. tostring(ret))
    end
    return ret
end

-- 3. Hook de Criação de Cartas (Para rastrear pools)
local create_card_ref = create_card
function create_card(...)
    local card = create_card_ref(...)
    if card and card.config.center.key and card.config.center.key:find("odyssey") then
        local args = {...}
        ODYSSEY_LOG.info("POOL", "Generated Odyssey item: " .. card.config.center.key .. " (Set: " .. tostring(args[1]) .. ")")
    end
    return card
end
