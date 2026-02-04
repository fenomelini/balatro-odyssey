-- ============================================
-- QUANTUM - Uncommon (Jokers 57-70)
-- ============================================

-- 57. Campo Quântico
SMODS.Joker({
    key = 'j_quantum_quantum_field',
    atlas = 'j_quantum_quantum_field',
    config = { extra = { mult_bonus = 20 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult_bonus } }

    
    end,
    
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker ~= card then
            -- Verifica se é adjacente
            local my_index = nil
            local other_index = nil
            
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_index = i end
                if G.jokers.cards[i] == context.other_joker then other_index = i end
            end
            
            if my_index and other_index and math.abs(my_index - other_index) == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_bonus } },
                    mult_mod = card.ability.extra.mult_bonus,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 58. Decaimento
SMODS.Joker({
    key = 'j_quantum_decay',
    atlas = 'j_quantum_decay',
    config = { extra = { x_mult = 4, decay = 0.2 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult, extra.decay } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.x_mult = math.max(1, card.ability.extra.x_mult - card.ability.extra.decay)
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }, colour = G.C.MULT })
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

-- 59. Fissão
SMODS.Joker({
    key = 'j_quantum_fission',
    atlas = 'j_quantum_fission',
    config = { extra = { mult = 30 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
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

-- 60. Fusão
SMODS.Joker({
    key = 'j_quantum_fusion',
    atlas = 'j_quantum_fusion',
    config = { extra = { x_mult = 1, x_mult_gain = 1.5 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult, extra.x_mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local absorbed = false
            for i = #G.jokers.cards, 1, -1 do
                local other = G.jokers.cards[i]
                if other and other ~= card and other.config.center.key == card.config.center.key and not other.ability.eternal then
                    other:start_dissolve()
                    card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
                    absorbed = true
                end
            end
            if absorbed then
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.MULT })
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

-- 62. Déjà Vu
SMODS.Joker({
    key = 'j_quantum_deja_vu',
    atlas = 'j_quantum_deja_vu',
    config = { extra = { x_mult = 2.5 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.last_hand_played == context.scoring_name then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 63. Loop Infinito
SMODS.Joker({
    key = 'j_quantum_infinite_loop',
    atlas = 'j_quantum_infinite_loop',
    config = { extra = { mult = 30, count = 0, trigger = 3 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.played, extra.trigger } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.repetition then
            card.ability.extra.played = (card.ability.extra.played % card.ability.extra.trigger) + 1
        end
        
        -- Se estiver no gatilho, repete todas as cartas
        if context.repetition and context.cardarea == G.play then
            if card.ability.extra.played == card.ability.extra.trigger then
                return {
                    message = 'Loop!',
                    repetitions = 1,
                    card = card
                }
            end
        end
        
        if context.joker_main then
            if card.ability.extra.played == card.ability.extra.trigger then
                return {
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 64. Rewind
SMODS.Joker({
    key = 'j_quantum_rewind',
    atlas = 'j_quantum_rewind',
    config = { extra = { } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    
    calculate = function(self, card, context)
        -- Reativa cartas jogadas na mão
        if context.repetition and context.cardarea == G.play then
            return {
                message = 'Rewind!',
                repetitions = 1,
                card = card
            }
        end
    end
})

-- 65. Aceleração Temporal
SMODS.Joker({
    key = 'j_quantum_time_acceleration',
    atlas = 'j_quantum_time_acceleration',
    config = { extra = { x_mult = 1, x_mult_gain = 0.1 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult, extra.x_mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.repetition then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
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

-- 66. Âncora Temporal
SMODS.Joker({
    key = 'j_quantum_time_anchor',
    atlas = 'j_quantum_time_anchor',
    config = { extra = { x_mult = 3, fixed_money = 15 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 15,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult, extra.fixed_money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local diff = card.ability.extra.fixed_money - G.GAME.dollars
            ease_dollars(diff)
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

-- 67. Chrono Trigger
SMODS.Joker({
    key = 'j_quantum_chrono_trigger',
    atlas = 'j_quantum_chrono_trigger',
    config = { extra = { mult = 100, count = 0, trigger = 5 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.played, extra.trigger, extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.repetition then
            card.ability.extra.played = card.ability.extra.played + 1
        end
        
        if context.joker_main then
            if card.ability.extra.played >= card.ability.extra.trigger then
                card.ability.extra.played = 0
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 68. Entropia
SMODS.Joker({
    key = 'j_quantum_entropy',
    atlas = 'j_quantum_entropy',
    config = { extra = { mult = 25, x_mult = 1.5, chips = 50 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.x_mult, extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local effect = math.floor(pseudorandom('entropy') * 3) + 1
            if effect == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            elseif effect == 2 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
})

-- 69. Viajante do Tempo
SMODS.Joker({
    key = 'j_quantum_time_traveler',
    atlas = 'j_quantum_time_traveler',
    config = { extra = { mult = 40 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
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

-- 70. Teleportador
SMODS.Joker({
    key = 'j_quantum_slow_motion',
    atlas = 'j_quantum_slow_motion',
    config = { extra = { x_mult = 2, discards = 1 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult, extra.discards } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})