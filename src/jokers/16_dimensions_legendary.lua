-- ============================================
-- DIMENSIONS - Legendary (Jokers 159-160)
-- ============================================

-- 159. Mestre do Espaço
SMODS.Joker({
    key = 'j_dimensions_master_of_space',
    config = { extra = {} },
    rarity = 4,
    atlas = 'j_dimensions_master_of_space',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    -- Logic handled in overrides or context.before
    calculate = function(self, card, context)
        -- Placeholder for visual feedback
        if context.joker_main then
            return {
                message = localize('k_active_ex'),
                colour = G.C.PURPLE
            }
        end
    end
})

-- 160. Onidimensional
SMODS.Joker({
    key = 'j_dimensions_omnidimensional',
    config = { extra = { xmult = 5 } },
    rarity = 4,
    atlas = 'j_dimensions_omnidimensional',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    add_to_deck = function(self, card, from_debuff)
        ease_ante(-1)
    end,
    
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
