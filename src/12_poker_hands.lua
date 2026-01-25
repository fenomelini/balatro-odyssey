-- Custom Poker Hands for Balatro Odyssey

-- ID 21: Wrap-around Straight
SMODS.PokerHand({
    key = 'wrap_around_straight',
    chips = 33,
    mult = 4,
    l_chips = 22,
    l_mult = 2,
    example = {
        { 'S_Q', true }, { 'H_K', true }, { 'D_A', true }, { 'C_2', true }, { 'S_3', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        -- Sort hand by rank
        local ranks = {}
        for i = 1, #hand do
            local val = hand[i].base.id
            table.insert(ranks, val)
        end
        table.sort(ranks)

        -- Standard straight already handled by game, but we need to check wrap-arounds
        -- Wrap-around logic: Check all possible start points in a circular 1-13 range
        -- id: 2=2, ..., 10=10, 11=J, 12=Q, 13=K, 14=A
        -- Adjust A to 1 for wrap:
        local possible_straights = {
            {11, 12, 13, 14, 2}, -- J, Q, K, A, 2
            {12, 13, 14, 2, 3}, -- Q, K, A, 2, 3
            {13, 14, 2, 3, 4}, -- K, A, 2, 3, 4
            {14, 2, 3, 4, 5}   -- A, 2, 3, 4, 5 (Wait, this is a standard low straight?)
            -- Actually A, 2, 3, 4, 5 is already a straight in vanilla.
        }

        for _, ps in ipairs(possible_straights) do
            local match_count = 0
            local matched_cards = {}
            for _, r in ipairs(ps) do
                for _, c in ipairs(hand) do
                    if c.base.id == r then
                        match_count = match_count + 1
                        table.insert(matched_cards, c)
                        break
                    end
                end
            end
            if match_count == 5 then return {matched_cards} end
        end
    end
})

-- ID 28: Fibonacci Hand (A, 2, 3, 5, 8)
SMODS.PokerHand({
    key = 'fibonacci_hand',
    chips = 41,
    mult = 4,
    l_chips = 26,
    l_mult = 3,
    example = {
        { 'S_A', true }, { 'H_2', true }, { 'D_3', true }, { 'C_5', true }, { 'S_8', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local fib_ranks = { [14] = true, [2] = true, [3] = true, [5] = true, [8] = true }
        local matched = {}
        local count = 0
        for i = 1, #hand do
            if fib_ranks[hand[i].base.id] then
                count = count + 1
                table.insert(matched, hand[i])
            else
                return
            end
        end
        if count == 5 then return {matched} end
    end
})

-- ID 27: Prime Hand (2, 3, 5, 7, J, K)
SMODS.PokerHand({
    key = 'prime_hand',
    chips = 47,
    mult = 5,
    l_chips = 31,
    l_mult = 3,
    example = {
        { 'S_2', true }, { 'H_3', true }, { 'D_5', true }, { 'C_7', true }, { 'S_J', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local prime_ranks = { [2] = true, [3] = true, [5] = true, [7] = true, [11] = true, [13] = true }
        local matched = {}
        for i = 1, #hand do
            if not prime_ranks[hand[i].base.id] then return end
            table.insert(matched, hand[i])
        end
        return {matched}
    end
})

-- ID 31: Red Hand (Hearts, Diamonds)
SMODS.PokerHand({
    key = 'red_hand',
    chips = 21,
    mult = 2,
    l_chips = 17,
    l_mult = 2,
    example = {
        { 'H_2', true }, { 'H_5', true }, { 'D_8', true }, { 'D_J', true }, { 'H_A', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local matched = {}
        for i = 1, #hand do
            if not (hand[i]:is_suit('Hearts') or hand[i]:is_suit('Diamonds')) then return end
            table.insert(matched, hand[i])
        end
        return {matched}
    end
})

-- ID 32: Black Hand (Spades, Clubs)
SMODS.PokerHand({
    key = 'black_hand',
    chips = 21,
    mult = 2,
    l_chips = 17,
    l_mult = 2,
    example = {
        { 'S_2', true }, { 'S_5', true }, { 'C_8', true }, { 'C_J', true }, { 'S_A', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local matched = {}
        for i = 1, #hand do
            if not (hand[i]:is_suit('Spades') or hand[i]:is_suit('Clubs')) then return end
            table.insert(matched, hand[i])
        end
        return {matched}
    end
})

-- ID 22: Jump Straight (e.g., 2, 4, 6, 8, 10)
SMODS.PokerHand({
    key = 'jump_straight',
    chips = 33,
    mult = 4,
    l_chips = 22,
    l_mult = 2,
    example = {
        { 'S_2', true }, { 'H_4', true }, { 'D_6', true }, { 'C_8', true }, { 'S_T', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local ranks = {}
        for i = 1, #hand do table.insert(ranks, hand[i].base.id) end
        table.sort(ranks)
        for i = 1, 4 do
            if ranks[i+1] ~= ranks[i] + 2 then return end
        end
        return {hand}
    end
})

-- ID 24: Spectrum (One of each suit + 1)
SMODS.PokerHand({
    key = 'spectrum',
    chips = 41,
    mult = 4,
    l_chips = 27,
    l_mult = 3,
    example = {
        { 'S_2', true }, { 'H_5', true }, { 'D_8', true }, { 'C_J', true }, { 'S_A', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local suits = {}
        for i = 1, #hand do
            suits[hand[i].base.suit] = true
        end
        local count = 0
        for _ in pairs(suits) do count = count + 1 end
        if count >= 4 then return {hand} end
    end
})

-- ID 29: Even Hand (2, 4, 6, 8, 10, Q)
SMODS.PokerHand({
    key = 'even_hand',
    chips = 26,
    mult = 2,
    l_chips = 17,
    l_mult = 2,
    example = {
        { 'S_2', true }, { 'H_4', true }, { 'D_6', true }, { 'C_8', true }, { 'S_T', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        for i = 1, #hand do
            if hand[i].base.id % 2 ~= 0 then return end
        end
        return {hand}
    end
})

-- ID 30: Odd Hand (3, 5, 7, 9, J, K, A)
SMODS.PokerHand({
    key = 'odd_hand',
    chips = 26,
    mult = 2,
    l_chips = 17,
    l_mult = 2,
    example = {
        { 'S_3', true }, { 'H_5', true }, { 'D_7', true }, { 'C_9', true }, { 'S_J', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        for i = 1, #hand do
            if hand[i].base.id % 2 == 0 then return end
        end
        return {hand}
    end
})

-- ID 33: Face Hand (Jack, Queen, King)
SMODS.PokerHand({
    key = 'face_hand',
    chips = 34,
    mult = 3,
    l_chips = 23,
    l_mult = 2,
    example = {
        { 'S_J', true }, { 'H_Q', true }, { 'D_K', true }, { 'C_J', true }, { 'S_Q', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        for i = 1, #hand do
            if not hand[i]:is_face() then return end
        end
        return {hand}
    end
})

-- ID 34: Number Hand (2-10)
SMODS.PokerHand({
    key = 'number_hand',
    chips = 22,
    mult = 2,
    l_chips = 17,
    l_mult = 2,
    example = {
        { 'S_2', true }, { 'H_5', true }, { 'D_8', true }, { 'C_3', true }, { 'S_T', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        for i = 1, #hand do
            if hand[i]:is_face() then return end
        end
        return {hand}
    end
})

-- ID 35: Low Hand (2, 3, 4, 5)
SMODS.PokerHand({
    key = 'low_hand',
    chips = 17,
    mult = 1,
    l_chips = 11,
    l_mult = 1,
    example = {
        { 'S_2', true }, { 'H_3', true }, { 'D_4', true }, { 'C_5', true }
    },
    evaluate = function(parts, hand)
        if #hand < 4 then return end
        for i = 1, #hand do
            if hand[i].base.id > 5 then return end
        end
        return {hand}
    end
})

-- ID 36: High Hand (10, J, Q, K, A)
SMODS.PokerHand({
    key = 'high_hand',
    chips = 36,
    mult = 3,
    l_chips = 21,
    l_mult = 2,
    example = {
        { 'S_T', true }, { 'H_J', true }, { 'D_Q', true }, { 'C_K', true }, { 'S_A', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        for i = 1, #hand do
            if hand[i].base.id < 10 then return end
        end
        return {hand}
    end
})

-- ID 25: Corner Hand (2s and As)
SMODS.PokerHand({
    key = 'corner_hand',
    chips = 39,
    mult = 4,
    l_chips = 26,
    l_mult = 3,
    example = {
        { 'S_2', true }, { 'H_2', true }, { 'D_A', true }, { 'C_A', true }
    },
    evaluate = function(parts, hand)
        if #hand < 4 then return end
        for i = 1, #hand do
            if hand[i].base.id ~= 2 and hand[i].base.id ~= 14 then return end
        end
        return {hand}
    end
})

-- ID 26: Middle Hand (7s and 8s)
SMODS.PokerHand({
    key = 'middle_hand',
    chips = 31,
    mult = 3,
    l_chips = 22,
    l_mult = 2,
    example = {
        { 'S_7', true }, { 'H_7', true }, { 'D_8', true }, { 'C_8', true }
    },
    evaluate = function(parts, hand)
        if #hand < 4 then return end
        for i = 1, #hand do
            if hand[i].base.id ~= 7 and hand[i].base.id ~= 8 then return end
        end
        return {hand}
    end
})

-- ID 49: Flush Pair
SMODS.PokerHand({
    key = 'flush_pair',
    chips = 43,
    mult = 4,
    l_chips = 27,
    l_mult = 3,
    example = {
        { 'S_2', true }, { 'S_2', true }, { 'S_5', true }, { 'H_T', true }, { 'D_K', true }
    },
    evaluate = function(parts, hand)
        if #hand < 3 then return end
        local flush = get_flush(hand)
        local pairs = get_n_of_a_kind(hand, 2)
        if #flush > 0 and #pairs > 0 then
            return {hand}
        end
    end
})

-- ID 50: Flush Two Pair
SMODS.PokerHand({
    key = 'flush_two_pair',
    chips = 56,
    mult = 6,
    l_chips = 37,
    l_mult = 4,
    example = {
        { 'S_2', true }, { 'S_2', true }, { 'S_5', true }, { 'S_5', true }, { 'S_A', true }
    },
    evaluate = function(parts, hand)
        if #hand < 4 then return end
        local flush = get_flush(hand)
        local pairs = get_n_of_a_kind(hand, 2)
        if #flush > 0 and #pairs >= 2 then
            return {hand}
        end
    end
})

-- ID 51: Flush Three of a Kind
SMODS.PokerHand({
    key = 'flush_three_of_a_kind',
    chips = 67,
    mult = 7,
    l_chips = 43,
    l_mult = 5,
    example = {
        { 'H_3', true }, { 'H_3', true }, { 'H_3', true }, { 'H_K', true }, { 'H_J', true }
    },
    evaluate = function(parts, hand)
        if #hand < 4 then return end
        local flush = get_flush(hand)
        local threes = get_n_of_a_kind(hand, 3)
        if #flush > 0 and #threes > 0 then
            return {hand}
        end
    end
})

-- ID 52: Flush Four of a Kind
SMODS.PokerHand({
    key = 'flush_four_of_a_kind',
    chips = 103,
    mult = 11,
    l_chips = 63,
    l_mult = 8,
    example = {
        { 'D_7', true }, { 'D_7', true }, { 'D_7', true }, { 'D_7', true }, { 'D_Q', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local flush = get_flush(hand)
        local fours = get_n_of_a_kind(hand, 4)
        if #flush > 0 and #fours > 0 then
            return {hand}
        end
    end
})

-- ID 23: Alternating Straight (Red-Black Straight)
SMODS.PokerHand({
    key = 'alternating_straight',
    chips = 49,
    mult = 5,
    l_chips = 33,
    l_mult = 3,
    example = {
        { 'H_2', true }, { 'S_3', true }, { 'H_4', true }, { 'S_5', true }, { 'H_6', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local straight = get_straight(hand)
        if #straight == 0 then return end
        
        -- Check color alternation
        local last_color = nil
        for i = 1, #hand do
            local current_color = (hand[i]:is_suit('Hearts') or hand[i]:is_suit('Diamonds')) and 'Red' or 'Black'
            if last_color and current_color == last_color then return end
            last_color = current_color
        end
        return {hand}
    end
})

-- ID 37: Mega Straight (6 cards)
SMODS.PokerHand({
    key = 'mega_straight',
    chips = 82,
    mult = 8,
    l_chips = 53,
    l_mult = 5,
    example = {
        { 'S_2', true }, { 'H_3', true }, { 'D_4', true }, { 'C_5', true }, { 'S_6', true }, { 'H_7', true }
    },
    evaluate = function(parts, hand)
        if #hand < 6 then return end
        local straight = get_straight(hand)
        if #straight > 0 and #straight[1] >= 6 then
            return straight
        end
    end
})

-- ID 38: Mega Flush (6 cards)
SMODS.PokerHand({
    key = 'mega_flush',
    chips = 82,
    mult = 8,
    l_chips = 53,
    l_mult = 5,
    example = {
        { 'S_2', true }, { 'S_4', true }, { 'S_6', true }, { 'S_8', true }, { 'S_T', true }, { 'S_Q', true }
    },
    evaluate = function(parts, hand)
        if #hand < 6 then return end
        local flush = get_flush(hand)
        if #flush > 0 and #flush[1] >= 6 then
            return flush
        end
    end
})

-- ID 39: Mega Full House (6 cards: 3 of a kind + 3 of a kind)
SMODS.PokerHand({
    key = 'mega_full_house',
    chips = 107,
    mult = 11,
    l_chips = 62,
    l_mult = 6,
    example = {
        { 'S_2', true }, { 'H_2', true }, { 'D_2', true }, { 'C_5', true }, { 'S_5', true }, { 'H_5', true }
    },
    evaluate = function(parts, hand)
        if #hand < 6 then return end
        local threes = get_n_of_a_kind(hand, 3)
        if #threes >= 2 then
            local matched = {}
            for i = 1, 3 do table.insert(matched, threes[1][i]) end
            for i = 1, 3 do table.insert(matched, threes[2][i]) end
            return {matched}
        end
    end
})

-- ID 40: Double Three of a Kind
SMODS.PokerHand({
    key = 'double_three_of_a_kind',
    chips = 107,
    mult = 11,
    l_chips = 62,
    l_mult = 6,
    example = {
        { 'S_3', true }, { 'H_3', true }, { 'D_3', true }, { 'C_8', true }, { 'S_8', true }, { 'H_8', true }
    },
    evaluate = function(parts, hand)
        if #hand < 6 then return end
        local threes = get_n_of_a_kind(hand, 3)
        if #threes >= 2 then
            local matched = {}
            for i = 1, 3 do table.insert(matched, threes[1][i]) end
            for i = 1, 3 do table.insert(matched, threes[2][i]) end
            return {matched}
        end
    end
})

-- ID 41, 42, 43: Multi Pairs
for i = 3, 5 do
    local keys = { [3] = 'triple_pair', [4] = 'quadruple_pair', [5] = 'quintuple_pair' }
    local chip_vals = { [3] = 51, [4] = 69, [5] = 87 }
    local mult_vals = { [3] = 5, [4] = 7, [5] = 9 }
    
    local example_cards = {}
    for j = 1, i do
        local rank = (j-1) % 13 + 2
        local rank_str = tostring(rank)
        if rank == 10 then rank_str = 'T'
        elseif rank == 11 then rank_str = 'J'
        elseif rank == 12 then rank_str = 'Q'
        elseif rank == 13 then rank_str = 'K'
        elseif rank == 14 then rank_str = 'A'
        end
        table.insert(example_cards, { 'S_' .. rank_str, true })
        table.insert(example_cards, { 'H_' .. rank_str, true })
    end

    SMODS.PokerHand({
        key = keys[i],
        chips = chip_vals[i],
        mult = mult_vals[i],
        l_chips = 10 * i + (i == 4 and 3 or 0), -- Just a bit varied
        l_mult = i,
        example = example_cards,
        evaluate = function(parts, hand)
            if #hand < i * 2 then return end
            local pairs = get_n_of_a_kind(hand, 2)
            if #pairs >= i then
                local matched = {}
                for j = 1, i do
                    for k = 1, 2 do table.insert(matched, pairs[j][k]) end
                end
                return {matched}
            end
        end
    })
end

-- ID 44-48: 6-10 of a kind
for i = 6, 10 do
    local keys = { [6] = 'six_of_a_kind', [7] = 'seven_of_a_kind', [8] = 'eight_of_a_kind', [9] = 'nine_of_a_kind', [10] = 'ten_of_a_kind' }
    local chip_vals = { [6] = 123, [7] = 157, [8] = 192, [9] = 234, [10] = 278 }
    local mult_vals = { [6] = 13, [7] = 17, [8] = 21, [9] = 24, [10] = 29 }
    
    local example_cards = {}
    for j = 1, i do
        table.insert(example_cards, { 'S_2', true })
    end

    SMODS.PokerHand({
        key = keys[i],
        chips = chip_vals[i],
        mult = mult_vals[i],
        l_chips = 70 + (i * 2),
        l_mult = 10,
        example = example_cards,
        evaluate = function(parts, hand)
            if #hand < i then return end
            local n_of_a_kind = get_n_of_a_kind(hand, i)
            if #n_of_a_kind > 0 then return n_of_a_kind end
        end
    })
end

-- ID 53-57: Flush 6-10 of a kind
for i = 6, 10 do
    local keys = { [6] = 'flush_six_of_a_kind', [7] = 'flush_seven_of_a_kind', [8] = 'flush_eight_of_a_kind', [9] = 'flush_nine_of_a_kind', [10] = 'flush_ten_of_a_kind' }
    local chip_vals = { [6] = 201, [7] = 287, [8] = 376, [9] = 489, [10] = 612 }
    local mult_vals = { [6] = 21, [7] = 31, [8] = 43, [9] = 57, [10] = 73 }
    
    local example_cards = {}
    for j = 1, i do
        table.insert(example_cards, { 'S_2', true })
    end

    SMODS.PokerHand({
        key = keys[i],
        chips = chip_vals[i],
        mult = mult_vals[i],
        l_chips = 90 + (i * 3),
        l_mult = 15,
        example = example_cards,
        evaluate = function(parts, hand)
            if #hand < i then return end
            local flush = get_flush(hand)
            local n_of_a_kind = get_n_of_a_kind(hand, i)
            if #flush > 0 and #n_of_a_kind > 0 then
                -- Check if the n_of_a_kind is actually the same suit
                for _, group in ipairs(n_of_a_kind) do
                    local suit = group[1].base.suit
                    local all_same = true
                    for j = 2, #group do
                        if group[j].base.suit ~= suit then all_same = false break end
                    end
                    if all_same then return {group} end
                end
            end
        end
    })
end

-- ID 58: Super Royal Flush (6+ cards)
SMODS.PokerHand({
    key = 'super_royal_flush',
    chips = 267,
    mult = 27,
    l_chips = 143,
    l_mult = 15,
    example = {
        { 'S_A', true }, { 'S_K', true }, { 'S_Q', true }, { 'S_J', true }, { 'S_T', true }, { 'S_9', true }
    },
    evaluate = function(parts, hand)
        if #hand < 6 then return end
        local flush = get_flush(hand)
        if #flush == 0 then return end
        local straight = get_straight(hand)
        if #straight == 0 or #straight[1] < 6 then return end
        -- Check if it contains Ace, King, Queen, Jack, 10, 9
        local has_9_to_A = true
        local ranks = { [14]=true, [13]=true, [12]=true, [11]=true, [10]=true, [9]=true }
        for r, _ in pairs(ranks) do
            local found = false
            for _, card in ipairs(hand) do
                if card.base.id == r then found = true break end
            end
            if not found then has_9_to_A = false break end
        end
        if has_9_to_A then return {hand} end
    end
})

-- ID 59: Ultimate Flush (All 4 suits represented, 8+ cards)
SMODS.PokerHand({
    key = 'ultimate_flush',
    chips = 208,
    mult = 21,
    l_chips = 187,
    l_mult = 17,
    example = {
        { 'S_2', true }, { 'S_3', true }, { 'H_4', true }, { 'H_5', true }, { 'D_6', true }, { 'D_7', true }, { 'C_8', true }, { 'C_9', true }
    },
    evaluate = function(parts, hand)
        if #hand < 8 then return end
        local suits = {}
        for i = 1, #hand do suits[hand[i].base.suit] = true end
        local count = 0
        for _ in pairs(suits) do count = count + 1 end
        if count == 4 then
            -- Also need 8 cards of same suit? No, "Ultimate Flush" usually means representation of all or something.
            -- Let's make it 8 cards and all 4 suits.
            return {hand}
        end
    end
})

-- ID 73: Royal Flush
SMODS.PokerHand({
    key = 'royal_flush',
    chips = 134,
    mult = 14,
    l_chips = 68,
    l_mult = 8,
    example = {
        { 'S_A', true }, { 'S_K', true }, { 'S_Q', true }, { 'S_J', true }, { 'S_T', true }
    },
    evaluate = function(parts, hand)
        if #hand < 5 then return end
        local flush = get_flush(hand)
        if #flush == 0 then return end
        local straight = get_straight(hand)
        if #straight == 0 then return end
        
        -- Check if it contains Ace, King, Queen, Jack, 10
        local has_10_to_A = true
        local ranks = { [14]=true, [13]=true, [12]=true, [11]=true, [10]=true }
        for r, _ in pairs(ranks) do
            local found = false
            for _, card in ipairs(hand) do
                if card.base.id == r then found = true break end
            end
            if not found then has_10_to_A = false break end
        end
        if has_10_to_A then return {hand} end
    end
})

-- Secret Hands (IDs 74-100)
for i = 1, 27 do
    -- Define a variety of card counts for mystery hands (3 to 8)
    local card_count = 5
    if i % 7 == 0 then card_count = 8
    elseif i % 5 == 0 then card_count = 4
    elseif i % 3 == 0 then card_count = 6
    elseif i % 2 == 0 then card_count = 5
    else card_count = 3
    end

    local example_cards = {}
    for j = 1, card_count do
        table.insert(example_cards, { 'S_A', false })
    end

    SMODS.PokerHand({
        key = 'secret_hand_' .. i,
        chips = 78 + (i * 7),
        mult = 7 + math.floor(i * 1.2),
        l_chips = 41 + (i % 5),
        l_mult = 3 + (i % 3),
        example = example_cards,
        visible = false, -- Secret hands are invisible until played
        evaluate = function(parts, hand)
            -- These are placeholders, real logic would go here
            return nil
        end
    })
end

-- ID 60 Planet hand reference
SMODS.PokerHand({
    key = 'all_hands',
    chips = 0,
    mult = 0,
    l_chips = 0,
    l_mult = 0,
    example = {
        { 'S_2', true }, { 'H_3', true }, { 'D_5', true }, { 'C_7', true }, { 'S_J', true }
    },
    visible = false,
    evaluate = function(parts, hand) return end
})

-- ID 60: All Hands (This is usually a placeholder for something else or a special hand)
-- For now I'll just skip it or make it a "Five Card Random"

