-- ============================================
-- CELESTIAL - Uncommon (Jokers 177-190)
-- ============================================

-- 177. Alinhamento Planetário
SMODS.Joker({
    key = 'j_celestial_planetary_alignment',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_celestial_planetary_alignment',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if #context.scoring_hand == 4 then
                local suits = {}
                for _, v in ipairs(context.scoring_hand) do
                    suits[v.base.suit] = true
                end
                
                local count = 0
                for _ in pairs(suits) do count = count + 1 end
                
                if count == 4 then
                    return {
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
})

-- 178. Chuva de Meteoros
SMODS.Joker({
    key = 'j_celestial_meteor_shower',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_celestial_meteor_shower',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[1] then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card
                }
            end
        end
    end
})

-- 179. Tempestade Solar
SMODS.Joker({
    key = 'j_celestial_solar_storm',
    config = { extra = { mult = 0, mult_gain = 3 } },
    rarity = 2,
    atlas = 'j_celestial_solar_storm',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if context.other_card:is_suit('Spades') then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
        
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.mult = 0
        end
    end
})

-- 180. Anéis de Saturno
SMODS.Joker({
    key = 'j_celestial_rings_of_saturn',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_celestial_rings_of_saturn',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 8 then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 181. Gravidade Zero
SMODS.Joker({
    key = 'j_celestial_zero_gravity',
    config = { extra = { x_mult = 3, odyssey_wraparound_straight = true } },
    rarity = 2,
    atlas = 'j_celestial_zero_gravity',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Straight" then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                x_mult = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 182. Campo Estelar
SMODS.Joker({
    key = 'j_celestial_stellar_field',
    config = { extra = { xmult = 2 } },
    rarity = 2,
    atlas = 'j_celestial_stellar_field',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if #context.scoring_hand == 5 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 183. Fusão Nuclear
SMODS.Joker({
    key = 'j_celestial_nuclear_fusion',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_celestial_nuclear_fusion',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'Pair' and not context.blueprint then
            local destroyed_cards = {}
            for _, v in ipairs(context.scoring_hand) do
                destroyed_cards[#destroyed_cards+1] = v
                v:start_dissolve()
            end
            
            if #destroyed_cards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Default', G.hand, nil, nil, nil, nil, 'm_odyssey_emerald', 'nuclear_fusion')
                        new_card:add_to_deck()
                        G.hand:emplace(new_card)
                        return true
                    end
                }))
                return {
                    message = localize('k_fusion'),
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 184. Vento Solar
SMODS.Joker({
    key = 'j_celestial_solar_wind',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_celestial_solar_wind',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card
                }
            end
        end
    end
})

-- 185. Maré Gravitacional
SMODS.Joker({
    key = 'j_celestial_gravitational_tide',
    config = { extra = { hand_size = 1, discards = 1 } },
    rarity = 2,
    atlas = 'j_celestial_gravitational_tide',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    add_to_deck = function(self, card, from_debuff)
        G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 186. Horizonte de Eventos
SMODS.Joker({
    key = 'j_celestial_event_horizon',
    config = { extra = { mult = 0, mult_gain = 3, destroyed_this_round = false } },
    rarity = 2,
    atlas = 'j_celestial_event_horizon',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not card.ability.extra.destroyed_this_round then
            if context.other_card == context.full_hand[1] then -- First card in discard selection
                card.ability.extra.destroyed_this_round = true
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                if not context.other_card.ability.eternal then context.other_card:start_dissolve() end
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
        
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.destroyed_this_round = false
        end
    end
})

-- 187. Singularidade Estelar
SMODS.Joker({
    key = 'j_celestial_stellar_singularity',
    config = { extra = { x_mult_per_slot = 0.2 } },
    rarity = 2,
    atlas = 'j_celestial_stellar_singularity',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local empty_slots = (G.jokers and G.jokers.config and G.jokers.cards) and math.max(0, G.jokers.config.card_limit - #G.jokers.cards) or 0
        local total_x_mult = 1 + (empty_slots * ( (card and card.ability and card.ability.extra) or self.config.extra ).x_mult_per_slot)
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).x_mult_per_slot, empty_slots, total_x_mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local empty_slots = math.max(0, G.jokers.config.card_limit - #G.jokers.cards)
            local total_x_mult = 1 + (empty_slots * card.ability.extra.x_mult_per_slot)
            if total_x_mult > 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { total_x_mult } },
                    Xmult_mod = total_x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 188. Nebulosa Planetária
SMODS.Joker({
    key = 'j_celestial_planetary_nebula',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_celestial_planetary_nebula',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.other_card then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'planetary_nebula')
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_planet'),
                    colour = G.C.SECONDARY_SET.Planet,
                    card = card
                }
            end
        end
    end
})

-- 189. Proto-estrela
SMODS.Joker({
    key = 'j_celestial_protostar',
    config = { extra = { x_mult = 1, x_mult_gain = 0.1 } },
    rarity = 2,
    atlas = 'j_celestial_protostar',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                card = card
            }
        end
        
        if context.joker_main and card.ability.extra.x_mult > 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 190. Anã Branca
SMODS.Joker({
    key = 'j_celestial_white_dwarf',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_celestial_white_dwarf',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})