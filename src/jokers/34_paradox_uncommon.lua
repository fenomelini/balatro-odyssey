-- ============================================
-- PARADOX - Uncommon (Jokers 337-350)
-- ============================================

-- 337. Failure's Success
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_failures_success',
    config = { extra = { dollars = 10 } },
    rarity = 2,
    atlas = 'j_paradox_failures_success',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.game_over and not context.other_card then
            if G.GAME.chips < G.GAME.blind.chips then
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = localize('$') .. card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 338. Order of Chaos
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_order_of_chaos',
    config = { extra = { x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_paradox_order_of_chaos',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local is_straight = false
            if context.poker_hands and context.poker_hands['Straight'] and next(context.poker_hands['Straight']) then
                is_straight = true
            end
            
            if not is_straight then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    x_mult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 339. All or Nothing
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_all_or_nothing',
    config = { extra = { high_x_mult = 4, low_x_mult = 0.5, odds = 2 } },
    rarity = 2,
    atlas = 'j_paradox_all_or_nothing',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.high_x_mult, (G.GAME.probabilities.normal or 1), extra.odds, extra.low_x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('all_or_nothing') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.high_x_mult } },
                    x_mult_mod = card.ability.extra.high_x_mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.low_x_mult } },
                    x_mult_mod = card.ability.extra.low_x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 340. Zeno's Paradox
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_zenos_paradox',
    config = { extra = { x_mult = 8 } },
    rarity = 2,
    atlas = 'j_paradox_zenos_paradox',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                x_mult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        if context.after and not context.blueprint then
            if card.ability.extra.x_mult > 1 then
                card.ability.extra.x_mult = card.ability.extra.x_mult / 2
                return {
                    message = localize('k_lower'),
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 341. Alive and Dead Cat
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_alive_and_dead_cat',
    config = { extra = { x_mult = 5 } },
    rarity = 2,
    atlas = 'j_paradox_alive_and_dead_cat',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.discards_left == 0 and G.GAME.current_round.hands_left == 1 then -- This is the last hand
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    x_mult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 342. Beginning of the End
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_beginning_of_the_end',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_paradox_beginning_of_the_end',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                x_mult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 343. Square Circle
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_square_circle',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_paradox_square_circle',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Logic handled in Card:is_suit override
    end
})

-- 344. Hot Cold
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_hot_cold',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_paradox_hot_cold',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Logic handled in Card:is_suit override
    end
})

-- 345. Past Future
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_past_future',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_paradox_past_future',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.odyssey_prev_round_1_hand then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    x_mult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 346. False Truth
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_false_truth',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_paradox_false_truth',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_ceramic then
                 return {
                     mult = card.ability.extra.mult,
                     card = card
                 }
            end
        end
    end
})

-- 347. Mortal Immortal
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_mortal_immortal',
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_paradox_mortal_immortal',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.odyssey_can_sell_eternal = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.odyssey_can_sell_eternal = false
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Logic handled in overrides
    end
})

-- 348. Unlucky Luck
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_unlucky_luck',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_paradox_unlucky_luck',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_undead or
               context.other_card.config.center == G.P_CENTERS.m_odyssey_light or
               context.other_card.config.center == G.P_CENTERS.m_odyssey_magic then
                 return {
                     mult = card.ability.extra.mult,
                     card = card
                 }
            end
        end
    end
})

-- 349. Shrinking Growth
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_shrinking_growth',
    config = { extra = { mult = 50, loss = 2 } },
    rarity = 2,
    atlas = 'j_paradox_shrinking_growth',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult, extra.loss } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             return {
                 message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                 mult_mod = card.ability.extra.mult,
                 colour = G.C.MULT
             }
        end
        if context.end_of_round and not context.repetition and not context.game_over and not context.other_card then
            if card.ability.extra.mult > 0 then
                card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.loss)
                return {
                    message = localize{ type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.loss } },
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 350. Polarity Reversal
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_polarity_reversal',
    config = { extra = { mult = 15, chips = 50 } },
    rarity = 2,
    atlas = 'j_paradox_polarity_reversal',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult, extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Spades') or context.other_card:is_suit('Clubs') then
                return {
                    mult = card.ability.extra.mult,
                    card = context.other_card
                }
            elseif context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds') then
                 return {
                    chips = card.ability.extra.chips,
                    card = context.other_card
                }
            end
        end
    end
})