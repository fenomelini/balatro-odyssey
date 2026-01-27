local local_jokers = {
    {
        key = 'j_corruption_pestilence',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_pestilence',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = true,
        eternal_compat = true,
        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                local text, poker_hands, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
                if text == 'Flush' then
                    local suit = scoring_hand[1].base.suit
                    for k, v in ipairs(G.hand.cards) do
                        v:change_suit(suit)
                    end
                    return {
                        message = localize('k_infected'),
                        colour = G.C.PURPLE
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_famine',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_famine',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 5, hand_size_mod = -5 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.x_mult, extra.hand_size_mod } }

        end,
        add_to_deck = function(self, card, from_debuff)
            G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size_mod
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size_mod
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    x_mult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_corruption_war',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_war',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 0, gain = 10 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.mult, extra.gain } }

        end,
        calculate = function(self, card, context)
            if context.after and not context.blueprint then
                local destroyed_cards = {}
                for k, v in ipairs(G.hand.cards) do
                    if not v.ability.eternal then
                        destroyed_cards[#destroyed_cards+1] = v
                    end
                end
                if #destroyed_cards > 0 then
                    for _, v in ipairs(destroyed_cards) do
                        v:start_dissolve(nil, true)
                    end
                    card.ability.extra.mult = card.ability.extra.mult + (#destroyed_cards * card.ability.extra.gain)
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        colour = G.C.RED
                    }
                end
            end
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.end_of_round and not context.repetition and not context.other_card then
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
    },
    {
        key = 'j_corruption_death',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_death',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = false,
        eternal_compat = true,
        calculate = function(self, card, context)
            if context.after and not context.blueprint then
                if G.GAME.current_round.hands_left == 0 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            for k, v in ipairs(G.playing_cards) do
                                v:set_ability(G.P_CENTERS.m_odyssey_plastic, nil, true)
                            end
                            G.GAME.chips = G.GAME.blind.chips
                            return true
                        end
                    }))
                    return {
                        message = localize('k_death_win'),
                        colour = G.C.BLACK
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_apocalypse',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_apocalypse',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 1, gain = 10 } },
        blueprint_compat = false,
        eternal_compat = true,
        calculate = function(self, card, context)
            if context.selling_self and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        for k, v in pairs(G.jokers.cards) do
                            if v ~= card and not v.ability.eternal then
                                v:start_dissolve(nil, true)
                            end
                        end
                        local token = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_corruption_post_apocalypse')
                        token:add_to_deck()
                        G.jokers:emplace(token)
                        return true
                    end
                }))
            end
        end
    },
    {
        key = 'j_corruption_entropy',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_entropy',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = true,
        eternal_compat = true,
        calculate = function(self, card, context)
            if context.after and not context.blueprint then
                for k, v in ipairs(G.hand.cards) do
                    local new_rank = pseudorandom_element({'2','3','4','5','6','7','8','9','10','J','Q','K','A'}, pseudorandom('entropy_rank'))
                    local new_suit = pseudorandom_element({'Spades','Hearts','Clubs','Diamonds'}, pseudorandom('entropy_suit'))
                    v:set_base(G.P_CARDS[new_suit..'_'..new_rank])
                end
                return {
                    message = localize('k_chaos'),
                    colour = G.C.RED
                }
            end
        end
    },
    {
        key = 'j_corruption_absolute_chaos',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_absolute_chaos',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local suits = {}
                local unique_suits = 0
                for k, v in ipairs(context.scoring_hand) do
                    if not suits[v.base.suit] then
                        suits[v.base.suit] = true
                        unique_suits = unique_suits + 1
                    end
                end
                if unique_suits > 0 then
                    local mult = card.ability.extra.x_mult ^ unique_suits
                    return {
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { mult } },
                        x_mult_mod = mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_the_end',
        rarity = 3,
        cost = 8,
        atlas = 'j_corruption_the_end',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 100 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if G.GAME.current_round.hands_left == 1 and G.GAME.current_round.discards_left == 0 then
                        return {
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                        x_mult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_post_apocalypse',
        rarity = 1,
        cost = 0,
        atlas = 'j_corruption_apocalypse',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 10 } },
        blueprint_compat = true,
        eternal_compat = true,
        yes_pool_flag = 'post_apocalypse_token',
        in_pool = function() return false end,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

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
        end
    }
}

for _, joker in ipairs(local_jokers) do
    joker.unlocked = true
    joker.discovered = true
    SMODS.Joker(joker)
end
