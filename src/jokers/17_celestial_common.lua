-- ============================================
-- CELESTIAL - Common (Jokers 161-176)
-- ============================================

-- 161. Estrela Cadente
SMODS.Joker({
    key = 'j_celestial_shooting_star',
    config = { extra = { mult = 4, mult_gain = 2 } },
    rarity = 1,
    atlas = 'j_celestial_shooting_star',
    pos = { x = 0, y = 0 },
    cost = 4,
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
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == 'Planet' then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
        
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 162. Constelação
SMODS.Joker({
    key = 'j_celestial_constellation',
    config = { extra = { xmult = 1.5, req_faces = 3 } },
    rarity = 1,
    atlas = 'j_celestial_constellation',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult, extra.req_faces } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local faces = 0
            for _, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    faces = faces + 1
                end
            end
            
            if faces >= card.ability.extra.req_faces then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 163. Lua Nova
SMODS.Joker({
    key = 'j_celestial_new_moon',
    config = { extra = { odds = 4 } },
    rarity = 1,
    atlas = 'j_celestial_new_moon',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { G.GAME.probabilities.normal or 1, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_face() then
                if pseudorandom('new_moon') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = context.other_card
                    }
                end
            end
        end
    end
})

-- 164. Sol Nascente
SMODS.Joker({
    key = 'j_celestial_rising_sun',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_celestial_rising_sun',
    pos = { x = 0, y = 0 },
    cost = 5,
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
        if context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 165. Nebulosa
SMODS.Joker({
    key = 'j_celestial_nebula',
    config = { extra = {} },
    rarity = 1,
    atlas = 'j_celestial_nebula',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'High Card' then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'nebula')
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

-- 166. Cometa
SMODS.Joker({
    key = 'j_celestial_comet',
    config = { extra = { chips_per_card = 10 } },
    rarity = 1,
    atlas = 'j_celestial_comet',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local deck_size = G.playing_cards and #G.playing_cards or 0
        return { vars = { deck_size * ( (card and card.ability and card.ability.extra) or self.config.extra ).chips_per_card } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local deck_size = G.playing_cards and #G.playing_cards or 0
            local chips = deck_size * card.ability.extra.chips_per_card
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { chips } },
                chip_mod = chips,
                colour = G.C.CHIPS
            }
        end
    end
})

-- 167. Asteroide
SMODS.Joker({
    key = 'j_celestial_asteroid',
    config = { extra = { base_chips = 50, penalty = 5, current_chips = 50 } },
    rarity = 1,
    atlas = 'j_celestial_asteroid',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.current_chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local cards_played = #context.full_hand
            card.ability.extra.current_chips = math.max(0, card.ability.extra.current_chips - (cards_played * card.ability.extra.penalty))
        end
        
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
                chip_mod = card.ability.extra.current_chips,
                colour = G.C.CHIPS
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current_chips = card.ability.extra.base_chips
        end
    end
})

-- 168. Pulsar
SMODS.Joker({
    key = 'j_celestial_pulsar',
    config = { extra = { mult = 10, mult_gain = 10, hands_counter = 0, req_hands = 3 } },
    rarity = 1,
    atlas = 'j_celestial_pulsar',
    pos = { x = 0, y = 0 },
    cost = 6,
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
        if context.before and not context.blueprint then
            card.ability.extra.hands_counter = card.ability.extra.hands_counter + 1
            if card.ability.extra.hands_counter >= card.ability.extra.req_hands then
                card.ability.extra.hands_counter = 0
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
        
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        
        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.other_card then
            card.ability.extra.mult = 10
            card.ability.extra.hands_counter = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    end
})

-- 169. Quasar
SMODS.Joker({
    key = 'j_celestial_quasar',
    config = { extra = { base_chips = 40, chips_per_discard = 5, current_chips = 40 } },
    rarity = 1,
    atlas = 'j_celestial_quasar',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.current_chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chips_per_discard
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
        
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
                chip_mod = card.ability.extra.current_chips,
                colour = G.C.CHIPS
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current_chips = card.ability.extra.base_chips
        end
    end
})

-- 170. Supernova
SMODS.Joker({
    key = 'j_celestial_supernova',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_celestial_supernova',
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        
        if context.after and context.scoring_name == 'High Card' and not context.blueprint then
            card.ability.extra.x_mult = 1
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    end
})

-- 171. Buraco de Minhoca (Comum)
SMODS.Joker({
    key = 'j_celestial_wormhole_common',
    config = { extra = { money = 1 } },
    rarity = 1,
    atlas = 'j_celestial_wormhole',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if context.other_card:is_face() then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

-- 172. Satélite
SMODS.Joker({
    key = 'j_celestial_satellite',
    config = { extra = { money_per_10 = 1, max_money = 5 } },
    rarity = 1,
    atlas = 'j_celestial_satellite',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.money_per_10, extra.max_money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local bonus = math.min(card.ability.extra.max_money, math.floor(G.GAME.dollars / 10) * card.ability.extra.money_per_10)
            if bonus > 0 then
                ease_dollars(bonus)
                return {
                    message = localize('$') .. bonus,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

-- 173. Eclipse
SMODS.Joker({
    key = 'j_celestial_eclipse',
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    atlas = 'j_celestial_eclipse',
    pos = { x = 0, y = 0 },
    cost = 5,
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
            local has_face = false
            for _, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    has_face = true
                    break
                end
            end
            
            if not has_face then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 174. Meteoro
SMODS.Joker({
    key = 'j_celestial_meteor',
    config = { extra = { base_chips = 40, chips_per_card = 4 } },
    rarity = 1,
    atlas = 'j_celestial_meteor',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.base_chips, extra.chips_per_card } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local held_cards = #G.hand.cards
            local chips = card.ability.extra.base_chips + (held_cards * card.ability.extra.chips_per_card)
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { chips } },
                chip_mod = chips,
                colour = G.C.CHIPS
            }
        end
    end
})

-- 175. Poeira Cósmica
SMODS.Joker({
    key = 'j_celestial_cosmic_dust',
    config = { extra = { mult_per_card = 2 } },
    rarity = 1,
    atlas = 'j_celestial_cosmic_dust',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local deck_size = G.playing_cards and #G.playing_cards or 0
        local excess = math.max(0, deck_size - 52)
        return { vars = { excess * ( (card and card.ability and card.ability.extra) or self.config.extra ).mult_per_card } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local deck_size = G.playing_cards and #G.playing_cards or 0
            local excess = math.max(0, deck_size - 52)
            local mult = excess * card.ability.extra.mult_per_card
            if mult > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                    mult_mod = mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 176. Radiação Estelar
SMODS.Joker({
    key = 'j_celestial_stellar_radiation',
    config = { extra = { chips = 5 } },
    rarity = 1,
    atlas = 'j_celestial_stellar_radiation',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips,
                card = context.other_card
            }
        end
    end
})