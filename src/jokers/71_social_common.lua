----------------------------------------------
-- SOCIAL & META (COMMON) J801-J820
----------------------------------------------

-- J801 Audience
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_audience',
    config = { extra = { mult_per = 4 } },
    rarity = 1,
    atlas = 'j_social_audience',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult_per, (G.GAME and G.GAME.current_round.hands_played or 0) * extra.mult_per } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local mult = (G.GAME.current_round.hands_played or 0) * card.ability.extra.mult_per
            if mult > 0 then
                return {
                    mult_mod = mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { mult } }
                }
            end
        end
    end
})

-- J802 Critic
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_critic',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_social_critic',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.chips < G.GAME.blind.chips * 0.2 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Lixo!", colour = G.C.RED})
            end
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J803 Fan
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_fan',
    config = { extra = { mult = 5 } },
    rarity = 1,
    atlas = 'j_social_fan',
    pos = { x = 0, y = 0 },
    cost = 3,
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
        if context.end_of_round and G.GAME.chips >= G.GAME.blind.chips and not context.repetition and not context.other_card then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Bom trabalho!", colour = G.C.GREEN})
        end
    end
})

-- J804 Hater
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_hater',
    config = { extra = { mult = 20 } },
    rarity = 1,
    atlas = 'j_social_hater',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('hater') < 0.2 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Vai perder!", colour = G.C.RED})
            end
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J805 Streamer (Simulated. $1 per blind entered)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_streamer',
    config = { extra = { dollars = 2 } },
    rarity = 1,
    atlas = 'j_social_streamer',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            ease_dollars(card.ability.extra.dollars)
            return {
                message = localize('$')..card.ability.extra.dollars,
                colour = G.C.MONEY,
                card = card
            }
        end
    end
})

-- J806 Chat
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_chat',
    config = { extra = { chips = 10 } },
    rarity = 1,
    atlas = 'j_social_chat',
    pos = { x = 0, y = 0 },
    cost = 2,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local messages = {"KAPPA", "LUL", "POG", "RIGGED", "777"}
            if pseudorandom('chat') < 0.3 then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = messages[math.floor(pseudorandom('chat_msg')*#messages)+1], colour = G.C.BLUE})
            end
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- J807 Moderator (Prevents playing if < 2 discards left? No, "prevents bad hands")
-- Let's say: High Card is disabled.
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_moderator',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_social_moderator',
    pos = { x = 0, y = 0 },
    cost = 4,
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

-- J808 Troll
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_troll',
    config = { extra = { mult = 30, chance = 10 } },
    rarity = 1,
    atlas = 'j_social_troll',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('troll') < G.GAME.probabilities.normal / card.ability.extra.chance then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, #G.hand.cards do
                            G.hand.cards[i]:start_dissolve()
                        end
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Problem?!", colour = G.C.FILTER})
            end
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J809 Lurker
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_lurker',
    config = { extra = { rounds = 0, req = 10, x_mult = 3 } },
    rarity = 1,
    atlas = 'j_social_lurker',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.rounds, extra.req, extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.req then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Ativado!", colour = G.C.PURPLE})
            end
        end
        if context.joker_main and card.ability.extra.rounds >= card.ability.extra.req then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- J810 Subscriber
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_subscriber',
    config = { extra = { rounds = 0, dollars = 5, every = 4 } },
    rarity = 1,
    atlas = 'j_social_subscriber',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.rounds, extra.every, extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds % card.ability.extra.every == 0 then
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- J811 Sponsor
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_sponsor',
    config = { extra = { dollars = 10 } },
    rarity = 1,
    atlas = 'j_social_sponsor',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if G.GAME.round_resets.ante > (card.ability.extra.last_ante or 0) then
                card.ability.extra.last_ante = G.GAME.round_resets.ante
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- J812 Ad (Simpler: $5 end of round, blocks view of played hand score)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_ad',
    config = { extra = { dollars = 5 } },
    rarity = 1,
    atlas = 'j_social_ad',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
             ease_dollars(card.ability.extra.dollars)
             return {
                message = localize('$')..card.ability.extra.dollars,
                colour = G.C.MONEY
            }
        end
        if context.joker_main then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "PROPAGANDA", colour = G.C.RED})
        end
    end
})

-- J813 Clickbait
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_clickbait',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_social_clickbait',
    pos = { x = 0, y = 0 },
    cost = 2,
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

-- J814 Viral
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_viral',
    config = { extra = { dollars = 10, threshold = 10000 } },
    rarity = 1,
    atlas = 'j_social_viral',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.dollars, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
             if G.GAME.chips > card.ability.extra.threshold then
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = "VIRAL! "..localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
             end
        end
    end
})

-- J815 Meme
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_meme',
    config = { extra = { chips = 69 } },
    rarity = 1,
    atlas = 'j_social_meme',
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_6 = false
            local has_9 = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 6 then has_6 = true end
                if context.scoring_hand[i]:get_id() == 9 then has_9 = true end
            end
            if has_6 and has_9 then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = "Nice.",
                    colour = G.C.CHIPS
                }
            end
        end
    end
})

-- J816 Emoji
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_emoji',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_social_emoji',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "😂",
                colour = G.C.MULT
            }
        end
    end
})

-- J817 Hashtag
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_hashtag',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_social_hashtag',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "#Balatro",
                colour = G.C.MULT
            }
        end
    end
})

-- J818 Trending
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_trending',
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    atlas = 'j_social_trending',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult, G.GAME.odyssey_last_suit or 'N/A' } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local is_suit = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit(G.GAME.odyssey_last_suit or 'Spades') then
                    is_suit = true
                    break
                end
            end
            if is_suit then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            -- Logic to update odyssey_last_suit will be in vanilla_override
        end
    end
})

-- J819 Canceled
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_canceled',
    config = { extra = { face_card = 'King' } },
    rarity = 1,
    atlas = 'j_social_canceled',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.face_card } }

    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local faces = {'Jack', 'Queen', 'King'}
            card.ability.extra.face_card = faces[math.floor(pseudorandom('cancel')*#faces)+1]
        end
    end
})

-- J820 Influencer
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_influencer',
    config = { extra = { mult_per = 2 } },
    rarity = 1,
    atlas = 'j_social_influencer',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = (G.jokers and G.jokers.cards) and #G.jokers.cards or 1
        return { vars = { card.ability.extra.mult_per, (count - 1) * card.ability.extra.mult_per } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local mult = (#G.jokers.cards - 1) * card.ability.extra.mult_per
            if mult > 0 then
                return {
                    mult_mod = mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { mult } }
                }
            end
        end
    end
})
