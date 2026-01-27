----------------------------------------------
-- PROFESSIONS GROUP (LEGENDARY)
----------------------------------------------

-- 549. Guild Master
SMODS.Joker({
    key = 'j_professions_guild_master',
    atlas = 'j_professions_guild_master',
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3, gain = 0.5 } },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.gain } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.jokers and G.jokers.cards then
                for _, j in ipairs(G.jokers.cards) do
                    if j.config.center.key:find('professions') then
                        count = count + 1
                    end
                end
            end
            local total_xmult = card.ability.extra.x_mult + (count * card.ability.extra.gain)
            return { x_mult = total_xmult, message = localize{type='variable',key='a_xmult',vars={total_xmult}} }
        end
    end
})

-- 550. Tycoon
SMODS.Joker({
    key = 'j_professions_tycoon',
    atlas = 'j_professions_tycoon',
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 5, huge_mult = 10, threshold = 100 } },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.huge_mult, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local mult = card.ability.extra.x_mult
            if G.GAME.dollars >= card.ability.extra.threshold then
                mult = card.ability.extra.huge_mult
            end
             return { x_mult = mult, message = localize{type='variable',key='a_xmult',vars={mult}} }
        end
    end
})

