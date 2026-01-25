-- ============================================
-- PROBABILITY AND LUCK - Uncommon (721-738)
-- ============================================

-- 721. Luck Manipulator
SMODS.Joker({
    key = 'j_luck_and_probability_luck_manipulator',
    rarity = 2,
    atlas = 'j_luck_and_probability_luck_manipulator',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    -- Simplified: same as Four Leaf Clover but stronger
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal + 1 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal - 1 end
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 722. Dice Master
SMODS.Joker({
    key = 'j_luck_and_probability_dice_master',
    rarity = 2,
    atlas = 'j_luck_and_probability_dice_master',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_dice_master = (G.GAME.odyssey_dice_master or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_dice_master = (G.GAME.odyssey_dice_master or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 723. Lady Luck
SMODS.Joker({
    key = 'j_luck_and_probability_lady_luck',
    rarity = 2,
    atlas = 'j_luck_and_probability_lady_luck',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card.config.center == G.P_CENTERS.m_lucky then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- 724. Underdog
SMODS.Joker({
    key = 'j_luck_and_probability_underdog',
    config = { extra = 3 },
    rarity = 2,
    atlas = 'j_luck_and_probability_underdog',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.chips < G.GAME.blind.chips * 0.1 then
                return {
                    Xmult_mod = card.ability.extra,
                    message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 725. Black Cat
SMODS.Joker({
    key = 'j_luck_and_probability_black_cat',
    config = { extra = 2 },
    rarity = 2,
    atlas = 'j_luck_and_probability_black_cat',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 726. Broken Mirror
SMODS.Joker({
    key = 'j_luck_and_probability_broken_mirror',
    config = { extra = 2 },
    rarity = 2,
    atlas = 'j_luck_and_probability_broken_mirror',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.playing_cards then
                for k, v in ipairs(G.playing_cards) do
                    if v.config.center == G.P_CENTERS.m_odyssey_ceramic then count = count + 1 end
                end
            end
            if count > 0 then
                local bonus = 1 + (count * card.ability.extra)
                return {
                    Xmult_mod = bonus,
                    message = localize{type = 'variable', key = 'a_xmult', vars = {bonus}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 727. Three Leaf Clover
SMODS.Joker({
    key = 'j_luck_and_probability_three_leaf_clover',
    config = { extra = 30 },
    rarity = 2,
    atlas = 'j_luck_and_probability_three_leaf_clover',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal - 0.5 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.probabilities.normal = G.GAME.probabilities.normal + 0.5 end
    end,
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

-- 728. Sorte de Principiante (Beginner's Luck)
SMODS.Joker({
    key = 'j_luck_and_probability_beginner_s_luck',
    config = { extra = 2 },
    rarity = 2,
    atlas = 'j_luck_and_probability_beginner_s_luck',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.round_resets.ante <= 1 then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})

-- 729. Destino (Destiny)
SMODS.Joker({
    key = 'j_luck_and_probability_destiny',
    rarity = 2,
    atlas = 'j_luck_and_probability_destiny',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                        local card = create_card('Consumeable', G.consumeables, nil, nil, nil, nil, nil, 'dest')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    end
                    return true
                end
            }))
            return { message = "+Consumeable!", colour = G.C.PURPLE }
        end
    end
})

-- 730. Karma (Karma)
SMODS.Joker({
    key = 'j_luck_and_probability_karma',
    config = { extra = { mult = 0, gain = 5 } },
    rarity = 2,
    atlas = 'j_luck_and_probability_karma',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local lucky_count = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_lucky then lucky_count = lucky_count + 1 end
            end
            if lucky_count > 0 then
                card.ability.extra.mult = card.ability.extra.mult + (lucky_count * card.ability.extra.gain)
                return { message = "Karma Up!", colour = G.C.MULT }
            end
            if card.ability.extra.mult > 0 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.gain, card.ability.extra.mult } } end
})

-- 731. Roda do Destino (Wheel of Fate)
SMODS.Joker({
    key = 'j_luck_and_probability_wheel_of_fate',
    config = { extra = 4 },
    rarity = 2,
    atlas = 'j_luck_and_probability_wheel_of_fate',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.blueprint then
            if pseudorandom('wheel_fate') < G.GAME.probabilities.normal / card.ability.extra then
                local eligible_jokers = {}
                for k, v in ipairs(G.jokers.cards) do
                    if v ~= card and not v.edition then table.insert(eligible_jokers, v) end
                end
                if #eligible_jokers > 0 then
                    local target = pseudorandom_element(eligible_jokers, pseudoseed('wheel_fate_target'))
                    target:set_edition({polychrome = true})
                    return { message = "Polychrome!", colour = G.C.DARK_EDITION }
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, card.ability.extra } } end
})

-- 732. Oráculo (Oracle)
SMODS.Joker({
    key = 'j_luck_and_probability_oracle',
    rarity = 2,
    atlas = 'j_luck_and_probability_oracle',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local top_cards = {}
        if G.deck and G.deck.cards then
            -- Balatro draws from the end of the cards table
            for i = 0, 2 do
                local c = G.deck.cards[#G.deck.cards - i]
                if c then
                    -- Get the display name of the card
                    local rank = c.base.value
                    local suit = localize(c.base.suit, 'suits_singular')
                    table.insert(top_cards, rank .. " de " .. suit)
                else
                    table.insert(top_cards, "---")
                end
            end
        end
        return { vars = { top_cards[1] or "---", top_cards[2] or "---", top_cards[3] or "---" } }
    end,
    calculate = function(self, card, context)
        -- Purely informational joker
    end
})

-- 733. Profecia (Prophecy)
SMODS.Joker({
    key = 'j_luck_and_probability_prophecy',
    rarity = 2,
    atlas = 'j_luck_and_probability_prophecy',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
             if G.GAME.round_resets.ante >= 8 then
                 local card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'prop')
                 card:set_edition({negative = true})
                 card:add_to_deck()
                 G.jokers:emplace(card)
                 return { message = "Fulfillment!", colour = G.C.PURPLE }
             end
        end
    end
})

-- 734. Sorte Cega (Blind Luck)
SMODS.Joker({
    key = 'j_luck_and_probability_blind_luck',
    rarity = 2,
    atlas = 'j_luck_and_probability_blind_luck',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_blind_luck = (G.GAME.odyssey_blind_luck or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_blind_luck = (G.GAME.odyssey_blind_luck or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 735. Acaso (Chance)
SMODS.Joker({
    key = 'j_luck_and_probability_chance',
    config = { extra = { xmult = 2.5, odds = 10 } },
    rarity = 2,
    atlas = 'j_luck_and_probability_chance',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('chance') < G.GAME.probabilities.normal / card.ability.extra.odds then
                if not card.ability.eternal then card:start_dissolve() end
                return { message = "Lost!", colour = G.C.GREY }
            end
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult, G.GAME.probabilities.normal, card.ability.extra.odds } } end
})

-- 736. Serendipidade (Serendipity)
SMODS.Joker({
    key = 'j_luck_and_probability_serendipity',
    rarity = 2,
    atlas = 'j_luck_and_probability_serendipity',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.odyssey_serendipity = (G.GAME.odyssey_serendipity or 0) + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.odyssey_serendipity = (G.GAME.odyssey_serendipity or 0) - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 737. Milagre (Miracle)
SMODS.Joker({
    key = 'j_luck_and_probability_miracle',
    config = { extra = 1000 },
    rarity = 2,
    atlas = 'j_luck_and_probability_miracle',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('miracle') < G.GAME.probabilities.normal / card.ability.extra then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.chips = G.GAME.blind.chips + 1
                        return true
                    end
                }))
                return { message = "MIRACLE!", colour = G.C.GOLD }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, card.ability.extra } } end
})

-- 738. Divindade (Divinity)
SMODS.Joker({
    key = 'j_luck_and_probability_divinity',
    config = { extra = 20 },
    rarity = 2,
    atlas = 'j_luck_and_probability_divinity',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_lucky then
                -- Lucky card trigger check is internal to Card:calculate_joker
                -- We'll just give a flat bonus if it's a lucky card scoring
                return {
                    mult = card.ability.extra,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra } } end
})
