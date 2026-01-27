-- ============================================
-- TIME & TURNS - Uncommon (Jokers 621-638)
-- ============================================

-- 621: Time Machine
SMODS.Joker({
    unlocked = true,
    key = 'j_time_machine',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_machine',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.selling_self then
            G.GAME.chips = 0
            G.GAME.current_round.hands_played = 0
            G.GAME.current_round.discards_used = 0
            G.GAME.current_round.hands_left = G.GAME.round_resets.hands
            G.GAME.current_round.discards_left = G.GAME.round_resets.discards
            return {
                message = localize('k_reset'),
                colour = G.C.BLUE
            }
        end
    end
})

-- 622: Back to the Future
SMODS.Joker({
    unlocked = true,
    key = 'j_time_back_to_the_future',
    discovered = true,
    config = { extra = { xmult = 3 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_back_to_the_future',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if not G.GAME.odyssey_first_hand_ever then
                G.GAME.odyssey_first_hand_ever = context.poker_hand
            end
            if context.poker_hand == G.GAME.odyssey_first_hand_ever then
                return {
                    x_mult = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
    end
})

-- 623: Doppler Effect
SMODS.Joker({
    unlocked = true,
    key = 'j_time_doppler_effect',
    discovered = true,
    config = { extra = { mult = 5 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_doppler_effect',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local pos = 1
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i] == context.other_card then
                    pos = i
                    break
                end
            end
            local bonus = pos * card.ability.extra.mult
            return {
                mult = bonus,
                card = card
            }
        end
    end
})

-- 624: Relativity
SMODS.Joker({
    unlocked = true,
    key = 'j_time_relativity',
    discovered = true,
    config = { extra = { chips = 100, xmult = 1.5, threshold = 5 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_relativity',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, extra.xmult, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local current_time = G.TIMERS.REAL
            local last_time = G.GAME.last_hand_time or current_time
            local diff = current_time - last_time
            if diff <= card.ability.extra.threshold then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            else
                return {
                    x_mult = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
        if context.after then
            G.GAME.last_hand_time = G.TIMERS.REAL
        end
    end
})

-- 625: Wormhole
SMODS.Joker({
    unlocked = true,
    key = 'j_time_wormhole',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_wormhole',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_wormhole_active = (G.GAME.odyssey_wormhole_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_wormhole_active = (G.GAME.odyssey_wormhole_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 626: Time Skip
SMODS.Joker({
    unlocked = true,
    key = 'j_time_skip',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_skip',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.blind.name == 'Small Blind' and G.GAME.current_round.hands_played == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind:skip()
                        G.STATE = G.STATES.NEW_ROUND
                        return true
                    end
                }))
            end
        end
    end
})

-- 627: Time Freeze
SMODS.Joker({
    unlocked = true,
    key = 'j_time_freeze',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_freeze',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_time_freeze_active = (G.GAME.odyssey_time_freeze_active or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_time_freeze_active = (G.GAME.odyssey_time_freeze_active or 1) - 1
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
             G.E_MANAGER:add_event(Event({func = function()
                 card:start_dissolve()
                 return true
             end}))
        end
    end
})

-- 628: Time Loop
SMODS.Joker({
    unlocked = true,
    key = 'j_time_loop',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_loop',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[1] then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 3,
                    card = card
                }
            end
        end
    end
})

-- 629: Grandfather Paradox
SMODS.Joker({
    unlocked = true,
    key = 'j_time_grandfather_paradox',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_grandfather_paradox',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        -- Logic is in G.FUNCS.die override in 03_vanilla_override.lua
    end
})

-- 630: Precognition
SMODS.Joker({
    unlocked = true,
    key = 'j_time_precognition',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_precognition',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_precognition = (G.GAME.odyssey_precognition or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_precognition = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 631: Deja Vu
SMODS.Joker({
    unlocked = true,
    key = 'j_time_deja_vu',
    discovered = true,
    config = { extra = { xmult = 2 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_deja_vu',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.last_poker_hand == context.poker_hand then
                return {
                    x_mult = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
        if context.after and not context.blueprint then
            G.GAME.last_poker_hand = context.poker_hand
        end
    end
})

-- 632: Eternity
SMODS.Joker({
    unlocked = true,
    key = 'j_time_eternity',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_eternity',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    calculate = function(self, card, context)
        for i = 1, #G.jokers.cards do
            local j = G.jokers.cards[i]
            if j.transient then
                j.transient = false
            end
        end
    end
})

-- 633: Ephemeral
SMODS.Joker({
    unlocked = true,
    key = 'j_time_ephemeral',
    discovered = true,
    config = { extra = { mult = 50, rounds = 3 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_ephemeral',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult, extra.rounds } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if not card.ability.eternal then card:start_dissolve() end
                        return true
                    end
                }))
                return {
                    message = localize('k_lost_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 634: Chronokinesis
SMODS.Joker({
    unlocked = true,
    key = 'j_time_chronokinesis',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_chronokinesis',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    add_to_deck = function(self, card)
        G.GAME.odyssey_chronokinesis = (G.GAME.odyssey_chronokinesis or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_chronokinesis = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 635: Synchronicity
SMODS.Joker({
    unlocked = true,
    key = 'j_time_synchronicity',
    discovered = true,
    config = { extra = { xmult = 3 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_synchronicity',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local first_rank = context.scoring_hand[1]:get_id()
            local all_same = true
            for i = 2, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() ~= first_rank then
                    all_same = false
                    break
                end
            end
            if all_same then
                return {
                    x_mult = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
    end
})

-- 636: Anachronism
SMODS.Joker({
    unlocked = true,
    key = 'j_time_anachronism',
    discovered = true,
    rarity = 2,
    cost = 6,
    atlas = 'j_time_anachronism',
    pos = { x = 0, y = 0 },
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.GAME.odyssey_anachronism = (G.GAME.odyssey_anachronism or 0) + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_anachronism = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 637: Lost Time
SMODS.Joker({
    unlocked = true,
    key = 'j_time_lost_time',
    discovered = true,
    config = { extra = { chips = 100 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_lost_time',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- 638: End Times
SMODS.Joker({
    unlocked = true,
    key = 'j_time_end_times',
    discovered = true,
    config = { extra = { xmult = 4 } },
    rarity = 2,
    cost = 6,
    atlas = 'j_time_end_times',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.blind.boss and G.GAME.current_round.hands_left == 0 then
                return {
                    x_mult = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
    end
})
