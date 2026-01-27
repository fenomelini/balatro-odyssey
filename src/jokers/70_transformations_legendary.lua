----------------------------------------------
-- TRANSFORMATIONS (LEGENDARY) J799-J800
----------------------------------------------

-- J799 The Changeling
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_the_changeling',
    config = { extra = { copied_key = nil } },
    rarity = 4,
    atlas = 'j_transformations_the_changeling',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.copied_key or 'None' } }

    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local legendary_keys = {}
            for k, v in pairs(G.P_CENTERS) do
                if v.set == 'Joker' and v.rarity == 4 and k ~= 'j_transformations_the_changeling' then
                    table.insert(legendary_keys, k)
                end
            end
            card.ability.extra.copied_key = legendary_keys[math.random(#legendary_keys)]
            return {
                message = "Copied " .. card.ability.extra.copied_key,
                colour = G.C.PURPLE
            }
        end

        if card.ability.extra.copied_key then
            local other_joker = G.P_CENTERS[card.ability.extra.copied_key]
            if other_joker and other_joker.calculate then
                return other_joker:calculate(card, context)
            end
        end
    end
})

-- J800 Proteus
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_proteus',
    config = { extra = { x_mult = 1, hand_types = {} } },
    rarity = 4,
    atlas = 'j_transformations_proteus',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult, #extra.hand_types } }

    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local hand_type = context.scoring_name
            if hand_type and not card.ability.extra.hand_types[hand_type] then
                card.ability.extra.hand_types[hand_type] = true
                card.ability.extra.x_mult = card.ability.extra.x_mult + 0.5
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})
