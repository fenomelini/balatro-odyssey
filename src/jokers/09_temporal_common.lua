-- ============================================
-- TEMPORAL - Common (Jokers 81-96)
-- ============================================

-- 81. Bifurcação
SMODS.Joker({
    key = 'j_temporal_bifurcation',
    config = { extra = { x_mult = 1.5 } },
    atlas = 'j_temporal_bifurcation',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 82. Sobreposição
SMODS.Joker({
    key = 'j_temporal_overlap',
    config = { extra = { mult = 20 } },
    atlas = 'j_temporal_overlap',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
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

-- 83. Camadas
SMODS.Joker({
    key = 'j_temporal_layers',
    config = { extra = { x_mult = 1.5 } },
    atlas = 'j_temporal_layers',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 84. Planolândia
SMODS.Joker({
    key = 'j_temporal_flatland',
    config = { extra = { mult_per = 4 } },
    atlas = 'j_temporal_flatland',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local hand_cards = 0
        if G.hand and G.hand.cards then
            hand_cards = #G.hand.cards
        end
        return { vars = { hand_cards * card.ability.extra.mult_per, card.ability.extra.mult_per } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local hand_cards = 0
            if G.hand and G.hand.cards then
                hand_cards = #G.hand.cards
            end
            
            local mult = hand_cards * card.ability.extra.mult_per
            
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

-- 85. Vazio Entre Mundos
SMODS.Joker({
    key = 'j_temporal_void_between_worlds',
    config = { extra = { mult_per = 10 } },
    atlas = 'j_temporal_void_between_worlds',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        if G and G.jokers and G.jokers.config and G.jokers.cards then
            local empty_slots = G.jokers.config.card_limit - #G.jokers.cards
            return { vars = { empty_slots * (card and card.ability.extra or self.config.extra).mult_per, (card and card.ability.extra or self.config.extra).mult_per } }
        end
        return { vars = { 0, card.ability.extra.mult_per } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G and G.jokers and G.jokers.config and G.jokers.cards then
                local empty_slots = G.jokers.config.card_limit - #G.jokers.cards
                local total_mult = empty_slots * card.ability.extra.mult_per
                if total_mult > 0 then
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { total_mult } },
                        mult_mod = total_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
})

-- 86. Dimensão Extra
SMODS.Joker({
    key = 'j_temporal_extra_dimension',
    config = { extra = { mult = 10 } },
    atlas = 'j_temporal_extra_dimension',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.mult } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end
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

-- 87. Multiverso
SMODS.Joker({
    key = 'j_temporal_multiverse',
    config = { extra = { x_mult = 1.5 } },
    atlas = 'j_temporal_multiverse',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 88. Fenda
SMODS.Joker({
    key = 'j_temporal_rift',
    config = { extra = { mult = 50 } },
    atlas = 'j_rift',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
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
        return nil
    end
})

-- 89. Board Circular
SMODS.Joker({
    key = 'j_temporal_circular_board',
    config = { extra = { x_mult = 1.5 } },
    atlas = 'j_temporal_circular_board',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 90. Reino das Sombras
SMODS.Joker({
    key = 'j_temporal_shadow_realm',
    config = { extra = { mult_per = 5, shadow_cards = 0 } },
    atlas = 'j_temporal_shadow_realm',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.shadow_cards, extra.mult_per } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.shadow_cards = card.ability.extra.shadow_cards + 1
        end
        
        if context.joker_main and card.ability.extra.shadow_cards > 0 then
            local total_mult = card.ability.extra.shadow_cards * card.ability.extra.mult_per
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { total_mult } },
                mult_mod = total_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 91. Nexus Dimensional
SMODS.Joker({
    key = 'j_temporal_dimensional_nexus',
    config = { extra = { x_mult = 2 } },
    atlas = 'j_temporal_dimensional_nexus',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 92. Dimensão de Bolso
SMODS.Joker({
    key = 'j_temporal_pocket_dimension',
    config = { extra = { mult_per = 10, stored_cards = 0 } },
    atlas = 'j_temporal_pocket_dimension',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.stored_cards * extra.mult_per, extra.mult_per } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.stored_cards = card.ability.extra.stored_cards + 1
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Guardado!', colour = G.C.PURPLE })
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.stored_cards = 0
        end
        
        if context.joker_main then
            local total_mult = card.ability.extra.stored_cards * card.ability.extra.mult_per
            if total_mult > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { total_mult } },
                    mult_mod = total_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 93. Mudança de Fase
SMODS.Joker({
    key = 'j_temporal_phase_shift',
    config = { extra = { x_mult = 2, active = true } },
    atlas = 'j_temporal_phase_shift',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = (card and card.ability.extra or self.config.extra)

    
        return { vars = { extra.x_mult, extra.active and localize('k_active_ex') or localize('k_inactive_ex') } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.active then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        
        if context.after and not context.blueprint then
            card.ability.extra.active = not card.ability.extra.active
            local status = card.ability.extra.active and 'Sólido!' or 'Fantasma!'
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = status, colour = G.C.FILTER })
        end
    end
})

-- 94. Espaço Negativo
SMODS.Joker({
    key = 'j_temporal_negative_space',
    config = { extra = { mult = 15 } },
    atlas = 'j_temporal_negative_space',
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
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

-- 95. Plano Astral
SMODS.Joker({
    key = 'j_temporal_astral_plane',
    config = { extra = { x_mult = 2 } },
    atlas = 'j_temporal_astral_plane',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 96. Convergência
SMODS.Joker({
    key = 'j_temporal_convergence',
    config = { extra = { x_mult = 2.5 } },
    atlas = 'j_temporal_convergence',
    rarity = 1,
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
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})