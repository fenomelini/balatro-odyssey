-- J999-1000: Final & Specials (Legendary)

-- The Creator (J999)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_final_the_creator',
    config = { extra = { x_mult = 100 } },
    rarity = 4,
    atlas = 'j_final_the_creator',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            for k, v in ipairs(G.jokers.cards) do
                if not v.edition then v:set_edition({polychrome = true}) end
            end
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Odyssey (J1000)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_final_odyssey',
    rarity = 4,
    atlas = 'j_final_odyssey',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.GAME and G.GAME.jokers_encountered then
            for _ in pairs(G.GAME.jokers_encountered) do count = count + 1 end
        end
        return { vars = { count } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.GAME and G.GAME.jokers_encountered then
                for _ in pairs(G.GAME.jokers_encountered) do count = count + 1 end
            end
            if count > 0 then
                return {
                    x_mult = count,
                    message = "X" .. count,
                    colour = G.C.MULT
                }
            end
        end
    end
})
