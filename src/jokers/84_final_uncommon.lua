-- J971-988: Final & Specials (Uncommon)

-- Rebirth (J971)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_rebirth',
    rarity = 2,
    atlas = 'j_final_rebirth',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.chips < G.GAME.blind.chips and not context.blueprint and not context.repetition and not context.other_card then
            if G.GAME.current_round.hands_left == 0 then
                G.GAME.chips = G.GAME.blind.chips
                if not card.ability.eternal then card:start_dissolve() end
                return {
                    message = "REBIRTH!",
                    colour = G.C.GOLD
                }
            end
        end
    end
})

-- Karma (J972)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_karma',
    config = { extra = { x_mult = 1.5, per_boss = 0.2, penalty = 0.5 } },
    rarity = 2,
    atlas = 'j_final_karma',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult, card.ability.extra.per_boss, card.ability.extra.penalty } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
        if context.end_of_round and G.GAME.blind.boss and not context.blueprint and not context.repetition and not context.other_card then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.per_boss
        end
        if context.selling_card and context.card.ability.set == 'Joker' and not context.blueprint then
            card.ability.extra.x_mult = math.max(1, card.ability.extra.x_mult - card.ability.extra.penalty)
        end
    end
})

-- Dharma (J973)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_dharma',
    config = { extra = { mult = 20, tri_mult = 60 } },
    rarity = 2,
    atlas = 'j_final_dharma',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult, card.ability.extra.tri_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local most_played = nil
            local max_plays = -1
            for k, v in pairs(G.GAME.hands) do
                if v.played > max_plays then
                    max_plays = v.played
                    most_played = k
                end
            end
            
            if context.scoring_name == most_played then
                return {
                    mult_mod = card.ability.extra.tri_mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.tri_mult } }
                }
            else
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- Nirvana (J974)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_nirvana',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_final_nirvana',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and #G.hand.cards == 0 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Samsara (J975)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_samsara',
    rarity = 2,
    atlas = 'j_final_samsara',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    calculate = function(self, card, context)
        -- Hooking into card destruction is hard without global overrides, but we can check context.destroying_card if available
        -- For now, let's make it add a copy on discard to simulate cycle
        if context.discard and not context.blueprint then
            if pseudorandom('samsara') < G.GAME.probabilities.normal / 5 then
                local _card = copy_card(context.other_card)
                _card:set_edition({negative = true})
                _card:add_to_deck()
                G.deck:emplace(_card)
                return {
                    message = "SAMSARA",
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

-- Zen (J976)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_zen',
    config = { extra = { mult = 30, timer = 10, last_hand_time = G.TIMERS.REAL } },
    rarity = 2,
    atlas = 'j_final_zen',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult, card.ability.extra.timer } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local now = G.TIMERS.REAL
            if now - card.ability.extra.last_hand_time >= card.ability.extra.timer then
                card.ability.extra.last_hand_time = now
                return {
                    mult_mod = card.ability.extra.mult,
                    message = "ZEN",
                    colour = G.C.MULT
                }
            end
            card.ability.extra.last_hand_time = now
        end
    end
})

-- Tao (J977)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_tao',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_final_tao',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local reds = 0
            local blacks = 0
            for k, v in ipairs(G.playing_cards) do
                if v:is_suit('Hearts') or v:is_suit('Diamonds') then reds = reds + 1
                else blacks = blacks + 1 end
            end
            if reds == blacks then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- Yin (J978)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_yin',
    config = { extra = { mult = 20, x_mult = 2 } },
    rarity = 2,
    atlas = 'j_final_yin',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult, card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_yang = false
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_odyssey_j_final_yang' then has_yang = true; break end
            end
            
            local spades_clubs = 0
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit('Spades') or v:is_suit('Clubs') then spades_clubs = spades_clubs + 1 end
            end
            
            if spades_clubs > 0 then
                local ret = { mult_mod = spades_clubs * card.ability.extra.mult }
                if has_yang then
                    ret.x_mult = card.ability.extra.x_mult
                end
                return ret
            end
        end
    end
})

-- Yang (J979)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_yang',
    config = { extra = { mult = 20, x_mult = 2 } },
    rarity = 2,
    atlas = 'j_final_yang',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult, card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_yin = false
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.key == 'j_odyssey_j_final_yin' then has_yin = true; break end
            end
            
            local hearts_diamonds = 0
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit('Hearts') or v:is_suit('Diamonds') then hearts_diamonds = hearts_diamonds + 1 end
            end
            
            if hearts_diamonds > 0 then
                local ret = { mult_mod = hearts_diamonds * card.ability.extra.mult }
                if has_yin then
                    ret.x_mult = card.ability.extra.x_mult
                end
                return ret
            end
        end
    end
})

-- Chi (J980)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_chi',
    config = { extra = { chips = 50, per_hand = 10 } },
    rarity = 2,
    atlas = 'j_final_chi',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.chips, card.ability.extra.per_hand } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card then
            local bonus = G.GAME.current_round.hands_left * card.ability.extra.per_hand
            if bonus > 0 then
                card.ability.extra.chips = card.ability.extra.chips + bonus
                return {
                    message = "CHI +",
                    colour = G.C.CHIPS
                }
            end
        end
    end
})

-- Chakra (J981)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_chakra',
    config = { extra = { mult_per_slot = 10 } },
    rarity = 2,
    atlas = 'j_final_chakra',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) 
        local slots = (G.consumeables and G.consumeables.config) and G.consumeables.config.card_limit or 0
        return { vars = { card.ability.extra.mult_per_slot, slots * card.ability.extra.mult_per_slot } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local slots = G.consumeables.config.card_limit
            if slots > 0 then
                return {
                    mult_mod = slots * card.ability.extra.mult_per_slot,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { slots * card.ability.extra.mult_per_slot } }
                }
            end
        end
    end
})

-- Mantra (J982)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_mantra',
    config = { extra = { x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_final_mantra',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            for k, v in ipairs(context.scoring_hand) do
                suits[v.base.suit] = true
            end
            local count = 0
            for k, v in pairs(suits) do count = count + 1 end
            
            if count == 1 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- Mandala (J983)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_mandala',
    rarity = 2,
    atlas = 'j_final_mandala',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            for k, v in ipairs(context.scoring_hand) do
                suits[v.base.suit] = true
            end
            local count = 0
            for k, v in pairs(suits) do count = count + 1 end
            
            if count >= 4 and #G.consumeables.cards < G.consumeables.config.card_limit then
                local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'mandala')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return {
                    message = "MANDALA!",
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

-- Lótus (J984)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_lotus',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_final_lotus',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_used == 0 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Om (J985)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_om',
    rarity = 2,
    atlas = 'j_final_om',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[1] then
                return {
                    message = 'OM',
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- Guru (J986)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_guru',
    rarity = 2,
    atlas = 'j_final_guru',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.level_up and not context.blueprint then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'guru')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                return {
                    message = "GURU!",
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end
})

-- Yogi (J987)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_yogi',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_final_yogi',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.dollars == 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- Avatar (J988)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_avatar',
    config = { extra = { target_key = nil } },
    rarity = 2,
    atlas = 'j_final_avatar',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card) 
        local name = "None"
        if card.ability.extra.target_key then
            name = G.P_CENTERS[card.ability.extra.target_key].name
        end
        return { vars = { name } } 
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local other_jokers = {}
            for k, v in ipairs(G.jokers.cards) do
                if v ~= card then table.insert(other_jokers, v.config.center.key) end
            end
            if #other_jokers > 0 then
                -- ODYSSEY FIX: Ensure the correct vanilla helper is used
                card.ability.extra.target_key = pseudorandom_element(other_jokers, pseudoseed('avatar'))
            end
        end
        
        if card.ability.extra.target_key then
            local target_center = G.P_CENTERS[card.ability.extra.target_key]
            if target_center and target_center.calculate and type(target_center.calculate) == 'function' then
                -- Simular BluePrint/Brainstorm
                return target_center:calculate(card, context)
            end
        end
    end
})
