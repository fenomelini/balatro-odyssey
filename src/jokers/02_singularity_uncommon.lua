-- ============================================
-- SINGULARITY - Uncommon (Jokers 17-30)
-- ============================================

-- 17. Singularidade Crescente
SMODS.Joker({
    key = 'j_singularity_growing_singularity',
    atlas = 'j_singularity_growing_singularity',
    config = { extra = { xmult = 1, xmult_gain = 0.2 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult, extra.xmult_gain .. '' } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if #G.jokers.cards == 1 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.MULT })
            end
        end
        
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
        return nil
    end
})

-- 18. Isolador Dimensional
SMODS.Joker({
    key = 'j_singularity_dimensional_isolator',
    atlas = 'j_singularity_dimensional_isolator',
    config = { extra = { mult = 50, xmult = 2 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            -- Encontra posição deste Joker
            local my_index = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_index = i
                    break
                end
            end
            
            if my_index then
                local has_left = my_index > 1
                local has_right = my_index < #G.jokers.cards
                
                -- Só ativa se NÃO tiver adjacentes EM AMBOS os lados
                -- (pode ter 1 lado vazio, mas não pode ter os 2 lados ocupados)
                if not (has_left and has_right) then
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        mult_mod = card.ability.extra.mult,
                        Xmult_mod = card.ability.extra.xmult,
                        colour = G.C.MULT
                    }
                end
            end
        end
        return nil
    end
})

-- 19. Única Esperança
SMODS.Joker({
    key = 'j_singularity_only_hope',
    atlas = 'j_singularity_only_hope',
    config = { extra = { xmult = 5 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G and G.GAME and G.GAME.current_round and 
               G.GAME.current_round.hands_left == 1 and 
               G.jokers and G.jokers.cards and #G.jokers.cards == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 20. Monólito
SMODS.Joker({
    key = 'j_singularity_monolith',
    atlas = 'j_singularity_monolith',
    config = { extra = { xmult = 2.5, takes_slots = 2 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        -- Reduz limite de slots quando adicionado
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        -- Restaura slot quando removido
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
    end
})

-- 21. Solidificação
SMODS.Joker({
    key = 'j_singularity_solidification',
    atlas = 'j_singularity_solidification',
    config = { extra = { xmult = 2.5, rounds_required = 5, current_rounds = 0, last_pos = nil } },
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

    
        return { vars = { extra.current_rounds, extra.rounds_required, extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        -- Verifica posição no início de cada rodada
        if context.end_of_round and not context.repetition and not context.other_card then
            -- Encontra posição atual
            local current_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    current_pos = i
                    break
                end
            end
            
            if current_pos and card.ability.extra.last_pos == current_pos then
                card.ability.extra.current_rounds = card.ability.extra.current_rounds + 1
            else
                card.ability.extra.current_rounds = 0
                card.ability.extra.last_pos = current_pos
            end
            
            if card.ability.extra.current_rounds >= card.ability.extra.rounds_required then
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Solidificado!', colour = G.C.MULT })
            end
        end
        
        if context.joker_main and card.ability.extra.current_rounds >= card.ability.extra.rounds_required then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end
})

-- 22. Universo Paralelo
SMODS.Joker({
    key = 'j_singularity_parallel_universe',
    atlas = 'j_singularity_parallel_universe',
    config = { extra = { mult = 20 } },
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
        
        -- No fim da rodada, se houver apenas 1, cria cópia
        if context.end_of_round and not context.repetition and not context.other_card then
            local count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.name == card.ability.name then
                    count = count + 1
                end
            end
            
            if count == 1 and #G.jokers.cards < G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local copy = copy_card(card, nil)
                        copy:add_to_deck()
                        G.jokers:emplace(copy)
                        return true
                    end
                }))
                return {
                    message = 'Espelhado!',
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 23. Ponto Zero
SMODS.Joker({
    key = 'j_singularity_point_zero',
    atlas = 'j_singularity_point_zero',
    config = { extra = { xmult = 3 } },
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

    
        return { vars = { extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.dollars == 0 and #G.jokers.cards == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 24. Singularidade Negra
SMODS.Joker({
    key = 'j_singularity_black_singularity',
    atlas = 'j_singularity_black_singularity',
    config = { extra = { mult = 0, gain = 5 } },
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

    
        return { vars = { extra.mult, extra.gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' and context.card ~= card then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
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

-- 25. Estrela Solitária
SMODS.Joker({
    key = 'j_singularity_lonely_star',
    atlas = 'j_singularity_lonely_star',
    config = { extra = { xmult = 1, gain = 0.2 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult, extra.gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card and #G.jokers.cards == 1 then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end
})

-- 26. Individualismo
SMODS.Joker({
    key = 'j_singularity_individualism',
    atlas = 'j_singularity_individualism',
    config = { extra = { mult = 50 } },
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

-- 27. Vazio Primordial
SMODS.Joker({
    key = 'j_singularity_primordial_void',
    atlas = 'j_singularity_primordial_void',
    config = { extra = { xmult = 1, base_xmult = 5 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        if G.jokers and not from_debuff then
            local destroyed = false
            for i = #G.jokers.cards, 1, -1 do
                if G.jokers.cards[i] ~= card then
                    G.jokers.cards[i]:start_dissolve()
                    destroyed = true
                end
            end
            if destroyed then
                card.ability.extra.xmult = card.ability.extra.base_xmult
            end
        end
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end
})

-- 28. Isolamento Quântico
SMODS.Joker({
    key = 'j_singularity_quantum_isolation',
    atlas = 'j_singularity_quantum_isolation',
    config = { extra = { mult = 20, chance = 4 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.chance } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            if #G.jokers.cards == 1 and pseudorandom('quantum_isolation') < G.GAME.probabilities.normal / card.ability.extra.chance then
                if #G.jokers.cards < G.jokers.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copy = copy_card(card, nil)
                            copy:add_to_deck()
                            G.jokers:emplace(copy)
                            return true
                        end
                    }))
                    return {
                        message = 'Duplicado!',
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
})

-- 29. Monopólio Cósmico
SMODS.Joker({
    key = 'j_singularity_cosmic_monopoly',
    atlas = 'j_singularity_cosmic_monopoly',
    config = { extra = { xmult = 3 } },
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

    
        return { vars = { extra.xmult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local same_rarity = true
            local first_rarity = nil
            for i = 1, #G.jokers.cards do
                local r = G.jokers.cards[i].config.center.rarity
                if not first_rarity then
                    first_rarity = r
                elseif first_rarity ~= r then
                    same_rarity = false
                    break
                end
            end
            
            if same_rarity and #G.jokers.cards > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 30. Singularidade Reversa
SMODS.Joker({
    key = 'j_singularity_reverse_singularity',
    atlas = 'j_singularity_reverse_singularity',
    config = { extra = { xmult_reduction = 0.8 } },
    rarity = 2,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local joker_count = G.jokers and #G.jokers.cards or 0
        local total_xmult = ( (card and card.ability and card.ability.extra) or self.config.extra ).xmult_reduction ^ joker_count
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).xmult_reduction, joker_count, total_xmult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local joker_count = #G.jokers.cards
            local total_xmult = card.ability.extra.xmult_reduction ^ joker_count
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { total_xmult } },
                Xmult_mod = total_xmult,
                colour = G.C.MULT
            }
        end
    end
})

