-- ============================================
-- QUANTUM - Legendary (Jokers 79-80)
-- ============================================

-- 79. Planos Superiores
SMODS.Joker({
    key = 'j_quantum_higher_planes',
    atlas = 'j_quantum_higher_planes',
    config = { extra = { mult = 100 } },
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
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

-- 80. Hiperespaço
SMODS.Joker({
    key = 'j_quantum_hyperspace',
    atlas = 'j_quantum_hyperspace',
    config = { extra = { mult_per_card = 15, max_cards = 5 } },
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )
        return { vars = { extra.mult_per_card, extra.max_cards } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local count = math.min(#(context.scoring_hand or {}), card.ability.extra.max_cards)
            local mult = count * card.ability.extra.mult_per_card
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
