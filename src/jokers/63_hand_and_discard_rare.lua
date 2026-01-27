-- ============================================
-- HAND AND DISCARD - Rare & Legendary (689-700)
-- ============================================

-- 689. Hand of God
SMODS.Joker({
    key = 'j_hand_and_discard_hand_of_god',
    config = { extra = { played = 0, xmult_gain = 0.2 } },
    rarity = 3,
    atlas = 'j_hand_and_discard_hand_of_god',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local current_xmult = 1 + (card.ability.extra.played * card.ability.extra.xmult_gain)
            return {
                Xmult_mod = current_xmult,
                message = localize{type = 'variable', key = 'a_xmult', vars = {current_xmult}}
            }
        end
        if context.buying_card and not context.blueprint then
            card.ability.extra.played = (card.ability.extra.played or 0) + 1
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (card and card.ability.extra or self.config.extra).xmult_gain, (card and card.ability.extra or self.config.extra).played, 1 + ((card and card.ability.extra or self.config.extra).played * (card and card.ability.extra or self.config.extra).xmult_gain) } } end
})

-- 690. Devil's Hand
SMODS.Joker({
    key = 'j_hand_and_discard_devils_hand',
    config = { extra = 3 },
    rarity = 3,
    atlas = 'j_hand_and_discard_devils_hand',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local highest_card = nil
            local max_rank = -1
            for k, v in ipairs(G.hand.cards) do
                if v.base.id > max_rank then
                    max_rank = v.base.id
                    highest_card = v
                end
            end
            if highest_card then
                if not highest_card.ability.eternal then highest_card:start_dissolve() end
            end
        end
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (card and card.ability.extra or self.config.extra) } } end
})

-- 691. King's Hand
SMODS.Joker({
    key = 'j_hand_and_discard_kings_hand',
    rarity = 3,
    atlas = 'j_hand_and_discard_kings_hand',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            local has_king = false
            for k, v in ipairs(context.scoring_hand) do
                if v.base.value == 'King' then has_king = true break end
            end
            if has_king and (context.other_card.base.value == 'King' or context.other_card.base.value == 'Queen') then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- 692. Queen's Hand
SMODS.Joker({
    key = 'j_hand_and_discard_queens_hand',
    config = { extra = { money = 5, mult = 10 } },
    rarity = 3,
    atlas = 'j_hand_and_discard_queens_hand',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_queen = false
            for k, v in ipairs(context.scoring_hand) do
                if v.base.value == 'Queen' then has_queen = true break end
            end
            if has_queen then
                ease_dollars(card.ability.extra.money)
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}},
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult, ((card and card.ability.extra or self.config.extra)).money } } end
})

-- 693. Jack's Hand
SMODS.Joker({
    key = 'j_hand_and_discard_jacks_hand',
    config = { extra = 50 },
    rarity = 3,
    atlas = 'j_hand_and_discard_jacks_hand',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_jack = false
            for k, v in ipairs(context.scoring_hand) do
                if v.base.value == 'Jack' then has_jack = true break end
            end
            if has_jack then
                local bonus = #context.scoring_hand * card.ability.extra
                return {
                    chip_mod = bonus,
                    message = localize{type = 'variable', key = 'a_chips', vars = {bonus}},
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (card and card.ability.extra or self.config.extra) } } end
})

-- 694. Ace's Hand
SMODS.Joker({
    key = 'j_hand_and_discard_aces_hand',
    rarity = 3,
    atlas = 'j_hand_and_discard_aces_hand',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local has_ace = false
            for k, v in ipairs(context.scoring_hand) do
                if v.base.value == 'Ace' then has_ace = true break end
            end
            if has_ace then
                for k, v in ipairs(context.scoring_hand) do
                    if v.base.value ~= 'Ace' then
                        v:set_base(G.P_CARDS[v.base.suit..'_A'])
                    end
                end
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end
})

-- 695. Infinite Hand
SMODS.Joker({
    key = 'j_hand_and_discard_infinite_hand',
    rarity = 3,
    atlas = 'j_hand_and_discard_infinite_hand',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            local cards_to_return = {}
            for k, v in ipairs(context.scoring_hand) do
                table.insert(cards_to_return, v)
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    for i = #cards_to_return, 1, -1 do
                        draw_card(G.play, G.deck, 90, 'up', nil, cards_to_return[i])
                    end
                    return true
                end
            }))
            return {
                message = "Refill!",
                colour = G.C.BLUE,
                card = card
            }
        end
    end
})

-- 696. Infinite Discard
SMODS.Joker({
    key = 'j_hand_and_discard_infinite_discard',
    config = { extra = 1 },
    rarity = 3,
    atlas = 'j_hand_and_discard_infinite_discard',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        -- We'll handle this in 03_vanilla_override.lua for the discard button press
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (card and card.ability.extra or self.config.extra) } } end
})

-- 697. Supreme Hand
SMODS.Joker({
    key = 'j_hand_and_discard_supreme_hand',
    rarity = 3,
    atlas = 'j_hand_and_discard_supreme_hand',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Royal Flush" then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    G.GAME.chips = G.GAME.blind.chips
                    return true
                end
            }))
            return {
                message = "SUPREME!",
                colour = G.C.GOLD,
                card = card
            }
        end
    end
})

-- 698. Void Hand
SMODS.Joker({
    key = 'j_hand_and_discard_void_hand',
    config = { extra = 10 },
    rarity = 3,
    atlas = 'j_hand_and_discard_void_hand',
    pos = { x = 0, y = 0 },
    cost = 15,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and #context.scoring_hand == 1 and context.scoring_name == "High Card" then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}},
                card = card
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (card and card.ability.extra or self.config.extra) } } end
})

-- 699. The Creator
SMODS.Joker({
    key = 'j_hand_and_discard_the_creator',
    rarity = 4,
    atlas = 'j_hand_and_discard_the_creator',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then
            G.hand.config.card_limit = G.hand.config.card_limit + 3
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
            ease_hands_played(2)
            ease_discard(2)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then
            G.hand.config.card_limit = G.hand.config.card_limit - 3
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - 2
            ease_hands_played(-2)
            ease_discard(-2)
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { 3, 2, 2 } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 700. The Destroyer
SMODS.Joker({
    key = 'j_hand_and_discard_the_destroyer',
    config = { extra = 6 },
    rarity = 4,
    atlas = 'j_hand_and_discard_the_destroyer',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.hand.config.card_limit = G.hand.config.card_limit - 2 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.hand.config.card_limit = G.hand.config.card_limit + 2 end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult_mod = card.ability.extra,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra}},
                card = card
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (card and card.ability.extra or self.config.extra), 2 } } end
})

