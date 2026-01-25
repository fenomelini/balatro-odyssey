-- ============================================
-- TEMPORAL - Rare (Jokers 111-118)
-- ============================================

-- 111. Horizonte de Eventos Temporal
SMODS.Joker({
    key = 'j_temporal_event_horizon',
    config = { extra = { min = 5, max = 50 } },
    rarity = 3,
    atlas = 'j_temporal_event_horizon',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.min, extra.max } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local mult = pseudorandom('horizonte') * (card.ability.extra.max - card.ability.extra.min) + card.ability.extra.min
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                mult_mod = mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 112. Rewind Temporal
SMODS.Joker({
    key = 'j_temporal_rewind',
    config = { extra = { mult_per = 10 } },
    rarity = 3,
    atlas = 'j_temporal_rewind',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult_per } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local hands_played = G.GAME.current_round.hands_played or 0
            local bonus = hands_played * card.ability.extra.mult_per
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { bonus } },
                mult_mod = bonus,
                colour = G.C.MULT
            }
        end
    end
})

-- 113. Repetição Temporal
SMODS.Joker({
    key = 'j_temporal_repetition',
    config = { extra = { dollars = 3, interval = 5, hands_count = 0 } },
    rarity = 3,
    atlas = 'j_temporal_repetition',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.dollars, extra.interval } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.hands_count = (card.ability.extra.hands_count or 0) + 1
            if card.ability.extra.hands_count >= card.ability.extra.interval then
                card.ability.extra.hands_count = 0
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = '$' .. card.ability.extra.dollars,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

-- 114. Déjà Vu Infinito
SMODS.Joker({
    key = 'j_temporal_infinite_deja_vu',
    config = { extra = { chips = 25 } },
    rarity = 3,
    atlas = 'j_temporal_infinite_deja_vu',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local discards = G.GAME.current_round.discards_left or 0
            local bonus = discards * card.ability.extra.chips
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { bonus } },
                chip_mod = bonus,
                colour = G.C.CHIPS
            }
        end
    end
})

-- 115. Futuro Promissor
SMODS.Joker({
    key = 'j_temporal_promising_future',
    config = { extra = { x_mult = 3, mult = 25, odds = 5 } },
    rarity = 3,
    atlas = 'j_temporal_promising_future',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.odds, extra.x_mult, extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('promising_future') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 116. Presente Eterno
SMODS.Joker({
    key = 'j_temporal_eternal_present',
    config = { extra = { x_mult = 1.5 } },
    rarity = 3,
    atlas = 'j_temporal_eternal_present',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local initial_discards = G.GAME.round_resets.discards or 0
            local current_discards = G.GAME.current_round.discards_left or 0
            if initial_discards == current_discards then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 117. Passado Perdido
SMODS.Joker({
    key = 'j_temporal_forgotten_past',
    config = { extra = { odds = 5 } },
    rarity = 3,
    atlas = 'j_temporal_forgotten_past',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { G.GAME.probabilities.normal or 1, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over and not context.repetition and not context.other_card then
            if pseudorandom('forgotten_past') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

-- 118. Crescimento Temporal
SMODS.Joker({
    key = 'j_temporal_growth',
    config = { extra = { mult = 0, mult_gain = 1 } },
    rarity = 3,
    atlas = 'j_temporal_growth',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                card = card
            }
        end
        
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})
