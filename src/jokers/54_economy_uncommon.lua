-- ============================================
-- ECONOMY - Uncommon (Jokers 571-588)
-- ============================================

-- 571: Invisible Hand
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_invisible_hand',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_invisible_hand',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    config = { extra = { x_mult = 1.5 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and (G.GAME.dollars or 0) < 5 then
            return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
        end
    end
})

-- 572: Economic Bubble
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_economic_bubble',
    discovered = false,
    config = { extra = { money = 5, threshold = 50 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_economic_bubble',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if (G.GAME.dollars or 0) >= card.ability.extra.threshold then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.dollars = 0
                        if not card.ability.eternal then card:start_dissolve() end
                        return true
                    end
                }))
                return {
                    message = "POP!",
                    colour = G.C.RED
                }
            else
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 573: Cryptocurrency
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_cryptocurrency',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_cryptocurrency',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            -- The sell value of this Joker fluctuates randomly between $0 and $50 each round.
            local new_val = math.floor(pseudorandom('crypto') * 50)
            card.sell_cost = new_val
        end
    end
})

-- 574: Income Tax
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_income_tax',
    discovered = false,
    config = { extra = { xmult = 3, tax = 0.2 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_income_tax',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.xmult, extra.tax * 100 } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local tax = math.floor((G.GAME.dollars or 0) * card.ability.extra.tax)
            if tax > 0 then
                ease_dollars(-tax)
            end
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 575: Money Laundering
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_money_laundering',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_money_laundering',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    config = { extra = { mult = 20 } },
    add_to_deck = function(self, card) G.GAME.odyssey_money_laundering_active = (G.GAME.odyssey_money_laundering_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_money_laundering_active = (G.GAME.odyssey_money_laundering_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_plastic then
                return { mult = card.ability.extra.mult, card = card }
            end
        end
    end
})

-- 576: Bribery
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_bribery',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_bribery',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card) G.GAME.odyssey_bribery_active = (G.GAME.odyssey_bribery_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_bribery_active = (G.GAME.odyssey_bribery_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 577: Hedge Fund
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_hedge_fund',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_hedge_fund',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local dollars = math.floor((G.GAME.dollars or 0) / 10)
            if dollars > 0 then
                ease_dollars(dollars)
                return {
                    message = localize('$') .. dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 578: Monopoly
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_monopoly',
    discovered = false,
    config = { extra = { money = 10 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_monopoly',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local gold_count = 0
            if G.hand and G.hand.cards then
                for k, v in ipairs(G.hand.cards) do
                    if v.config.center == G.P_CENTERS.m_odyssey_plastic then
                        gold_count = gold_count + 1
                    end
                end
            end
            if gold_count >= 3 then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 579: Recession
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_recession',
    discovered = false,
    config = { extra = { xmult = 4 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_recession',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and (G.GAME.dollars or 0) <= 0 then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 580: Stimulus Package
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_stimulus_package',
    discovered = false,
    config = { extra = { money = 10, threshold = 10 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_stimulus_package',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.entering_shop then
            if (G.GAME.dollars or 0) < card.ability.extra.threshold then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 581: Lottery
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_lottery',
    discovered = false,
    config = { extra = { chance = 100, money = 100 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_lottery',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal, extra.chance, extra.money } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if pseudorandom('lottery') < G.GAME.probabilities.normal / card.ability.extra.chance then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 582: Insurance
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_insurance',
    discovered = false,
    config = { extra = { money = 20 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_insurance',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_insurance_active = (G.GAME.odyssey_insurance_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_insurance_active = (G.GAME.odyssey_insurance_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 583: Retirement
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_retirement',
    discovered = false,
    config = { extra = { gain = 1 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_retirement',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.gain } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.gain
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
})

-- 584: Venture Capital
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_venture_capital',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_venture_capital',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.dollars >= 10 then
                ease_dollars(-10)
                if pseudorandom('venture') < 0.5 then
                    ease_dollars(30)
                    return {
                        message = localize('$') .. "30",
                        colour = G.C.MONEY
                    }
                else
                    return {
                        message = "Fail!",
                        colour = G.C.RED
                    }
                end
            end
        end
    end
})

-- 585: Credit Card
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_credit_card_2',
    discovered = false,
    config = { extra = 20 },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_credit_card_2',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card) G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra end,
    remove_from_deck = function(self, card) G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 586: Compound Interest
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_compound_interest',
    discovered = false,
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_compound_interest',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            G.GAME.interest_cap = G.GAME.interest_cap + 5
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
})

-- 587: Day Trader
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_day_trader',
    discovered = false,
    config = { extra = 2 },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_day_trader',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_day_trader_active = (G.GAME.odyssey_day_trader_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_day_trader_active = (G.GAME.odyssey_day_trader_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 588: Oil Tycoon
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_oil_tycoon',
    discovered = false,
    config = { extra = { money = 1 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_economy_oil_tycoon',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Spades') or context.other_card:is_suit('Clubs') then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})
