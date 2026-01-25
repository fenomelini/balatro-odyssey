-- [[ TAROT REGISTER LOOP ]]
local tarot_max = {
    [4] = 2, [6] = 2, [7] = 1, [8] = 1, [9] = 1, [12] = 2, [13] = 2, [14] = 2,
    [16] = 1, [17] = 1, [18] = 3, [19] = 3, [20] = 3, [22] = 3, [25] = 3, [26] = 2, [27] = 3,
    [35] = 2, [36] = 2, [37] = 1, [38] = 1, [44] = 1, [45] = 1, [59] = 3, [69] = 1,
    [84] = 1, [85] = 1, [86] = 1, [87] = 1, [88] = 1, [89] = 1, [90] = 1, [91] = 1, [92] = 1, [93] = 1, [94] = 1, [95] = 1, [96] = 1,
    [97] = 1, [98] = 1, [99] = 1, [100] = 1
}

local tarots = {}
for i = 1, 100 do
    table.insert(tarots, { id = i })
end

for _, t in ipairs(tarots) do
    SMODS.Consumable({
        key = 'tarot_' .. t.id,
        set = "Tarot",
        config = { extra = t.id, max_highlighted = tarot_max[t.id] or 0 },
        max_highlighted = tarot_max[t.id] or 0,
        atlas = "tarot_" .. t.id,
        pos = { x = 0, y = 0 },
        cost = 3,
        discovered = true,
        can_use = function(self, card)
            local id = card.ability.extra
            local max_h = tarot_max[id] or 0
            
            -- Targeted Tarots
            if max_h > 0 then
                if id == 14 or id == 26 then -- Death/Singularity (Exactly 2)
                    return #G.hand.highlighted == 2
                end
                return #G.hand.highlighted > 0 and #G.hand.highlighted <= max_h
            end

            -- Special condition Tarots
            if id == 1 then -- Fool
                return G.GAME.last_consumeable and G.GAME.last_consumeable.set ~= 'Spectral'
            elseif id == 60 then -- Life
                return G.GAME.last_destroyed_joker ~= nil
            elseif id == 61 then -- Death II (Joker)
                return G.jokers.highlighted and #G.jokers.highlighted == 1
            elseif id == 68 then -- Thief (Shop)
                if not (G.shop_jokers and G.shop_jokers.cards and #G.shop_jokers.cards > 0) then return false end
                for k, v in ipairs(G.shop_jokers.cards) do
                    local is_joker = (v.ability.set == 'Joker' or not v.ability.set)
                    local is_consumeable = (v.ability.set == 'Tarot' or v.ability.set == 'Planet' or v.ability.set == 'Spectral')
                    if (is_joker and #G.jokers.cards < G.jokers.config.card_limit) or
                       (is_consumeable and #G.consumeables.cards < G.consumeables.config.card_limit) then
                        return true
                    end
                end
                return false
            elseif id == 47 or id == 48 or id == 46 or id == 32 or id == 21 or id == 66 then -- Joker Tarots
                return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
            elseif id == 71 or id == 52 or id == 3 or id == 5 then -- Consumable Tarots
                return #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables
            end

            -- Instant Tarots
            return true
        end,
        loc_vars = function(self, info_queue, card)
            local id = self.config.extra
            local mapping = {
                [4] = "m_odyssey_ruby", [6] = "m_odyssey_emerald", [7] = "m_odyssey_cloth",
                [8] = "m_odyssey_rubber", [9] = "m_odyssey_ceramic", [16] = "m_odyssey_diamond",
                [17] = "m_odyssey_platinum", [30] = "m_odyssey_emerald", [31] = "m_odyssey_plastic",
                [37] = "m_odyssey_shadow", [38] = "m_odyssey_light",
                [84] = "m_odyssey_plant", [85] = "m_odyssey_holy", [86] = "m_odyssey_undead",
                [87] = "m_odyssey_cursed", [88] = "m_odyssey_magic", [89] = "m_odyssey_diamond",
                [90] = "m_odyssey_paper", [91] = "m_odyssey_ceramic", [92] = "m_odyssey_platinum", [93] = "m_odyssey_wood",
                [94] = "m_odyssey_cloth", [95] = "m_odyssey_ruby", [96] = "m_odyssey_emerald"
            }
            if mapping[id] then
                info_queue[#info_queue+1] = G.P_CENTERS[mapping[id]]
            end
            if id == 11 then
                info_queue[#info_queue+1] = G.P_CENTERS.e_foil
                info_queue[#info_queue+1] = G.P_CENTERS.e_holo
                info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
            end
            return { vars = {} }
        end,
        use = function(self, card, area, copier)
            local id = self.config.extra
            local highlighted = G.hand.highlighted

            if id == 1 then -- Fool
                if G.GAME.last_consumeable and G.GAME.last_consumeable.set ~= 'Spectral' then
                    local _card = create_card(G.GAME.last_consumeable.set, G.consumeables, nil, nil, nil, nil, G.GAME.last_consumeable.key, 'fool')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
            elseif id == 2 then -- Magician
                for i = 1, 2 do
                    local _card = create_card("Enhanced", G.hand, nil, nil, nil, nil, nil, "magician")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 3 then -- High Priestess
                for i = 1, 2 do
                    local _card = create_card("Planet", G.consumeables, nil, nil, nil, nil, nil, "priestess")
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
            elseif id == 4 then -- Empress
                for i=1, math.min(#highlighted, 2) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_ruby)
                end
            elseif id == 5 then -- Emperor
                for i=1, 2 do
                    local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, "emperor")
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
            elseif id == 6 then -- Hierophant
                for i=1, math.min(#highlighted, 2) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_emerald)
                end
            elseif id == 7 then -- Lovers
                for i=1, math.min(#highlighted, 1) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_cloth)
                end
            elseif id == 8 then -- Chariot
                for i=1, math.min(#highlighted, 1) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_rubber)
                end
            elseif id == 9 then -- Justice
                for i=1, math.min(#highlighted, 1) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_ceramic)
                end
            elseif id == 10 then -- Hermit
                ease_dollars(math.min(G.GAME.dollars, 20))
            elseif id == 11 then -- Wheel of Fortune
                if pseudorandom('wheel') < G.GAME.probabilities.normal / 4 then
                    local temp_jokers = {}
                    for k, v in ipairs(G.jokers.cards) do
                        if v.ability.set == 'Joker' and not v.edition then
                            table.insert(temp_jokers, v)
                        end
                    end
                    if #temp_jokers > 0 then
                        local random_joker = pseudorandom_element(temp_jokers, pseudoseed('wheel'))
                        local edition = poll_edition('wheel', nil, true, true)
                        random_joker:set_edition(edition, true)
                        card_eval_status_text(random_joker, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex'), colour = G.C.WHITE})
                    end
                else
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_nope_ex'), colour = G.C.DARK_EDITION})
                end
            elseif id == 12 then -- Strength
                for i=1, math.min(#highlighted, 2) do
                    local _card = highlighted[i]
                    local suit_prefix = string.sub(_card.base.suit, 1, 1)..'_'
                    local rank_suffix = _card.base.id == 14 and 2 or math.min(_card.base.id+1, 14)
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 then rank_suffix = 'A'
                    end
                    _card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                end
            elseif id == 13 then -- Hanged Man
                for i=1, math.min(#highlighted, 2) do
                    highlighted[i]:start_dissolve()
                end
            elseif id == 14 then -- Death
                if #highlighted == 2 then
                    highlighted[2]:set_base(highlighted[1].config.card)
                    highlighted[2]:set_ability(highlighted[1].config.center)
                end
            elseif id == 15 then -- Temperance
                local total = 0
                for k, v in ipairs(G.jokers.cards) do
                    total = total + v.sell_cost
                end
                ease_dollars(math.min(total, 50))
            elseif id == 16 then -- Devil
                for i=1, math.min(#highlighted, 1) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_diamond)
                end
            elseif id == 17 then -- Tower
                for i=1, math.min(#highlighted, 1) do
                    highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_platinum)
                end
            elseif id == 18 then -- Star
                for i=1, math.min(#highlighted, 3) do
                    highlighted[i]:change_suit('Diamonds')
                end
            elseif id == 19 then -- Moon
                for i=1, math.min(#highlighted, 3) do
                    highlighted[i]:change_suit('Clubs')
                end
            elseif id == 20 then -- Sun
                for i=1, math.min(#highlighted, 3) do
                    highlighted[i]:change_suit('Hearts')
                end
            elseif id == 21 then -- Judgement
                local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "judgement")
                _card:add_to_deck()
                G.jokers:emplace(_card)
            elseif id == 22 then -- World
                for i=1, math.min(#highlighted, 3) do
                    highlighted[i]:change_suit('Spades')
                end
            elseif id == 23 then -- Aeon (Reset Ante)
                ease_ante(-1)
            elseif id == 24 then -- Universe (All Planets)
                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                    local _card = create_card("Planet", G.consumeables, nil, nil, nil, nil, v.key, "universe")
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
            elseif id == 25 then -- Void
                for i=1, math.min(#highlighted, 3) do
                    highlighted[i]:start_dissolve()
                end
                ease_dollars(10)
            elseif id == 26 then -- Singularity
                if #highlighted == 2 then
                    highlighted[2]:set_base(highlighted[1].config.card)
                    highlighted[2]:set_ability(highlighted[1].config.center)
                    highlighted[1]:start_dissolve()
                end
            elseif id == 27 then -- Quantum
                for i=1, math.min(#highlighted, 3) do
                    local suits = {'S', 'H', 'C', 'D'}
                    local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'}
                    highlighted[i]:set_base(G.P_CARDS[pseudorandom_element(suits, pseudoseed('quantum')).. '_' .. pseudorandom_element(ranks, pseudoseed('quantum'))])
                end
            elseif id == 28 then -- Time
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
            elseif id == 29 then -- Space
                G.hand:change_size(1)
            elseif id == 30 then -- Matter
                for i = 1, 2 do
                    local _card = create_card("Enhanced", G.hand, nil, nil, nil, nil, "m_odyssey_emerald", "matter")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 31 then -- Energy
                for i = 1, 2 do
                    local _card = create_card("Enhanced", G.hand, nil, nil, nil, nil, "m_odyssey_plastic", "energy")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 32 then -- Soul
                local _card = create_card("Joker", G.jokers, nil, 0.9, nil, nil, nil, "soul")
                _card:add_to_deck()
                G.jokers:emplace(_card)
            elseif id == 33 then -- Spirit
                local _card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "spirit")
                _card:add_to_deck()
                G.consumeables:emplace(_card)
            elseif id == 34 then -- Mind (Sort Deck)
                table.sort(G.deck.cards, function(a, b) return a.base.value < b.base.value end)
            elseif id == 35 then -- Body
                for i=1, math.min(#highlighted, 2) do
                    highlighted[i].ability.perma_bonus = (highlighted[i].ability.perma_bonus or 0) + 50
                    highlighted[i]:juice_up()
                    card_eval_status_text(highlighted[i], 'extra', nil, nil, nil, {message = "+50 Fichas", colour = G.C.CHIPS})
                end
            elseif id == 36 then -- Heart
                for i=1, math.min(#highlighted, 2) do
                    highlighted[i].ability.perma_mult = (highlighted[i].ability.perma_mult or 0) + 10
                    highlighted[i]:juice_up()
                    card_eval_status_text(highlighted[i], 'extra', nil, nil, nil, {message = "+10 Mult", colour = G.C.MULT})
                end
            elseif id == 37 then -- Shadow
                for i=1, math.min(#highlighted, 1) do
                    if G.P_CENTERS.m_odyssey_shadow then
                        highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_shadow)
                    end
                end
            elseif id == 38 then -- Light
                for i=1, math.min(#highlighted, 1) do
                    if G.P_CENTERS.m_odyssey_light then
                        highlighted[i]:set_ability(G.P_CENTERS.m_odyssey_light)
                    end
                end
            elseif id == 39 then -- Chaos
                G.hand:shuffle()
            elseif id == 40 then -- Order
                G.hand:sort()
                for i = 1, #G.hand.cards do
                    G.hand.cards[i].ability.perma_bonus = (G.hand.cards[i].ability.perma_bonus or 0) + 10
                end
            elseif id == 41 then -- Balance
                ease_dollars(25 - G.GAME.dollars)
            elseif id == 42 then -- Infinity
                local temp_jokers = {}
                for k, v in ipairs(G.jokers.cards) do
                    if v.ability.set == 'Joker' then table.insert(temp_jokers, v) end
                end
                if #temp_jokers > 0 then
                    pseudorandom_element(temp_jokers, pseudoseed('inf')):set_edition({polychrome = true}, true)
                end
            elseif id == 43 then -- Zero
                local temp_jokers = {}
                for k, v in ipairs(G.jokers.cards) do
                    if v.edition then table.insert(temp_jokers, v) end
                end
                if #temp_jokers > 0 then
                    pseudorandom_element(temp_jokers, pseudoseed('zero')):set_edition(nil, true)
                    ease_dollars(20)
                end
            elseif id == 44 then -- One
                for i = 1, math.min(#highlighted, 1) do
                    highlighted[i]:set_base(G.P_CARDS[string.sub(highlighted[i].base.suit, 1, 1)..'_A'])
                end
            elseif id == 45 then -- Many
                if #highlighted == 1 then
                    for i = 1, 2 do
                        local _card = copy_card(highlighted[1], nil, nil, nil)
                        _card:add_to_deck()
                        G.hand:emplace(_card)
                    end
                end
            elseif id == 46 then -- Past (Vintage)
                local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "past")
                _card:set_edition({foil = true}, true) -- placeholder for vintage
                _card:add_to_deck()
                G.jokers:emplace(_card)
            elseif id == 47 then -- Future (Futuristic)
                local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "future")
                _card:set_edition({holo = true}, true) -- placeholder
                _card:add_to_deck()
                G.jokers:emplace(_card)
            elseif id == 48 then -- Present (Modern)
                local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "present")
                _card:add_to_deck()
                G.jokers:emplace(_card)
            elseif id == 49 then -- Unknown (Random)
                local random_id = pseudorandom(pseudoseed('unknown'), 1, 22)
                self.config.extra = random_id
                self:use(card, area, copier)
                self.config.extra = id
            elseif id == 50 then -- Truth
                for k, v in ipairs(G.deck.cards) do v.facing = 'front' end
            elseif id == 51 then -- Lie
                for k, v in ipairs(G.hand.cards) do v.facing = 'back' end
                ease_dollars(5)
            elseif id == 52 then -- Dream
                local _card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, "dream")
                _card:add_to_deck()
                G.consumeables:emplace(_card)
            elseif id == 53 then -- Nightmare
                local _card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "nightmare")
                _card:add_to_deck()
                G.consumeables:emplace(_card)
            elseif id == 54 then -- Hope
                ease_ante(1)
            elseif id == 55 then -- Despair
                ease_ante(-1)
            elseif id == 56 then -- Love
                local to_add = {}
                for k, v in ipairs(G.hand.cards) do
                    if v.base.suit == 'Hearts' then
                        table.insert(to_add, v)
                    end
                end
                for k, v in ipairs(to_add) do
                    local _card = copy_card(v, nil, nil, nil)
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 57 then -- Hate
                for i=#G.hand.cards, 1, -1 do
                    if G.hand.cards[i].base.suit == 'Spades' then
                        G.hand.cards[i]:start_dissolve()
                    end
                end
            elseif id == 58 then -- War
                local count = 0
                for i=#G.hand.cards, 1, -1 do
                    if G.hand.cards[i]:is_face() then
                        G.hand.cards[i]:start_dissolve()
                        count = count + 1
                    end
                end
                ease_dollars(count * 2)
            elseif id == 59 then -- Peace
                local suits = {Spades=0, Hearts=0, Clubs=0, Diamonds=0}
                for k, v in ipairs(G.deck.cards) do suits[v.base.suit] = suits[v.base.suit] + 1 end
                local max_suit = 'Spades'
                for k, v in pairs(suits) do if v > suits[max_suit] then max_suit = k end end
                for i=1, math.min(#highlighted, 3) do highlighted[i]:change_suit(max_suit) end
            elseif id == 60 then -- Life
                if G.GAME.last_destroyed_joker then
                    local _card = copy_card(G.P_CENTERS[G.GAME.last_destroyed_joker], nil, nil, nil)
                    _card:add_to_deck()
                    G.jokers:emplace(_card)
                end
            elseif id == 61 then -- Death II
                if #G.jokers.highlighted == 1 then
                    local _joker = G.jokers.highlighted[1]
                    ease_dollars(_joker.sell_cost * 2)
                    _joker:start_dissolve()
                end
            elseif id == 62 then -- King
                for i = 1, 2 do
                    local _card = create_card("Base", G.hand, nil, nil, nil, nil, "S_K", "king")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 63 then -- Queen
                for i = 1, 2 do
                    local _card = create_card("Base", G.hand, nil, nil, nil, nil, "H_Q", "queen")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 64 then -- Jack
                for i = 1, 2 do
                    local _card = create_card("Base", G.hand, nil, nil, nil, nil, "D_J", "jack")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 65 then -- Ace
                for i = 1, 2 do
                    local _card = create_card("Base", G.hand, nil, nil, nil, nil, "C_A", "ace")
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                end
            elseif id == 66 then -- Joker
                local _card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "joker_t")
                _card:add_to_deck()
                G.jokers:emplace(_card)
            elseif id == 67 then -- Merchant
                G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                    G.FUNCS.reroll_shop()
                    return true
                end}))
            elseif id == 68 then -- Thief
                local pool = {}
                if G.shop_jokers and G.shop_jokers.cards then
                    for _, v in ipairs(G.shop_jokers.cards) do
                        local is_joker = (v.ability.set == 'Joker' or not v.ability.set)
                        local is_consumeable = (v.ability.set == 'Tarot' or v.ability.set == 'Planet' or v.ability.set == 'Spectral')
                        if (is_joker and #G.jokers.cards < G.jokers.config.card_limit) or
                           (is_consumeable and #G.consumeables.cards < G.consumeables.config.card_limit) then
                            table.insert(pool, v)
                        end
                    end
                end
                
                if #pool > 0 then
                    local _card = pseudorandom_element(pool, pseudoseed('thief'))
                    local area = (_card.ability.set == 'Joker' or not _card.ability.set) and G.jokers or G.consumeables
                    _card:add_to_deck()
                    area:emplace(_card)
                    _card:juice_up()
                end
            elseif id == 69 then -- Guardian
                if #highlighted == 1 then
                    highlighted[1].ability.eternal = true
                end
            elseif id == 70 then -- Sage
                level_up_hand(card, pseudorandom_element(G.GAME.hands, pseudoseed('sage')), nil, 1)
            elseif id == 71 then -- Fool II
                if G.GAME.last_consumeable and #G.consumeables.cards < G.consumeables.config.card_limit then
                    local _card = create_card(G.GAME.last_consumeable.set, G.consumeables, nil, nil, nil, nil, G.GAME.last_consumeable.key, 'fool_ii')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                end
            elseif id == 72 then -- Architect
                G.hand:change_size(1)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Tam. Mão", colour = G.C.BLUE})
            elseif id == 73 then -- Builder
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Descarte", colour = G.C.RED})
            elseif id == 74 then -- Destroyer
                G.hand:change_size(-1)
                ease_dollars(20)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-1 Tam. Mão, +$20", colour = G.C.GOLD})
            elseif id == 75 then -- Creator
                local _card = create_card(pseudorandom_element({'Tarot', 'Planet', 'Spectral', 'Joker'}, pseudoseed('creator')), G.consumeables, nil, nil, nil, nil, nil, 'creator')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
            elseif id == 76 then -- Observer
                -- Revela o Boss: Na prática do mod, troca o boss atual por um novo
                local new_blind = pseudorandom_element(G.P_CENTER_POOLS.Blind, pseudoseed('observer'))
                while not new_blind.boss or new_blind.key == G.GAME.blind.key do
                    new_blind = pseudorandom_element(G.P_CENTER_POOLS.Blind, pseudoseed('observer'))
                end
                G.GAME.blind:set_blind(new_blind)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Novo Boss!", colour = G.C.FILTER})
            elseif id == 77 then -- Traveler
                local boss_keys = {}
                for _, v in pairs(G.P_BLINDS) do
                    if v.boss and v.key ~= G.GAME.blind.key then
                        table.insert(boss_keys, v)
                    end
                end
                local new_blind = pseudorandom_element(#boss_keys > 0 and boss_keys or {G.P_BLINDS.bl_small}, pseudoseed('traveler'))
                G.GAME.blind:set_blind(new_blind)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        G.GAME.blind:juice_up()
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
            elseif id == 78 then -- Pilgrim
                local tag = Tag(pseudorandom_element(G.P_TAGS, pseudoseed('pilgrim')).key)
                add_tag(tag)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
            elseif id == 79 then -- Monk
                for k, v in ipairs(G.hand.cards) do v.debuff = false end
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
            elseif id == 80 then -- Warrior
                G.GAME.warrior_chips = (G.GAME.warrior_chips or 0) + 100
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+100 Fichas", colour = G.C.CHIPS})
            elseif id == 81 then -- Magician II
                G.GAME.magician_mult = (G.GAME.magician_mult or 0) + 20
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+20 Multi", colour = G.C.MULT})
            elseif id == 82 then -- Rogue
                G.GAME.rogue_x_mult = (G.GAME.rogue_x_mult or 1) * 2
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "X2 Multi", colour = G.C.MULT})
            elseif id == 83 then -- Bard
                G.GAME.bard_retrigger = (G.GAME.bard_retrigger or 0) + 1
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "+1 Reativar", colour = G.C.FILTER})
            elseif id >= 84 and id <= 96 then
                local enhancements = {
                    [84] = "m_odyssey_plant", [85] = "m_odyssey_holy", [86] = "m_odyssey_undead",
                    [87] = "m_odyssey_cursed", [88] = "m_odyssey_magic", [89] = "m_odyssey_diamond",
                    [90] = "m_odyssey_paper", [91] = "m_odyssey_ceramic", [92] = "m_odyssey_platinum", [93] = "m_odyssey_wood",
                    [94] = "m_odyssey_cloth", [95] = "m_odyssey_ruby", [96] = "m_odyssey_emerald"
                }
                local max_h = tarot_max[id] or 1
                for i=1, math.min(#highlighted, max_h) do
                    if G.P_CENTERS[enhancements[id]] then
                        highlighted[i]:set_ability(G.P_CENTERS[enhancements[id]])
                    end
                end
            elseif id == 97 then -- Duplicator
                if #highlighted == 1 then
                    local _card = copy_card(highlighted[1], nil, nil, nil)
                    _card:add_to_deck()
                    G.hand:emplace(_card)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.FILTER})
                end
            elseif id == 98 then -- Remover
                for i=1, math.min(#highlighted, 1) do
                    highlighted[i]:start_dissolve()
                end
            elseif id == 99 then -- Transformer
                if #highlighted == 1 then
                    local suits = {'S', 'H', 'C', 'D'}
                    local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'}
                    highlighted[1]:set_base(G.P_CARDS[pseudorandom_element(suits, pseudoseed('trans_s')).. '_' .. pseudorandom_element(ranks, pseudoseed('trans_r'))])
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
                end
            elseif id == 100 then -- Enhancer
                if #highlighted == 1 then
                    local enhancements = {"m_odyssey_ruby", "m_odyssey_emerald", "m_odyssey_cloth", "m_odyssey_ceramic", "m_odyssey_rubber", "m_odyssey_platinum", "m_odyssey_diamond", "m_odyssey_wood", "m_odyssey_plant", "m_odyssey_holy", "m_odyssey_undead", "m_odyssey_cursed", "m_odyssey_magic"}
                    highlighted[1]:set_ability(G.P_CENTERS[pseudorandom_element(enhancements, pseudoseed('enhancer'))])
                end
            end
        end
    })
end

