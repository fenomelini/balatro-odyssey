-- ============================================
-- CELESTIAL - Legendary (Jokers 199-200)
-- ============================================

-- 199. Gerador de Universos
SMODS.Joker({
    key = 'j_celestial_universe_generator',
    rarity = 4,
    atlas = 'j_celestial_universe_generator',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local legendary = create_card('Joker', G.jokers, true, 4, nil, nil, nil, 'celestial_universe_generator')
                    legendary:add_to_deck()
                    G.jokers:emplace(legendary)
                    if not card.ability.eternal then card:start_dissolve() end
                    return true
                end
            }))
            return {
                message = localize('k_universe'),
                colour = G.C.LEGENDARY
            }
        end
    end
})

-- 200. Entidade Cósmica
SMODS.Joker({
    key = 'j_celestial_cosmic_entity',
    config = { extra = { x_mult = 4 } },
    rarity = 4,
    atlas = 'j_celestial_cosmic_entity',
    pos = { x = 0, y = 0 },
    cost = 20,
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
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end
    end
})
