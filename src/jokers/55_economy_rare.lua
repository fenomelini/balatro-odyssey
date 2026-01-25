-- ============================================
-- ECONOMY - Rare (Jokers 589-598)
-- ============================================

-- 589: The Great Depression
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_the_great_depression',
    discovered = true,
    config = { extra = { xmult = 1, lost = 0 } },
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_the_great_depression',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.xmult, extra.lost } }

    end,
    add_to_deck = function(self, card)
        local loss = G.GAME.dollars or 0
        G.GAME.dollars = 0
        card.ability.extra.lost = loss
        card.ability.extra.xmult = 1 + math.floor(loss / 5)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 590: Midas
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_midas',
    discovered = true,
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_midas',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    v:set_ability(G.P_CENTERS.m_odyssey_plastic, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
        end
    end
})

-- 591: Philosopher's Stone
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_philosophers_stone',
    discovered = true,
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_philosophers_stone',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.discard and not context.other_card then
            -- Note: context.other_card is nil if multiple cards are discarded?
            -- Steamodded calls calculate for EACH card discarded if it's context.discard.
            -- Wait, if I want to target the card being discarded, I should check context.other_card.
        end
        if context.discard and context.other_card then
            context.other_card:set_ability(G.P_CENTERS.m_odyssey_plastic, nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_card:juice_up()
                    return true
                end
            }))
        end
    end
})

-- 592: Money Printer
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_money_printer',
    discovered = true,
    config = { extra = { chance = 3 } },
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_money_printer',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.blueprint then
            if pseudorandom('money_printer') < G.GAME.probabilities.normal / card.ability.extra.chance then
                local amt = G.GAME.odyssey_banker_money or 0
                if amt > 0 then
                    ease_dollars(amt)
                    return {
                        message = localize('$') .. amt,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end
})

-- 593: Central Bank
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_central_bank',
    discovered = true,
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_central_bank',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.interest_cap = 50
    end,
    remove_from_deck = function(self, card)
        G.GAME.interest_cap = 5
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 594: Mercenary
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_mercenary',
    discovered = true,
    config = { extra = { xmult = 5, cost = 1 } },
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_mercenary',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.xmult, extra.cost } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local fee = card.ability.extra.cost * #context.scoring_hand
            if fee > 0 then
                ease_dollars(-fee)
            end
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 595: Make it Rain
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_make_it_rain',
    discovered = true,
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_make_it_rain',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
             local hand_chips = G.GAME.hands[context.scoring_name].chips
             local hand_mult = G.GAME.hands[context.scoring_name].mult
             local excess_mult = math.floor(hand_mult - (G.GAME.blind.chips / hand_chips))
             if excess_mult > 0 then
                 ease_dollars(excess_mult)
                 return {
                     message = localize('$') .. excess_mult,
                     colour = G.C.MONEY
                 }
             end
        end
    end
})

-- 596: Blood Diamond
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_blood_diamond',
    discovered = true,
    config = { extra = { money = 50 } },
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_blood_diamond',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.money } }

    end,
    add_to_deck = function(self, card)
        ease_dollars(card.ability.extra.money)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_hands_played(-1)
    end,
    remove_from_deck = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_hands_played(1)
    end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 597: Fool's Gold
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_fools_gold',
    discovered = true,
    config = { extra = { mult = 50 } },
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_fools_gold',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_fools_gold_active = (G.GAME.odyssey_fools_gold_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_fools_gold_active = (G.GAME.odyssey_fools_gold_active or 1) - 1 end,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_plastic then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 598: Utopia
SMODS.Joker({
    unlocked = true,
    key = 'j_economy_utopia',
    discovered = true,
    rarity = 3,
    cost = 8,
    atlas = 'j_economy_utopia',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_utopia_active = (G.GAME.odyssey_utopia_active or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_utopia_active = (G.GAME.odyssey_utopia_active or 1) - 1
    end,
    calculate = function(self, card, context)
        if context.buy_card and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = "Used!",
                colour = G.C.RED
            }
        end
    end
})
