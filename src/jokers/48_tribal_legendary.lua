SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_king_of_kings',
    discovered = true,
    config = { extra = { x_mult = 5 } },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_king_of_kings',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    add_to_deck = function(self, card)
        G.GAME.odyssey_king_of_kings_active = (G.GAME.odyssey_king_of_kings_active or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_king_of_kings_active = (G.GAME.odyssey_king_of_kings_active or 0) - 1
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_god_of_war',
    discovered = true,
    config = { extra = { x_mult = 5, scaling = 1 } },
    rarity = 4,
    cost = 20,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_god_of_war',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult, extra.scaling } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.after_hand and not context.blueprint and not context.other_card then
            local count = #context.scoring_hand
            if count > 0 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + (count * card.ability.extra.scaling)
                for i = 1, #context.scoring_hand do
                    context.scoring_hand[i]:start_dissolve()
                end
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end
    end
})
