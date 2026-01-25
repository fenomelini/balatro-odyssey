-- ============================================
-- PROBABILITY AND LUCK - Common (701-720)
-- ============================================

-- 701. Four Leaf Clover
SMODS.Joker({
    key = 'j_luck_and_probability_four_leaf_clover',
    config = { extra = 0.1 },
    rarity = 1,
    atlas = 'j_luck_and_probability_four_leaf_clover',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal + card.ability.extra end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal - card.ability.extra end
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 702. Rabbit's Foot
SMODS.Joker({
    key = 'j_luck_and_probability_rabbit_s_foot',
    config = { extra = { mult = 5, odds = 2 } },
    rarity = 1,
    atlas = 'j_luck_and_probability_rabbit_s_foot',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('rabbit_s_foot') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.mult } } end
})

-- 703. Horseshoe
SMODS.Joker({
    key = 'j_luck_and_probability_horseshoe',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_luck_and_probability_horseshoe',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.deck and G.deck.cards then
                for k, v in ipairs(G.deck.cards) do
                    if v.config.center == G.P_CENTERS.m_lucky then count = count + 1 end
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
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 704. D6 Die
SMODS.Joker({
    key = 'j_luck_and_probability_d6_die',
    rarity = 1,
    atlas = 'j_luck_and_probability_d6_die',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_mult = 0
            local dice_sides = (G.GAME.odyssey_dice_master and G.GAME.odyssey_dice_master > 0) and 12 or 6
            local sides = {}
            for i=1, dice_sides do table.insert(sides, i) end
            
            for i=1, #context.scoring_hand do
                total_mult = total_mult + pseudorandom_element(sides, pseudoseed('d6'))
            end
            return {
                mult_mod = total_mult,
                message = "Roll: " .. total_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 705. D20 Die
SMODS.Joker({
    key = 'j_luck_and_probability_d20_die',
    rarity = 1,
    atlas = 'j_luck_and_probability_d20_die',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_chips = 0
            local dice_sides = (G.GAME.odyssey_dice_master and G.GAME.odyssey_dice_master > 0) and 40 or 20
            local sides = {}
            for i=1, dice_sides do table.insert(sides, i) end
            
            for i=1, #context.scoring_hand do
                total_chips = total_chips + pseudorandom_element(sides, pseudoseed('d20'))
            end
            return {
                chip_mod = total_chips,
                message = "Crit: " .. total_chips,
                colour = G.C.CHIPS
            }
        end
    end
})

-- 706. Coin Flip
SMODS.Joker({
    key = 'j_luck_and_probability_coin_flip',
    config = { extra = 2 },
    rarity = 1,
    atlas = 'j_luck_and_probability_coin_flip',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('coin_flip') < G.GAME.probabilities.normal / 2 then
                return {
                    Xmult_mod = card.ability.extra,
                    message = "Heads!"
                }
            else
                return { message = "Tails...", colour = G.C.GREY }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, 2, card.ability.extra } } end
})

-- 707. Safe Bet
SMODS.Joker({
    key = 'j_luck_and_probability_safe_bet',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_luck_and_probability_safe_bet',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 708. Risky Bet
SMODS.Joker({
    key = 'j_luck_and_probability_risky_bet',
    config = { extra = { mult = 40, odds = 4 } },
    rarity = 1,
    atlas = 'j_luck_and_probability_risky_bet',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('risky_bet') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = "Jackpot!"
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.mult } } end
})

-- 709. Raffle
SMODS.Joker({
    key = 'j_luck_and_probability_raffle',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_luck_and_probability_raffle',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.blueprint then
            if pseudorandom('raffle') < G.GAME.probabilities.normal / card.ability.extra then
                if #G.jokers.cards < G.jokers.config.card_limit then -- Check capacity
                    local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'raffle')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    return { message = localize('k_plus_joker'), colour = G.C.BLUE }
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, card.ability.extra } } end
})

-- 710. Bingo
SMODS.Joker({
    key = 'j_luck_and_probability_bingo',
    config = { extra = 5 },
    rarity = 1,
    atlas = 'j_luck_and_probability_bingo',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Straight" then
            ease_dollars(card.ability.extra)
            return { message = localize('$')..card.ability.extra, colour = G.C.MONEY }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 711. Jackpot
SMODS.Joker({
    key = 'j_luck_and_probability_jackpot',
    config = { extra = 20 },
    rarity = 1,
    atlas = 'j_luck_and_probability_jackpot',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local count_7 = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.base.value == '7' then count_7 = count_7 + 1 end
            end
            if count_7 >= 3 then
                ease_dollars(card.ability.extra)
                return { message = localize('$')..card.ability.extra, colour = G.C.MONEY }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 712. Slot Machine
SMODS.Joker({
    key = 'j_luck_and_probability_slot_machine',
    config = { extra = 15 },
    rarity = 1,
    atlas = 'j_luck_and_probability_slot_machine',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Three of a Kind" then
            return {
                mult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 713. Sports Betting
SMODS.Joker({
    key = 'j_luck_and_probability_sports_betting',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_luck_and_probability_sports_betting',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.blueprint then
            if G.GAME.current_round.hands_played == 2 then
                ease_dollars(card.ability.extra)
                return { message = localize('$')..card.ability.extra, colour = G.C.MONEY, card = card }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 714. Scratch Card
SMODS.Joker({
    key = 'j_luck_and_probability_scratch_card',
    rarity = 1,
    atlas = 'j_luck_and_probability_scratch_card',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.selling_self then
            local amount = pseudorandom_element({0,5,10,15,20}, pseudoseed('scratch'))
            ease_dollars(amount)
        end
    end
})

-- 715. Fortune Cookie
SMODS.Joker({
    key = 'j_luck_and_probability_fortune_cookie',
    config = { extra = { mult = 5, odds = 4 } },
    rarity = 1,
    atlas = 'j_luck_and_probability_fortune_cookie',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
            }
        end
        if context.using_consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
            if pseudorandom('fortune_cookie') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'fort')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        return true
                    end
                }))
                return { message = "Fortune!", colour = G.C.SECONDARY_SET.Spectral }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult, G.GAME.probabilities.normal, card.ability.extra.odds } } end
})

-- 716. Amulet
SMODS.Joker({
    key = 'j_luck_and_probability_amulet',
    rarity = 1,
    atlas = 'j_luck_and_probability_amulet',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_glass_protection = (G.GAME.odyssey_glass_protection or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_glass_protection = (G.GAME.odyssey_glass_protection or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 717. Talisman
SMODS.Joker({
    key = 'j_luck_and_probability_talisman',
    rarity = 1,
    atlas = 'j_luck_and_probability_talisman',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_lucky_double = (G.GAME.odyssey_lucky_double or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_lucky_double = (G.GAME.odyssey_lucky_double or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 718. Gargoyle
SMODS.Joker({
    key = 'j_luck_and_probability_gargoyle',
    config = { extra = 100 },
    rarity = 1,
    atlas = 'j_luck_and_probability_gargoyle',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_stone = false
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_odyssey_emerald then has_stone = true break end
            end
            if has_stone then return { chips = card.ability.extra } end
        end
    end
})

-- 719. Evil Eye
SMODS.Joker({
    key = 'j_luck_and_probability_evil_eye',
    rarity = 1,
    atlas = 'j_luck_and_probability_evil_eye',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    -- Placeholder: Protege contra debuffs de Boss
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 720. Figa
SMODS.Joker({
    key = 'j_luck_and_probability_figa',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_luck_and_probability_figa',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_left == 0 then
            return { mult = card.ability.extra }
        end
    end
})
