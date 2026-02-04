-- ============================================
-- SINGULARITY - Legendary (Jokers 39-40)
-- ============================================

-- 39. Singularidade Primordial
SMODS.Joker({
    key = 'j_singularity_primordial',
    atlas = 'j_singularity_primordial',
    config = { extra = { xmult = 25 } },
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
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
            if #G.jokers.cards == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 40. Big Bang Reverso
SMODS.Joker({
    key = 'j_singularity_reverse_big_bang',
    atlas = 'j_singularity_reverse_big_bang',
    config = { extra = { xmult = 10 } },
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
    end
})

