-- ============================================
-- TIME & TURNS - Common (Jokers 601-620)
-- ============================================

-- 601: Hourglass
SMODS.Joker({
    unlocked = true,
    key = 'j_time_hourglass',
    discovered = true,
    config = { extra = { mult = 20, loss = 2, current_mult = 20 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_hourglass',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult, extra.loss, extra.current_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.current_mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } }
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.current_mult = math.max(0, card.ability.extra.current_mult - card.ability.extra.loss)
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current_mult = card.ability.extra.mult
        end
    end
})

-- 602: Stopwatch
SMODS.Joker({
    unlocked = true,
    key = 'j_time_stopwatch',
    discovered = true,
    config = { extra = { chips = 30 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_stopwatch',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
        end
    end
})

-- 603: Countdown
SMODS.Joker({
    unlocked = true,
    key = 'j_time_countdown',
    discovered = true,
    config = { extra = { start = 10, current = 10, reward = 50 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_countdown',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.start, extra.reward, extra.current } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current = card.ability.extra.current - 1
            if card.ability.extra.current <= 0 then
                ease_dollars(card.ability.extra.reward)
                card.ability.extra.current = card.ability.extra.start
                return {
                    message = localize('$') .. card.ability.extra.reward,
                    colour = G.C.MONEY
                }
            end
            return {
                message = card.ability.extra.current .. '',
                colour = G.C.FILTER
            }
        end
    end
})

-- 604: Patience
SMODS.Joker({
    unlocked = true,
    key = 'j_time_patience',
    discovered = true,
    config = { extra = { time = 30, mult = 20 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_patience',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.time, extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local current_time = G.TIMERS.REAL
            local last_time = G.GAME.last_hand_time or current_time
            if (current_time - last_time) >= card.ability.extra.time then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
        if context.after then
            G.GAME.last_hand_time = G.TIMERS.REAL
        end
    end
})

-- 605: Haste
SMODS.Joker({
    unlocked = true,
    key = 'j_time_haste',
    discovered = true,
    config = { extra = { time = 5, mult = 10 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_haste',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult, extra.time } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local current_time = G.TIMERS.REAL
            local last_time = G.GAME.last_hand_time or current_time
            if (current_time - last_time) <= card.ability.extra.time then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
        if context.after then
            G.GAME.last_hand_time = G.TIMERS.REAL
        end
    end
})

-- 606: Extra Turn
SMODS.Joker({
    unlocked = true,
    key = 'j_time_extra_turn',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_time_extra_turn',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
        ease_hands_played(1)
        ease_discard(-1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
        ease_hands_played(-1)
        ease_discard(1)
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 607: Rush Hour
SMODS.Joker({
    unlocked = true,
    key = 'j_time_rush_hour',
    discovered = true,
    config = { extra = { chips = 50 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_rush_hour',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and (G.GAME.current_round.discards_left or 0) == 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- 608: Delay
SMODS.Joker({
    unlocked = true,
    key = 'j_time_delay',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_time_delay',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local bonus = G.GAME.current_round.last_hand_mult or 0
            if bonus > 0 then
                ease_dollars(bonus)
                return {
                    message = localize('$') .. bonus,
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            G.GAME.current_round.last_hand_mult = context.mult
        end
    end
})

-- 609: Cycle
SMODS.Joker({
    unlocked = true,
    key = 'j_time_cycle',
    discovered = true,
    config = { extra = { rounds = 4, current = 4 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_cycle',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.rounds, extra.current } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current = card.ability.extra.current - 1
            if card.ability.extra.current <= 0 then
                card.ability.extra.current = card.ability.extra.rounds
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local key = 'p_arcana_normal_' .. (math.random(1, 2))
                    local card = Card(G.play.T.x, G.play.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card:set_edition(nil, true, true)
                    card:draw_from_deck()
                    G.play:emplace(card)
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        card:use_booster_pack()
                        return true
                    end}))
                    return true
                end}))
                return {
                    message = "Cycle!",
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

-- 610: Seasons
SMODS.Joker({
    unlocked = true,
    key = 'j_time_seasons',
    discovered = true,
    config = { extra = { suit = 'Hearts', index = 1 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_seasons',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { localize(card.ability.extra.suit, 'suits_plural'), colours = { G.C.SUITS[card.ability.extra.suit] } }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(card.ability.extra.suit) then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    mult_mod = count * 5,
                    chips_mod = count * 20,
                    message = localize { type = 'variable', key = 'a_mult', vars = { count * 5 } }
                }
            end
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            local suits = { 'Hearts', 'Spades', 'Diamonds', 'Clubs' }
            card.ability.extra.index = (card.ability.extra.index % 4) + 1
            card.ability.extra.suit = suits[card.ability.extra.index]
            return {
                message = localize(card.ability.extra.suit, 'suits_plural'),
                colour = G.C.FILTER
            }
        end
    end
})

-- 611: Day and Night
SMODS.Joker({
    unlocked = true,
    key = 'j_time_day_night',
    discovered = true,
    config = { extra = { chips = 50, mult = 10, state = 'day' } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_day_night',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips, extra.mult, extra.state } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.state == 'day' then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            else
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
        if context.after and not context.blueprint then
            card.ability.extra.state = (card.ability.extra.state == 'day') and 'night' or 'day'
        end
    end
})

-- 612: Sundial
SMODS.Joker({
    unlocked = true,
    key = 'j_time_sundial',
    discovered = true,
    config = { extra = { mult_per_card = 0.5 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_sundial',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local deck_count = (G.deck and G.deck.cards) and #G.deck.cards or 0
        local current_mult = deck_count * card.ability.extra.mult_per_card
        return { vars = { card.ability.extra.mult_per_card, current_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local deck_count = (G.deck and G.deck.cards) and #G.deck.cards or 0
            local current_mult = deck_count * card.ability.extra.mult_per_card
            return {
                mult_mod = current_mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { current_mult } }
            }
        end
    end
})

-- 613: Pendulum
SMODS.Joker({
    unlocked = true,
    key = 'j_time_pendulum',
    discovered = true,
    config = { extra = { xmult_low = 0.5, xmult_high = 2.0, state = 'low' } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_pendulum',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local current = (card.ability.extra.state == 'low') and card.ability.extra.xmult_low or card.ability.extra.xmult_high
        return { vars = { card.ability.extra.xmult_low, card.ability.extra.xmult_high, current } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local current = (card.ability.extra.state == 'low') and card.ability.extra.xmult_low or card.ability.extra.xmult_high
            return {
                x_mult = current,
                message = localize { type = 'variable', key = 'a_xmult', vars = { current } }
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.state = (card.ability.extra.state == 'low') and 'high' or 'low'
        end
    end
})

-- 614: Metronome
SMODS.Joker({
    unlocked = true,
    key = 'j_time_metronome',
    discovered = true,
    config = { extra = { mult = 20, last_count = nil } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_metronome',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult, extra.last_count or '?' } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.last_count and #context.full_hand == card.ability.extra.last_count then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
        if context.after and not context.blueprint then
            card.ability.extra.last_count = #context.full_hand
        end
    end
})

-- 615: Time Zone
SMODS.Joker({
    unlocked = true,
    key = 'j_time_zone',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_time_zone',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:is_suit('Spades') or context.other_card:is_suit('Hearts') then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- 616: Ice Age
SMODS.Joker({
    unlocked = true,
    key = 'j_time_ice_age',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_time_ice_age',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card) G.GAME.odyssey_ice_age_active = (G.GAME.odyssey_ice_age_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_ice_age_active = (G.GAME.odyssey_ice_age_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 617: Stone Age
SMODS.Joker({
    unlocked = true,
    key = 'j_time_stone_age',
    discovered = true,
    rarity = 1,
    cost = 4,
    atlas = 'j_time_stone_age',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local front_cards = {}
            for k, v in ipairs(G.playing_cards) do
                if not v.config.center_key or v.config.center_key == 'c_base' then
                    table.insert(front_cards, v)
                end
            end
            if #front_cards > 0 then
                local target = pseudorandom_element(front_cards, pseudoseed('stone_age'))
                target:set_ability(G.P_CENTERS.m_odyssey_emerald)
                return {
                    message = localize('k_stone'),
                    colour = G.C.GREY
                }
            end
        end
    end
})

-- 618: Bronze Age
SMODS.Joker({
    unlocked = true,
    key = 'j_time_bronze_age',
    discovered = true,
    config = { extra = { chips = 15 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_bronze_age',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local rank = context.other_card:get_id()
            if rank >= 2 and rank <= 10 then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
})

-- 619: Iron Age
SMODS.Joker({
    unlocked = true,
    key = 'j_time_iron_age',
    discovered = true,
    config = { extra = { chips = 30 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_iron_age',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_platinum then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
})

-- 620: Future
SMODS.Joker({
    unlocked = true,
    key = 'j_time_future',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 1,
    cost = 4,
    atlas = 'j_time_future',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})
