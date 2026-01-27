-- ============================================
-- PROBABILITY AND LUCK - Rare & Legendary (739-750)
-- ============================================

-- 739. Goddess of Fortune
SMODS.Joker({
    key = 'j_luck_and_probability_goddess_of_fortune',
    rarity = 3,
    atlas = 'j_luck_and_probability_goddess_of_fortune',
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal + 10 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal - 10 end
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 740. Controlled Chaos
SMODS.Joker({
    key = 'j_luck_and_probability_controlled_chaos',
    rarity = 3,
    atlas = 'j_luck_and_probability_controlled_chaos',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal + 2 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal - 2 end
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 741. Infinite Luck
SMODS.Joker({
    key = 'j_luck_and_probability_infinite_luck',
    config = { extra = { money = 20, mult = 20 } },
    rarity = 3,
    atlas = 'j_luck_and_probability_infinite_luck',
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_force_success = (G.GAME.odyssey_force_success or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_force_success = (G.GAME.odyssey_force_success or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 742. Improbability
SMODS.Joker({
    key = 'j_luck_and_probability_improbability',
    config = { extra = { xmult = 3, odds = 100 } },
    rarity = 3,
    atlas = 'j_luck_and_probability_improbability',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('improb') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for k, v in ipairs(G.jokers.cards) do v:start_dissolve() end
                        return true
                    end
                }))
                return { message = "IMPROBABLE!", colour = G.C.BLACK }
            end
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).xmult, G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ).odds } } end
})

-- 743. Zero Entropy
SMODS.Joker({
    key = 'j_luck_and_probability_zero_entropy',
    config = { extra = { money = 1000, odds = 1000 } },
    rarity = 3,
    atlas = 'j_luck_and_probability_zero_entropy',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.blueprint then
            if pseudorandom('entropy') < G.GAME.probabilities.normal / card.ability.extra.odds then
                ease_dollars(card.ability.extra.money)
                return { message = "JACKPOT!", colour = G.C.GOLD }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ).odds, ( (card and card.ability and card.ability.extra) or self.config.extra ).money } } end
})

-- 744. The Chosen One
SMODS.Joker({
    key = 'j_luck_and_probability_the_chosen_one',
    config = { extra = 5 },
    rarity = 3,
    atlas = 'j_luck_and_probability_the_chosen_one',
    pos = { x = 0, y = 0 },
    cost = 15,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_glass_protection = (G.GAME.odyssey_glass_protection or 0) + 1
        G.GAME.odyssey_force_success = (G.GAME.odyssey_force_success or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_glass_protection = (G.GAME.odyssey_glass_protection or 0) - 1
        G.GAME.odyssey_force_success = (G.GAME.odyssey_force_success or 0) - 1
    end,
    calculate = function(self, card, context)
        if context.joker_main then return { Xmult = card.ability.extra } end
    end
})

-- 745. Holy Grail
SMODS.Joker({
    key = 'j_luck_and_probability_holy_grail',
    config = { extra = { xmult = 3, money = 10 } },
    rarity = 3,
    atlas = 'j_luck_and_probability_holy_grail',
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}}
            }
        end
        if context.end_of_round and not context.other_card and not context.blueprint then
            ease_dollars(card.ability.extra.money)
            return { message = localize('$')..card.ability.extra.money, colour = G.C.MONEY }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).xmult, (( (card and card.ability and card.ability.extra) or self.config.extra )).money } } end
})

-- 746. Golden Midas Hand
SMODS.Joker({
    key = 'j_luck_and_probability_golden_midas_hand',
    rarity = 3,
    atlas = 'j_luck_and_probability_golden_midas_hand',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_odyssey_plastic, nil, true)
                v:juice_up()
            end
            return { message = "Gold!", colour = G.C.GOLD }
        end
    end
})

-- 747. Cosmic Clover
SMODS.Joker({
    key = 'j_luck_and_probability_cosmic_clover',
    config = { extra = 100 },
    rarity = 3,
    atlas = 'j_luck_and_probability_cosmic_clover',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.playing_cards then
                for k, v in ipairs(G.playing_cards) do
                    if v.base.value == '7' then count = count + 1 end
                end
            end
            if count > 0 then
                local bonus = count * card.ability.extra
                return {
                    chip_mod = bonus,
                    message = localize{type = 'variable', key = 'a_chips', vars = {bonus}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 748. 777
SMODS.Joker({
    key = 'j_luck_and_probability_777',
    config = { extra = { money = 77, xmult = 7 } },
    rarity = 3,
    atlas = 'j_luck_and_probability_777',
    pos = { x = 0, y = 0 },
    cost = 21,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local sevens = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.base.value == '7' then sevens = sevens + 1 end
            end
            if sevens >= 3 then
                ease_dollars(card.ability.extra.money)
                return {
                    Xmult_mod = card.ability.extra.xmult,
                    message = "777!",
                    colour = G.C.GOLD
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).xmult, (( (card and card.ability and card.ability.extra) or self.config.extra )).money } } end
})

-- 749. Fortuna
SMODS.Joker({
    key = 'j_luck_and_probability_fortuna',
    config = { extra = 5 },
    rarity = 4,
    atlas = 'j_luck_and_probability_fortuna',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.round_resets.reroll_cost = 0 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.round_resets.reroll_cost = 2 end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 750. Manifest Destiny
SMODS.Joker({
    key = 'j_luck_and_probability_manifest_destiny',
    config = { extra = 10 },
    rarity = 4,
    atlas = 'j_luck_and_probability_manifest_destiny',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_force_success = (G.GAME.odyssey_force_success or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_force_success = (G.GAME.odyssey_force_success or 0) - 1
    end,
    calculate = function(self, card, context)
        if context.joker_main then
             return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})
