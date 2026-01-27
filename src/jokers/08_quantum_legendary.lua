-- ============================================
-- QUANTUM - Legendary (Jokers 79-80)
-- ============================================

-- 79. Planos Superiores
SMODS.Joker({
    key = 'j_quantum_higher_planes',
    atlas = 'j_quantum_higher_planes',
    config = { extra = { x_mult = 3, odds = 2 } },
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local normal_prob = G.GAME and G.GAME.probabilities and G.GAME.probabilities.normal or 1
        return { vars = { (card and card.ability.extra or self.config.extra).x_mult, '' .. normal_prob, (card and card.ability.extra or self.config.extra).odds } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('higher_planes') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            else
                -- The other state: +100 Mult
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { 100 } },
                    mult_mod = 100,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 80. Hiperespaço
SMODS.Joker({
    key = 'j_quantum_hyperspace',
    atlas = 'j_quantum_hyperspace',
    config = { extra = { x_mult = 10 } },
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
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
