-- ============================================
-- SINGULARITY - Rare (Jokers 31-38)
-- ============================================

-- 31. Buraco Negro
SMODS.Joker({
    key = 'j_singularity_black_hole',
    atlas = 'j_singularity_black_hole',
    config = { extra = { mult = 0, gain = 10, last_ante = 0 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 10,
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
        if context.end_of_round and not context.repetition and not context.other_card and G.GAME.blind.boss then
            local targets = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal then
                    table.insert(targets, G.jokers.cards[i])
                end
            end
            
            if #targets > 0 then
                local target = pseudorandom_element(targets, pseudoseed('black_hole'))
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                target:start_dissolve()
                return {
                    message = 'Absorvido!',
                    colour = G.C.MULT
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

-- 32. Singularidade Absoluta
SMODS.Joker({
    key = 'j_singularity_absolute_singularity',
    atlas = 'j_singularity_absolute_singularity',
    config = { extra = { xmult = 10 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 20,
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
            local legendary_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity == 4 then
                    legendary_count = legendary_count + 1
                end
            end
            
            if legendary_count == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 33. Ponto de Não Retorno
SMODS.Joker({
    key = 'j_singularity_point_of_no_return',
    atlas = 'j_singularity_point_of_no_return',
    config = { extra = { xmult = 1, gain_per_destroyed = 5 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 15,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult, extra.gain_per_destroyed } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        if G.jokers and not from_debuff then
            local count = 0
            for i = #G.jokers.cards, 1, -1 do
                if G.jokers.cards[i] ~= card then
                    G.jokers.cards[i]:start_dissolve()
                    count = count + 1
                end
            end
            card.ability.extra.xmult = 1 + (count * card.ability.extra.gain_per_destroyed)
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

-- 34. Colapso Estelar
SMODS.Joker({
    key = 'j_singularity_stellar_collapse',
    atlas = 'j_singularity_stellar_collapse',
    config = { extra = { } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' and context.card ~= card then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'collapse')
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Spectral!', colour = G.C.SECONDARY_SET.Spectral })
            end
        end
    end
})

-- 35. Singularidade Temporal
SMODS.Joker({
    key = 'j_singularity_temporal_singularity',
    atlas = 'j_singularity_temporal_singularity',
    config = { extra = { repetitions = 2 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 14,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.repetitions } }

    
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and #G.jokers.cards == 1 then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.repetitions,
                card = card
            }
        end
    end
})

-- 36. Vácuo Perfeito
SMODS.Joker({
    key = 'j_singularity_perfect_vacuum',
    atlas = 'j_singularity_perfect_vacuum',
    config = { extra = { chips = 100 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and #G.jokers.cards == 1 then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
})

-- 37. Singularidade Inversa
SMODS.Joker({
    key = 'j_singularity_inverse_singularity',
    atlas = 'j_singularity_inverse_singularity',
    config = { extra = { xmult = 3 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 12,
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
            if G.GAME.chips < G.GAME.blind.chips then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 38. Ponto Ômega
SMODS.Joker({
    key = 'j_singularity_omega_point',
    atlas = 'j_singularity_omega_point',
    config = { extra = { xmult_base = 1, gain = 0.5 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 14,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local current_xmult = 1 + (G.GAME.hands_played * ( (card and card.ability and card.ability.extra) or self.config.extra ).gain)
        return { vars = { current_xmult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and #G.jokers.cards == 1 then
            local current_xmult = 1 + (G.GAME.hands_played * card.ability.extra.gain)
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { current_xmult } },
                Xmult_mod = current_xmult,
                colour = G.C.MULT
            }
        end
    end
})
