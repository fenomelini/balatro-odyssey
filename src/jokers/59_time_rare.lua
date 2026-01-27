-- ============================================
-- TIME & TURNS - Rare (Jokers 639-648)
-- ============================================

-- 639: Time Lord
SMODS.Joker({
    unlocked = true,
    key = 'j_time_time_lord',
    discovered = true,
    config = { extra = { hands = 1, discards = 1, slots = 1 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_time_lord',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
        ease_hands_played(card.ability.extra.hands)
        ease_discard(card.ability.extra.discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
        ease_hands_played(-card.ability.extra.hands)
        ease_discard(-card.ability.extra.discards)
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 640: The World
SMODS.Joker({
    unlocked = true,
    key = 'j_time_the_world',
    discovered = true,
    config = { extra = { xmult = 2 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_the_world',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 641: Aeon
SMODS.Joker({
    unlocked = true,
    key = 'j_time_aeon',
    discovered = true,
    config = { extra = { xmult = 1 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_aeon',
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
            card.ability.extra.xmult = card.ability.extra.xmult + 0.1
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end
})

-- 642: Kairos
SMODS.Joker({
    unlocked = true,
    key = 'j_time_kairos',
    discovered = true,
    config = { extra = { xmult = 5 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_kairos',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 643: Chronos
SMODS.Joker({
    unlocked = true,
    key = 'j_time_chronos',
    discovered = true,
    config = { extra = { dollars_per_hand = 2 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_chronos',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local bonus = G.GAME.current_round.hands_left * card.ability.extra.dollars_per_hand
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

-- 644: Ouroboros
SMODS.Joker({
    unlocked = true,
    key = 'j_time_ouroboros',
    discovered = true,
    rarity = 3,
    cost = 10,
    atlas = 'j_time_ouroboros',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_ouroboros = (G.GAME.odyssey_ouroboros or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_ouroboros = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 645: Reverse Entropy
SMODS.Joker({
    unlocked = true,
    key = 'j_time_reverse_entropy',
    discovered = true,
    rarity = 3,
    cost = 10,
    atlas = 'j_time_reverse_entropy',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_reverse_entropy = (G.GAME.odyssey_reverse_entropy or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_reverse_entropy = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 646: Big Crunch
SMODS.Joker({
    unlocked = true,
    key = 'j_time_big_crunch',
    discovered = true,
    config = { extra = { xmult = 10, hand_size = -7 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_big_crunch',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size
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

-- 647: Big Bang
SMODS.Joker({
    unlocked = true,
    key = 'j_time_big_bang',
    discovered = true,
    config = { extra = { mult_minus = 2, hand_size = 5 } },
    rarity = 3,
    cost = 10,
    atlas = 'j_time_big_bang',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand then
            return {
                mult = -card.ability.extra.mult_minus,
                card = card
            }
        end
    end
})

-- 648: Sacred Timeline
SMODS.Joker({
    unlocked = true,
    key = 'j_time_sacred_timeline',
    discovered = true,
    rarity = 3,
    cost = 10,
    atlas = 'j_time_sacred_timeline',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_sacred_timeline = (G.GAME.odyssey_sacred_timeline or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_sacred_timeline = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
