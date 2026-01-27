-- ============================================
-- ECONOMY - Common (Jokers 551-570)
-- ============================================

-- 551: Piggy Bank
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_piggy_bank',
    discovered = true,
    config = { extra = { money = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_piggy_bank',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local dollars = (G.GAME.current_round.hands_left or 0) * card.ability.extra.money
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

-- 552: Angel Investor
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_angel_investor',
    discovered = true,
    config = { extra = { money = 2, gain = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_angel_investor',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money, extra.gain } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            ease_dollars(card.ability.extra.money)
            local ret = {
                message = localize('$') .. card.ability.extra.money,
                colour = G.C.MONEY
            }
            if not context.blueprint then
                card.ability.extra.money = card.ability.extra.money + card.ability.extra.gain
            end
            return ret
        end
    end
})

-- 553: Clearance Sale
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_clearance_sale',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_clearance_sale',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_clearance_sale = (G.GAME.odyssey_clearance_sale or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_clearance_sale = (G.GAME.odyssey_clearance_sale or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 554: Coupon
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_coupon',
    discovered = true,
    config = { extra = { active = true, last_ante = 0 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_coupon',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card) 
        return { vars = { ((card and card.ability.extra or self.config.extra).active and "Sim" or "Não") } } 
    end,
    calculate = function(self, card, context)
        -- Reset at new Ante
        if context.setting_blind and not context.blueprint then
            if (card.ability.extra.last_ante or 0) < G.GAME.round_resets.ante then
                card.ability.extra.last_ante = G.GAME.round_resets.ante
                card.ability.extra.active = true
            end
        end

        -- Consume when buying an item
        if (context.buying_card or context.buying_consumeable) and not context.blueprint and card.ability.extra.active then
            if not context.odyssey_coupon_consumed then
                card.ability.extra.active = false
                context.odyssey_coupon_consumed = true
                return {
                    message = "Livre!",
                    colour = G.C.GOLD
                }
            end
        end
    end
})

-- 555: Rebate
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_rebate',
    discovered = true,
    config = { extra = { money = 1, max = 5, current = 0 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_rebate',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money, extra.max, extra.current } }

    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card then
            if card.ability.extra.current < card.ability.extra.max then
                card.ability.extra.current = card.ability.extra.current + 1
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current = 0
        end
    end
})

-- 556: Service Fee
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_service_fee',
    discovered = true,
    config = { extra = { money = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_service_fee',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            ease_dollars(card.ability.extra.money)
            return {
                message = localize('$') .. card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
})

-- 557: Tip Jar
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_tip_jar',
    discovered = true,
    config = { extra = { money = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_tip_jar',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.scoring_hand == 1 then
            ease_dollars(card.ability.extra.money)
            return {
                message = localize('$') .. card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
})

-- 558: Black Market
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_black_market',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_black_market',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card) G.GAME.odyssey_black_market_active = (G.GAME.odyssey_black_market_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_black_market_active = (G.GAME.odyssey_black_market_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 559: Loan Shark
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_loan_shark',
    discovered = true,
    config = { extra = { money = 20, loss = 2 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_loan_shark',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money, extra.loss } }

    end,
    add_to_deck = function(self, card)
        ease_dollars(card.ability.extra.money)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            ease_dollars(-card.ability.extra.loss)
            return {
                message = "-" .. localize('$') .. card.ability.extra.loss,
                colour = G.C.RED
            }
        end
    end
})

-- 560: Inheritance
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_inheritance',
    discovered = true,
    config = { extra = { money = 10 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_inheritance',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card and (G.GAME.dollars or 0) <= 0 then
            ease_dollars(card.ability.extra.money)
            return {
                message = localize('$') .. card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
})

-- 561: Tithe
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_tithe',
    discovered = true,
    config = { extra = { mult = 10, threshold = 20 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_tithe',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if (G.GAME.dollars or 0) > card.ability.extra.threshold then
                local fee = math.floor((G.GAME.dollars or 0) * 0.1)
                if fee > 0 then
                    ease_dollars(-fee)
                    return {
                        message = "-" .. localize('$') .. fee,
                        colour = G.C.RED
                    }
                end
            end
        end
        if context.joker_main and (G.GAME.dollars or 0) > card.ability.extra.threshold then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- 562: Inflation
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_inflation',
    discovered = true,
    config = { extra = { x_mult = 2, cost_inc = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_inflation',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.cost_inc } }

    end,
    add_to_deck = function(self, card) G.GAME.odyssey_inflation_active = (G.GAME.odyssey_inflation_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_inflation_active = (G.GAME.odyssey_inflation_active or 0) - 1 end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- 563: Deflation
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_deflation',
    discovered = true,
    config = { extra = { chips = 50, cost_dec = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_deflation',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, extra.cost_dec } }

    end,
    add_to_deck = function(self, card) G.GAME.odyssey_deflation_active = (G.GAME.odyssey_deflation_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_deflation_active = (G.GAME.odyssey_deflation_active or 0) - 1 end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- 564: Pawn Shop
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_pawn_shop',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_pawn_shop',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card) G.GAME.odyssey_pawn_shop_active = (G.GAME.odyssey_pawn_shop_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_pawn_shop_active = (G.GAME.odyssey_pawn_shop_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 565: Treasure Hunt
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_treasure_hunt',
    discovered = true,
    config = { extra = { chance = 5, money = 5 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_treasure_hunt',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { G.GAME.probabilities.normal, extra.chance, extra.money } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                if pseudorandom('treasure_hunt') < G.GAME.probabilities.normal / card.ability.extra.chance then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = localize('$') .. card.ability.extra.money,
                        colour = G.C.MONEY,
                        card = card
                    }
                end
            end
        end
    end
})

-- 566: Gold Mine
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_gold_mine',
    discovered = true,
    config = { extra = { money = 2 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_gold_mine',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_emerald then
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

-- 567: Unionizer
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_unionizer',
    discovered = true,
    config = { extra = { money = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_unionizer',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local dollars = (#G.jokers.cards or 0) * card.ability.extra.money
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

-- 568: Accountant
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_accountant',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_accountant',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local d = G.GAME.dollars or 0
            if d % 5 == 0 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- 569: Auditor
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_auditor',
    discovered = true,
    config = { extra = { chips = 20, gain = 20 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_auditor',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, extra.gain } }

    end,
    add_to_deck = function(self, card) G.GAME.odyssey_auditor_active = (G.GAME.odyssey_auditor_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_auditor_active = (G.GAME.odyssey_auditor_active or 0) - 1 end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
             if not G.GAME.odyssey_money_spent_in_shop then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
             end
             G.GAME.odyssey_money_spent_in_shop = (G.GAME.odyssey_money_spent_in_shop or 0) - 1
        end
    end
})

-- 570: Capitalist
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_capitalist',
    discovered = true,
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_economy_capitalist',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    add_to_deck = function(self, card) G.GAME.odyssey_capitalist_active = (G.GAME.odyssey_capitalist_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_capitalist_active = (G.GAME.odyssey_capitalist_active or 0) - 1 end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

