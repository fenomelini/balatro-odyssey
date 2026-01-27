-- ============================================
-- ECONOMY - Legendary (Jokers 599-600)
-- ============================================

-- 599: Mammon
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_mammon',
    discovered = true,
    config = { extra = { xmult = 5 } },
    rarity = 4,
    cost = 20,
    atlas = 'j_economy_mammon',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            local bonus = G.GAME.dollars or 0
            if bonus > 0 then
                ease_dollars(bonus)
                return {
                    message = localize('$') .. bonus,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 600: The Market's Hand
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_markets_hand',
    discovered = true,
    rarity = 4,
    cost = 20,
    atlas = 'j_economy_markets_hand',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_market_hand_active = (G.GAME.odyssey_market_hand_active or 0) + 1
        G.E_MANAGER:add_event(Event({func = function()
            if G.shop then
                G.shop.config.card_limit = G.shop.config.card_limit + 5
            end
            return true
        end}))
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_market_hand_active = (G.GAME.odyssey_market_hand_active or 1) - 1
        G.E_MANAGER:add_event(Event({func = function()
            if G.shop then
                G.shop.config.card_limit = G.shop.config.card_limit - 5
            end
            return true
        end}))
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
