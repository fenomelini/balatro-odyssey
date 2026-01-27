-- ============================================
-- DIMENSIONS - Common (Jokers 121-136)
-- ============================================

-- 121. Legado
SMODS.Joker({
    key = 'j_dimensions_legacy',
    config = { extra = { mult_per_joker = 5, jokers_sold = 0 } },
    rarity = 1,
    atlas = 'j_dimensions_legacy',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.jokers_sold * extra.mult_per_joker } }

    
    end,
    
    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint then
            card.ability.extra.jokers_sold = card.ability.extra.jokers_sold + 1
        end
        
        if context.joker_main then
            local mult = card.ability.extra.jokers_sold * card.ability.extra.mult_per_joker
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

-- 122. Crescimento Infinito
SMODS.Joker({
    key = 'j_dimensions_infinite_growth',
    config = { extra = { x_mult = 1, x_mult_gain = 0.05 } },
    rarity = 1,
    atlas = 'j_dimensions_infinite_growth',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.x_mult, extra.x_mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.blind and G.GAME.blind.chips_left and G.GAME.blind.chips_left <= 0 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
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

-- 123. Acumulação
SMODS.Joker({
    key = 'j_dimensions_accumulation',
    config = { extra = { mult = 0, cards_played = 0 } },
    rarity = 1,
    atlas = 'j_dimensions_accumulation',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.cards_played = (card.ability.extra.cards_played or 0) + 1
            if card.ability.extra.cards_played >= 2 then
                card.ability.extra.cards_played = 0
                card.ability.extra.mult = card.ability.extra.mult + 1
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
    end
})

-- 124. Última Hora
SMODS.Joker({
    key = 'j_dimensions_last_hour',
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    atlas = 'j_dimensions_last_hour',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 125. Scaling Linear
SMODS.Joker({
    key = 'j_dimensions_linear_scaling',
    config = { extra = { x_mult_per_ante = 0.2 } },
    rarity = 1,
    atlas = 'j_dimensions_linear_scaling',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)
        local antes = G.GAME.round_resets.ante or 1
        local x_mult = 1 + (antes * (card and card.ability.extra or self.config.extra).x_mult_per_ante)
        return { vars = { x_mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local antes = G.GAME.round_resets.ante or 1
            local x_mult = 1 + (antes * card.ability.extra.x_mult_per_ante)
            
            if x_mult > 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { x_mult } },
                    Xmult_mod = x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 126. Momentum
SMODS.Joker({
    key = 'j_dimensions_momentum',
    config = { extra = { mult_gain = 3 } },
    rarity = 1,
    atlas = 'j_dimensions_momentum',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            card.ability.extra.temp_mult = (card.ability.extra.temp_mult or 0) + card.ability.extra.mult_gain
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.temp_mult } },
                mult = card.ability.extra.temp_mult,
                colour = G.C.MULT
            }
        end
        
        if context.after and not context.blueprint then
            card.ability.extra.temp_mult = 0
        end
    end
})

-- 127. Sacrifício
SMODS.Joker({
    key = 'j_dimensions_sacrifice',
    config = { extra = { x_mult = 1, x_mult_gain = 1.5, odds = 10 } },
    rarity = 1,
    atlas = 'j_dimensions_sacrifice',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { G.GAME.probabilities.normal or 1, extra.odds, extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if pseudorandom('sacrifice') < G.GAME.probabilities.normal / card.ability.extra.odds then
                if not context.other_card.ability.eternal then
                    card.ability.extra.x_mult = card.ability.extra.x_mult * card.ability.extra.x_mult_gain
                    if not context.other_card.ability.eternal then context.other_card:start_dissolve() end
                    return {
                        message = 'Sacrificado!',
                        colour = G.C.PURPLE
                    }
                end
            end
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

-- 128. Número da Sorte
SMODS.Joker({
    key = 'j_dimensions_lucky_number',
    config = { extra = { x_mult = 2, req_cards = 4 } },
    rarity = 1,
    atlas = 'j_dimensions_lucky_number',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.req_cards, extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            if #G.hand.cards == card.ability.extra.req_cards then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 129. Bonus Aleatório
SMODS.Joker({
    key = 'j_dimensions_random_bonus',
    config = { extra = { money = 2 } },
    rarity = 1,
    atlas = 'j_dimensions_random_bonus',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if pseudorandom('random_bonus') < 0.15 then
                if pseudorandom('random_bonus_2') < 0.5 then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = localize('$') .. card.ability.extra.money,
                        colour = G.C.MONEY
                    }
                else
                    ease_discard(1)
                    return {
                        message = '+1',
                        colour = G.C.RED
                    }
                end
            end
        end
    end
})

-- 130. Cumulativo
SMODS.Joker({
    key = 'j_dimensions_cumulative',
    config = { extra = { x_mult = 1, x_mult_gain = 0.1 } },
    rarity = 1,
    atlas = 'j_dimensions_cumulative',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.x_mult, extra.x_mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.blind and G.GAME.chips >= G.GAME.blind.chips then
                card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
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

-- 131. Sequência
SMODS.Joker({
    key = 'j_dimensions_streak',
    config = { extra = { mult_per_hand = 10, streak = 0 } },
    rarity = 1,
    atlas = 'j_dimensions_streak',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.streak * extra.mult_per_hand } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.streak = card.ability.extra.streak + 1
        end
        
        if context.discard and not context.blueprint then
            card.ability.extra.streak = 0
        end
        
        if context.joker_main and card.ability.extra.streak > 0 then
            local mult = card.ability.extra.streak * card.ability.extra.mult_per_hand
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                mult_mod = mult,
                colour = G.C.MULT
            }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.streak = 0
        end
    end
})

-- 132. Queima Rápida
SMODS.Joker({
    key = 'j_dimensions_fast_burn',
    config = { extra = { x_mult = 2, decay = 0.2 } },
    rarity = 1,
    atlas = 'j_dimensions_fast_burn',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.x_mult = math.max(1, card.ability.extra.x_mult - card.ability.extra.decay)
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

-- 133. Tesouro Escondido
SMODS.Joker({
    key = 'j_dimensions_hidden_treasure',
    config = { extra = { money = 5, used_discard = false } },
    rarity = 1,
    atlas = 'j_dimensions_hidden_treasure',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.used_discard = true
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            if not card.ability.extra.used_discard then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
            card.ability.extra.used_discard = false
        end
    end
})

-- 134. Primeiras Três
SMODS.Joker({
    key = 'j_dimensions_first_three',
    config = { extra = { mult = 15, hands_played = 0, max_hands = 3 } },
    rarity = 1,
    atlas = 'j_dimensions_first_three',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.max_hands, extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1
        end
        
        if context.joker_main and card.ability.extra.hands_played <= card.ability.extra.max_hands then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.hands_played = 0
        end
    end
})

-- 135. Últimas Três
SMODS.Joker({
    key = 'j_dimensions_last_three',
    config = { extra = { mult = 20, max_hands = 3 } },
    rarity = 1,
    atlas = 'j_dimensions_last_three',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.max_hands, extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local hands_left = G.GAME.current_round.hands_left or 0
            if hands_left < card.ability.extra.max_hands then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 136. Melhor Jogada
SMODS.Joker({
    key = 'j_dimensions_best_play',
    config = { extra = { best_mult = 0, best_chips = 0 } },
    rarity = 1,
    atlas = 'j_dimensions_best_play',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)


        local extra = (card and card.ability.extra or self.config.extra)


        return { vars = { extra.best_mult, extra.best_chips } }


    end,

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            local current_mult = G.mult or 1
            local current_chips = G.hand_chips or 0
            
            if current_mult > card.ability.extra.best_mult then
                card.ability.extra.best_mult = current_mult
            end
            if current_chips > card.ability.extra.best_chips then
                card.ability.extra.best_chips = current_chips
            end
        end

        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            if card.ability.extra.best_mult > 0 or card.ability.extra.best_chips > 0 then
                return {
                    message = 'Melhor!',
                    mult_mod = card.ability.extra.best_mult,
                    chip_mod = card.ability.extra.best_chips,
                    colour = G.C.MULT
                }
            end
        end

        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.best_mult = 0
            card.ability.extra.best_chips = 0
        end
    end
})