----------------------------------------------
-- SOCIAL & META (LEGENDARY) J849-J850
----------------------------------------------

-- J849 The Player
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_the_player',
    config = { extra = { x_mult = 5, mode = 1 } },
    rarity = 4,
    atlas = 'j_social_the_player',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local modes = {"X5 Mult", "+500 Chips", "+100 Mult", "$5 per hand"}
        return { vars = { (card and card.ability.extra or self.config.extra).x_mult, modes[(card and card.ability.extra or self.config.extra).mode] } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.mode == 1 then
                return { x_mult = 5, message = "X5" }
            elseif card.ability.extra.mode == 2 then
                return { chip_mod = 500, message = "+500" }
            elseif card.ability.extra.mode == 3 then
                return { mult_mod = 100, message = "+100" }
            elseif card.ability.extra.mode == 4 then
                 ease_dollars(5)
                 return { message = "$$$", colour = G.C.MONEY }
            end
        end
        if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
            card.ability.extra.mode = (card.ability.extra.mode % 4) + 1
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "SWITCH!", colour = G.C.PURPLE})
        end
    end
})

-- J850 LocalThunk
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_localthunk',
    config = { extra = { x_mult = 10 } },
    rarity = 4,
    atlas = 'j_social_localthunk',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                for k, v in ipairs(G.jokers.cards) do
                    if v ~= card and not v.edition then
                         v:set_edition({polychrome = true}, true)
                    end
                end
            end
            return {
                x_mult = card.ability.extra.x_mult,
                message = "THANKS!",
                colour = G.C.GOLD
            }
        end
    end
})
