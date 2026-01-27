-- ============================================
-- TEMPORAL - Uncommon (Jokers 97-110)
-- ============================================

-- 97. Limbo
SMODS.Joker({
    key = 'j_temporal_limbo',
    config = { extra = { x_mult = 3, odds = 2 } },
    rarity = 2,
    atlas = 'j_temporal_limbo',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.x_mult, (G.GAME.probabilities.normal or 1), extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('limbo') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = 'Limbo...',
                    colour = G.C.UI.TEXT_INACTIVE
                }
            end
        end
    end
})

-- 98. Subspace
SMODS.Joker({
    key = 'j_temporal_subspace',
    config = { extra = { mult = 40 } },
    rarity = 2,
    atlas = 'j_temporal_subspace',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 99. Realidade Fraturada
SMODS.Joker({
    key = 'j_temporal_fractured_reality',
    config = { extra = { min_x_mult = 1, max_x_mult = 5 } },
    rarity = 2,
    atlas = 'j_temporal_fractured_reality',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.min_x_mult, extra.max_x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local range = card.ability.extra.max_x_mult - card.ability.extra.min_x_mult
            local x_mult = (pseudorandom('realidade_fraturada') * range) + card.ability.extra.min_x_mult
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { x_mult } },
                Xmult_mod = x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 100. Omniverso
SMODS.Joker({
    key = 'j_temporal_omniverse',
    config = { extra = { x_mult_per = 0.1 } },
    rarity = 2,
    atlas = 'j_temporal_omniverse',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.GAME and G.GAME.hands then
            for k, v in pairs(G.GAME.hands) do
                if v.played > 0 then count = count + 1 end
            end
        end
        local current_x_mult = 1 + (count * card.ability.extra.x_mult_per)
        return { vars = { current_x_mult, card.ability.extra.x_mult_per, count } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.GAME and G.GAME.hands then
                for k, v in pairs(G.GAME.hands) do
                    if v.played > 0 then count = count + 1 end
                end
            end
            local total_x_mult = 1 + (count * card.ability.extra.x_mult_per)
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

-- 101. Relógio Cósmico
SMODS.Joker({
    key = 'j_temporal_cosmic_clock',
    config = { extra = { rounds = 0, req_rounds = 3, x_mult = 1, x_mult_gain = 0.5 } },
    rarity = 2,
    atlas = 'j_temporal_cosmic_clock',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.rounds, extra.x_mult, extra.req_rounds, extra.x_mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds >= card.ability.extra.req_rounds then
                card.ability.extra.rounds = 0
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

-- 102. Eco Temporal
SMODS.Joker({
    key = 'j_temporal_time_echo',
    config = { extra = { mult_per = 3 } },
    rarity = 2,
    atlas = 'j_temporal_time_echo',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult_per } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local unused_discards = G.GAME.current_round.discards_left or 0
            if unused_discards > 0 then
                local bonus = unused_discards * card.ability.extra.mult_per
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { bonus } },
                    mult_mod = bonus,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 103. Viajante Temporal 2
SMODS.Joker({
    key = 'j_temporal_traveler_2',
    config = { extra = { first_hand_mult = 0, first_hand_chips = 0, hands_played = 0 } },
    rarity = 2,
    atlas = 'j_temporal_traveler_2',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    
    calculate = function(self, card, context)
        -- Incrementa contador
        if context.before and not context.blueprint then
            card.ability.extra.hands_played = (card.ability.extra.hands_played or 0) + 1
        end
        
        -- Primeira mão: captura valores atuais (Base + Cartas)
        if context.joker_main and card.ability.extra.hands_played == 1 then
            card.ability.extra.first_hand_mult = (G.mult or 1)
            card.ability.extra.first_hand_chips = (G.hand_chips or 0)
        end
        
        -- Última mão: repete o bônus
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            local bonus_mult = card.ability.extra.first_hand_mult
            local bonus_chips = card.ability.extra.first_hand_chips
            
            if bonus_mult > 0 or bonus_chips > 0 then
                return {
                    message = 'Eco!',
                    mult_mod = bonus_mult > 0 and bonus_mult or nil,
                    chip_mod = bonus_chips > 0 and bonus_chips or nil,
                    colour = G.C.PURPLE
                }
            end
        end
        
        -- Reset no fim da rodada
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.hands_played = 0
            card.ability.extra.first_hand_mult = 0
            card.ability.extra.first_hand_chips = 0
        end
    end
})

-- 104. Paradoxo
SMODS.Joker({
    key = 'j_temporal_paradox',
    config = { extra = { odds = 4 } },
    rarity = 2,
    atlas = 'j_temporal_paradox',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { G.GAME.probabilities.normal or 1, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if pseudorandom('viajante_temporal') < G.GAME.probabilities.normal / card.ability.extra.odds then
                if pseudorandom('viajante_temporal_2') < 0.5 then
                    ease_hands_played(1)
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = '+1 Mão!', colour = G.C.BLUE })
                else
                    ease_discard(1)
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = '+1 Descarte!', colour = G.C.RED })
                end
            end
        end
    end
})

-- 105. Linha Temporal Alternativa
SMODS.Joker({
    key = 'j_temporal_alternate_timeline',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_temporal_alternate_timeline',
    pos = { x = 0, y = 0 },
    cost = 7,
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
        if context.setting_blind and not context.blueprint then
            if G.GAME.current_round.hands_left > 1 then
                ease_hands_played(-1)
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = '-1 Mão', colour = G.C.RED })
            end
        end
        
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 106. Estase
SMODS.Joker({
    key = 'j_temporal_stasis',
    config = { extra = { odds = 10, bonus_next_round = false } },
    rarity = 2,
    atlas = 'j_temporal_stasis',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { G.GAME.probabilities.normal or 1, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.blind and G.GAME.blind.chips_left and G.GAME.blind.chips_left <= 0 then
                if pseudorandom('stasis') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    card.ability.extra.bonus_next_round = true
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Estase!', colour = G.C.PURPLE })
                end
            end
        end
        
        if context.setting_blind and not context.blueprint then
            if card.ability.extra.bonus_next_round then
                card.ability.extra.bonus_next_round = false
                ease_hands_played(1)
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = '+1 Mão!', colour = G.C.BLUE })
            end
        end
    end
})

-- 107. Momento Congelado
SMODS.Joker({
    key = 'j_temporal_frozen_moment',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_temporal_frozen_moment',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local ranks = {}
            for i = 1, #context.scoring_hand do
                local rank = context.scoring_hand[i].base.value
                ranks[rank] = (ranks[rank] or 0) + 1
            end
            
            for rank, count in pairs(ranks) do
                if count >= 2 then
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        mult_mod = card.ability.extra.mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
})

-- 108. Futuro Incerto
SMODS.Joker({
    key = 'j_temporal_uncertain_future',
    config = { extra = { stored_mult = 0, stored_chips = 0, hands_played = 0, x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_temporal_uncertain_future',
    pos = { x = 0, y = 0 },
    cost = 7,
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
        if context.before and not context.blueprint then
            card.ability.extra.hands_played = (card.ability.extra.hands_played or 0) + 1
        end
        
        -- Primeira mão: armazena os valores
        if context.joker_main and card.ability.extra.hands_played == 1 then
            card.ability.extra.stored_mult = (G.mult or 1)
            card.ability.extra.stored_chips = (G.hand_chips or 0)
        end
        
        -- Última mão: aplica XMult e bônus guardado
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                message = 'Futuro!',
                mult_mod = card.ability.extra.stored_mult > 0 and card.ability.extra.stored_mult or nil,
                chip_mod = card.ability.extra.stored_chips > 0 and card.ability.extra.stored_chips or nil,
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.PURPLE
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.hands_played = 0
            card.ability.extra.stored_mult = 0
            card.ability.extra.stored_chips = 0
        end
    end
})

-- 109. Cronômetro
SMODS.Joker({
    key = 'j_temporal_chronometer',
    config = { extra = { mult = 0, mult_gain = 2 } },
    rarity = 2,
    atlas = 'j_temporal_chronometer',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult, extra.mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
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

-- 110. Dilatação Temporal
SMODS.Joker({
    key = 'j_temporal_time_dilation',
    config = { extra = { x_mult = 1.5, last_hand = '', is_same = false } },
    rarity = 2,
    atlas = 'j_temporal_time_dilation',
    pos = { x = 0, y = 0 },
    cost = 7,
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
        if context.before and context.scoring_name then
            local current_hand = context.scoring_name
            card.ability.extra.is_same = (current_hand == card.ability.extra.last_hand)
            card.ability.extra.last_hand = current_hand
        end
        
        if context.joker_main and card.ability.extra.is_same then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})