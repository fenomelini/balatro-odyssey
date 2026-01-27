-- ============================================
-- QUANTUM - Common (Jokers 41-56)
-- ============================================

-- 41. Superposição
SMODS.Joker({
    key = 'j_quantum_superposition',
    config = { extra = { mult = 10, chips = 40 } },
    atlas = 'j_quantum_superposition',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('superposition') < 0.5 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
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

-- 42. Flutuação Quântica
SMODS.Joker({
    key = 'j_quantum_quantum_fluctuation',
    atlas = 'j_quantum_quantum_fluctuation',
    config = { extra = { mult = 15, min = 5, max = 25 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.min, extra.max } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.mult = math.floor(pseudorandom('fluctuation') * (card.ability.extra.max - card.ability.extra.min + 1) + card.ability.extra.min)
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_val_up'), colour = G.C.MULT })
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

-- 43. Incerteza
SMODS.Joker({
    key = 'j_quantum_uncertainty',
    atlas = 'j_quantum_uncertainty',
    config = { extra = { mult = 50, money = 5, odds = 4 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('uncertainty') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local outcome = math.floor(pseudorandom('uncertainty_outcome') * 3) + 1
                if outcome == 1 then
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        mult_mod = card.ability.extra.mult,
                        colour = G.C.MULT
                    }
                elseif outcome == 2 then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = localize('$') .. card.ability.extra.money,
                        colour = G.C.MONEY
                    }
                else
                    G.GAME.current_round.free_rerolls = (G.GAME.current_round.free_rerolls or 0) + 1
                    return {
                        message = localize('k_plus_reroll'),
                        colour = G.C.GREEN
                    }
                end
            end
        end
    end
})

-- 44. Dualidade
SMODS.Joker({
    key = 'j_quantum_duality',
    atlas = 'j_quantum_duality',
    config = { extra = { mult = 15, chips = 50 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                colour = G.C.MULT
            }
        end
    end
})

-- 45. Emaranhamento
SMODS.Joker({
    key = 'j_quantum_entanglement',
    atlas = 'j_quantum_entanglement',
    config = { extra = { mult = 15 } },
    rarity = 1,
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
        if context.joker_main then
            local bonus = 0
            -- Check joker to the right
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i+1] then
                    local right_joker = G.jokers.cards[i+1]
                    if right_joker.ability.extra and type(right_joker.ability.extra) == 'table' then
                        -- Average all numeric values in extra
                        local sum, count = 0, 0
                        for _, v in pairs(right_joker.ability.extra) do
                            if type(v) == 'number' then
                                sum = sum + v
                                count = count + 1
                            end
                        end
                        if count > 0 then bonus = math.floor(sum / count) end
                    elseif type(right_joker.ability.extra) == 'number' then
                        bonus = right_joker.ability.extra
                    end
                end
            end
            
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult + bonus } },
                mult_mod = card.ability.extra.mult + bonus,
                colour = G.C.MULT
            }
        end
    end
})

-- 46. Salto Quântico
SMODS.Joker({
    key = 'j_quantum_quantum_leap',
    atlas = 'j_quantum_quantum_leap',
    config = { extra = { mult = 15, odyssey_debuff_adj = true } },
    rarity = 1,
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
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 47. Probabilidade
SMODS.Joker({
    key = 'j_quantum_probability',
    atlas = 'j_quantum_probability',
    config = { extra = { mult_per_common = 5 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.jokers then
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.rarity == 1 then count = count + 1 end
            end
        end
        return { vars = { count * card.ability.extra.mult_per_common } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.rarity == 1 then count = count + 1 end
            end
            local tot = count * card.ability.extra.mult_per_common
            if tot > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { tot } },
                    mult_mod = tot,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 48. Gato de Schrödinger
SMODS.Joker({
    key = 'j_quantum_schrodinger',
    atlas = 'j_quantum_schrodinger',
    config = { extra = { mult = 25, chips = 100, money = 5, odds = 4 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.chips, extra.money, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            ease_dollars(card.ability.extra.money)
            return {
                message = 'Superposto!',
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                colour = G.C.MULT
            }
        end
        
        if context.after and not context.blueprint and not context.repetition then
            if pseudorandom('schrodinger') < G.GAME.probabilities.normal / card.ability.extra.odds then
                if not card.ability.eternal then 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }))
                end
                return {
                    message = 'Colapsou!',
                    colour = G.C.FILTER
                }
            end
        end
    end
})

-- 49. Colapso de Onda
SMODS.Joker({
    key = 'j_quantum_wave_collapse',
    atlas = 'j_quantum_wave_collapse',
    config = { extra = { mult = 20, chips = 100, money = 5, mode = 1 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.chips, extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.mode = (card.ability.extra.mode % 3) + 1
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_val_up'), colour = G.C.FILTER })
        end
        
        if context.joker_main then
            if card.ability.extra.mode == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            elseif card.ability.extra.mode == 2 then
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            else
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 50. Tunelamento
SMODS.Joker({
    key = 'j_quantum_tunneling',
    atlas = 'j_quantum_tunneling',
    config = { extra = { mult = 15, odds = 20 } },
    rarity = 1,
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
        if context.discard and not context.blueprint and not context.repetition then
            if pseudorandom('tunneling') < G.GAME.probabilities.normal / card.ability.extra.odds then
                ease_discard(1)
                return {
                    message = localize('k_plus_discard'),
                    colour = G.C.BLUE
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

-- 51. Estado Quântico
SMODS.Joker({
    key = 'j_quantum_quantum_state',
    atlas = 'j_quantum_quantum_state',
    config = { extra = { mult = 15, x_mult = 1.5, mode = 1 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.x_mult, extra.mode } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.mode = (card.ability.extra.mode % 2) + 1
            if card.ability.extra.mode == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 52. Observador
SMODS.Joker({
    key = 'j_quantum_observer',
    atlas = 'j_quantum_observer',
    config = { extra = { x_mult = 2, active = true } },
    rarity = 1,
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
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.active = true
        end
        
        if context.joker_main and card.ability.extra.active then
            card.ability.extra.active = false
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 53. Antimatéria
SMODS.Joker({
    key = 'j_quantum_antimatter',
    atlas = 'j_quantum_antimatter',
    config = { extra = { mult = 0, gain = 10 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.repetition then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
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

-- 54. Entrelaçado
SMODS.Joker({
    key = 'j_quantum_entangled',
    atlas = 'j_quantum_entangled',
    config = { extra = { x_mult = 2.5 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for _, v in ipairs(G.jokers.cards) do
                if v.config.center.key == card.config.center.key then count = count + 1 end
            end
            
            if count >= 2 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 55. Spin Quântico
SMODS.Joker({
    key = 'j_quantum_quantum_spin',
    atlas = 'j_quantum_quantum_spin',
    config = { extra = { mult = 30, odds = 3 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('spin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 56. Partícula Virtual
SMODS.Joker({
    key = 'j_quantum_virtual_particle',
    atlas = 'j_quantum_virtual_particle',
    config = { extra = { x_mult = 3, rounds = 3 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.rounds, extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds <= 0 then
                if not card.ability.eternal then card:start_dissolve() end
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = card.ability.extra.rounds .. '', colour = G.C.FILTER })
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
