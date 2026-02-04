-- ============================================
-- HAND AND DISCARD - Uncommon (Jokers 671-688)
-- ============================================

-- 671. Hand of Midas
SMODS.Joker({
    key = 'j_hand_and_discard_hand_of_midas',
    config = { extra = 10 },
    rarity = 2,
    atlas = 'j_hand_and_discard_hand_of_midas',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.joker_main then
            local gold_count = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_odyssey_plastic then gold_count = gold_count + 1 end
            end
            if gold_count >= 5 then
                ease_dollars(card.ability.extra)
                return {
                    message = localize('$')..card.ability.extra,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 672. Iron Hand
SMODS.Joker({
    key = 'j_hand_and_discard_iron_hand',
    config = { extra = 100 },
    rarity = 2,
    atlas = 'j_hand_and_discard_iron_hand',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.joker_main then
            local steel_count = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_odyssey_platinum then steel_count = steel_count + 1 end
            end
            if steel_count >= 5 then
                return {
                    mult_mod = card.ability.extra,
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 673. Stone Hand
SMODS.Joker({
    key = 'j_hand_and_discard_stone_hand',
    config = { extra = 200 },
    rarity = 2,
    atlas = 'j_hand_and_discard_stone_hand',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.joker_main then
            local stone_count = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_odyssey_emerald then stone_count = stone_count + 1 end
            end
            if stone_count >= 5 then
                return {
                    chip_mod = card.ability.extra,
                    message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 674. Glass Hand
SMODS.Joker({
    key = 'j_hand_and_discard_glass_hand',
    config = { extra = 4 },
    rarity = 2,
    atlas = 'j_hand_and_discard_glass_hand',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.joker_main then
            local glass_count = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center == G.P_CENTERS.m_odyssey_ceramic then glass_count = glass_count + 1 end
            end
            if glass_count >= 5 then
                for k, v in ipairs(context.scoring_hand) do
                    if v.config.center == G.P_CENTERS.m_odyssey_ceramic then
                        v:shatter()
                    end
                end
                return {
                    Xmult_mod = card.ability.extra,
                    message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 675. Helping Hand
SMODS.Joker({
    key = 'j_hand_and_discard_helping_hand',
    rarity = 2,
    atlas = 'j_hand_and_discard_helping_hand',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "High Card" and not context.blueprint then
            level_up_hand(card, context.scoring_name, nil, 1)
            return {
                message = localize('k_level_up'),
                colour = G.C.PURPLE
            }
        end
    end
})

-- 676. Dead Hand
SMODS.Joker({
    key = 'j_hand_and_discard_dead_hand',
    config = { extra = 5 },
    rarity = 2,
    atlas = 'j_hand_and_discard_dead_hand',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and not context.repetition and not context.other_card then
            -- We check if the hand score was 0 (e.g. all debuffed)
            -- This is tricky in after context, so we'll check hand_chips and hand_mult
            if G.GAME.hands[context.scoring_name].chips == 0 or G.GAME.hands[context.scoring_name].mult == 0 then
                ease_dollars(card.ability.extra)
                return { message = localize('$')..card.ability.extra, colour = G.C.MONEY }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 677. Divine Hand
SMODS.Joker({
    key = 'j_hand_and_discard_divine_hand',
    config = { extra = 2 },
    rarity = 2,
    atlas = 'j_hand_and_discard_divine_hand',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 678. Cursed Hand
SMODS.Joker({
    key = 'j_hand_and_discard_cursed_hand',
    config = { extra = 3 },
    rarity = 2,
    atlas = 'j_hand_and_discard_cursed_hand',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = false,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1; ease_hands_played(-1) end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1; ease_hands_played(1) end
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

-- 679. Perfect Discard
SMODS.Joker({
    key = 'j_hand_and_discard_perfect_discard',
    config = { extra = 4 },
    rarity = 2,
    atlas = 'j_hand_and_discard_perfect_discard',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.discard and #context.full_hand == 5 and not context.blueprint then
            local suit = context.full_hand[1].base.suit
            local all_same = true
            for i=2, 5 do if context.full_hand[i].base.suit ~= suit then all_same = false end end
            if all_same then
                ease_dollars(card.ability.extra)
                return { message = localize('$')..card.ability.extra, colour = G.C.MONEY, card = card }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 680. Strategic Discard
SMODS.Joker({
    key = 'j_hand_and_discard_strategic_discard',
    config = { extra = { mult = 20, active = false } },
    rarity = 2,
    atlas = 'j_hand_and_discard_strategic_discard',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.discard and #context.full_hand >= 5 and not context.blueprint then
             local ranks = {}
             for k, v in ipairs(context.full_hand) do table.insert(ranks, v.base.id) end
             table.sort(ranks)
             local is_straight = true
             for i=1, #ranks-1 do
                if ranks[i+1] ~= ranks[i] + 1 then
                    -- Handle Ace low straight
                    if not (i == #ranks-1 and ranks[i] == 5 and ranks[i+1] == 14) then
                        is_straight = false
                        break
                    end
                end
             end
             if is_straight then
                card.ability.extra.active = true
                return { message = "Strategic!", colour = G.C.FILTER }
             end
        end
        if context.joker_main and card.ability.extra.active then
            card.ability.extra.active = false
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end
})

-- 681. Gold Discard
SMODS.Joker({
    key = 'j_hand_and_discard_gold_discard',
    config = { extra = 4 },
    rarity = 2,
    atlas = 'j_hand_and_discard_gold_discard',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and context.other_card.config.center == G.P_CENTERS.m_odyssey_plastic then
            ease_dollars(card.ability.extra)
            return { message = localize('$')..card.ability.extra, colour = G.C.MONEY, card = card }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 682. Steel Discard
SMODS.Joker({
    key = 'j_hand_and_discard_steel_discard',
    config = { extra = { mult = 0, gain = 5 } },
    rarity = 2,
    atlas = 'j_hand_and_discard_steel_discard',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and context.other_card.config.center == G.P_CENTERS.m_odyssey_platinum then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
            return {
                message = "Up!",
                colour = G.C.MULT
            }
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).gain } } end
})

-- 683. Glass Discard

SMODS.Joker({
    key = 'j_hand_and_discard_glass_discard',
    config = { extra = 2 }, -- 1 in 2
    rarity = 2,
    atlas = 'j_hand_and_discard_glass_discard',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and context.other_card.config.center == G.P_CENTERS.m_odyssey_ceramic then
            if pseudorandom('glass_discard') < G.GAME.probabilities.normal / card.ability.extra then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local _card = copy_card(context.other_card, nil, nil, G.hand.cards[1] and G.hand.cards[1].set or 'Default')
                        _card:add_to_deck()
                        G.hand:emplace(_card)
                        return true
                    end
                }))
                return { message = "New Ceramic!", colour = G.C.PALE_GREEN }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 684. Mirrored Hand
SMODS.Joker({
    key = 'j_hand_and_discard_mirrored_hand',
    config = { extra = 2 },
    rarity = 2,
    atlas = 'j_hand_and_discard_mirrored_hand',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
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

-- 685. Shadow Hand
SMODS.Joker({
    key = 'j_hand_and_discard_shadow_hand',
    rarity = 2,
    atlas = 'j_hand_and_discard_shadow_hand',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and not card.ability.used_this_round then
            card.ability.used_this_round = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    for k, v in ipairs(context.scoring_hand) do
                        local _card = copy_card(v)
                        _card:add_to_deck()
                        G.hand:emplace(_card)
                    end
                    return true
                end
            }))
            return { message = "Shadow Recall!", colour = G.C.PURPLE }
        end
        if context.end_of_round and not context.other_card then card.ability.used_this_round = false end
    end
})

-- 686. Quick Hand
SMODS.Joker({
    key = 'j_hand_and_discard_quick_hand',
    rarity = 2,
    atlas = 'j_hand_and_discard_quick_hand',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 2
        ease_hands_played(2)
        ease_discard(-2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
        ease_hands_played(-2)
        ease_discard(2)
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 687. Slow Hand
SMODS.Joker({
    key = 'j_hand_and_discard_slow_hand',
    config = { extra = { mult = 10, current_mult = 0 } },
    rarity = 2,
    atlas = 'j_hand_and_discard_slow_hand',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = false,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult
            return { message = "+" .. card.ability.extra.mult, colour = G.C.MULT }
        end
        if context.joker_main and card.ability.extra.current_mult > 0 then
            local bonus = card.ability.extra.current_mult
            card.ability.extra.current_mult = 0
            return {
                mult_mod = bonus,
                message = localize{type = 'variable', key = 'a_mult', vars = {bonus}},
                colour = G.C.MULT
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).current_mult } } end
})

-- 688. Ambidextrous
SMODS.Joker({
    key = 'j_hand_and_discard_ambidextrous',
    config = { extra = 10 },
    rarity = 2,
    atlas = 'j_hand_and_discard_ambidextrous',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = false,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then
            G.play.config.card_limit = card.ability.extra
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then
            G.play.config.card_limit = 10
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

