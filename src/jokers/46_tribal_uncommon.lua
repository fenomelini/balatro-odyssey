SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_barbarian_king',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_barbarian_king',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local only_black = true
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_suit('Hearts') or context.full_hand[i]:is_suit('Diamonds') then
                    only_black = false
                    break
                end
            end
            if only_black and #context.full_hand > 0 then
                return {
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_fairy_queen',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_fairy_queen',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local only_red = true
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_suit('Spades') or context.full_hand[i]:is_suit('Clubs') then
                    only_red = false
                    break
                end
            end
            if only_red and #context.full_hand > 0 then
                return {
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_archmage',
    discovered = true,
    config = { extra = { mult_per_club = 10 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_archmage',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.playing_cards then
            for _, c in ipairs(G.playing_cards) do
                if c:is_suit('Clubs') then count = count + 1 end
            end
        end
        return { vars = { card.ability.extra.mult_per_club, count, count * card.ability.extra.mult_per_club } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for _, c in ipairs(G.playing_cards) do
                if c:is_suit('Clubs') then count = count + 1 end
            end
            if count > 0 then
                return {
                    message = localize{type='variable', key='a_mult', vars={count * card.ability.extra.mult_per_club}},
                    mult_mod = count * card.ability.extra.mult_per_club
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_grandmaster',
    discovered = true,
    config = { extra = { x_mult = 1.5 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_grandmaster',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_face() then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_assassin',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_assassin',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #G.hand.cards > 0 then
            local lowest_card = G.hand.cards[1]
            for i = 2, #G.hand.cards do
                if G.hand.cards[i]:get_id() < lowest_card:get_id() then
                    lowest_card = G.hand.cards[i]
                end
            end
            if not lowest_card.ability.eternal then lowest_card:start_dissolve() end
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_berserker',
    discovered = true,
    config = { extra = { mult = 50, discards = 1 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_berserker',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult, extra.discards } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_discard(-card.ability.extra.discards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_shaman',
    discovered = true,
    config = { extra = {} },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_shaman',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not G.GAME.current_round.odyssey_shaman_activated then
            G.GAME.current_round.odyssey_shaman_activated = true
            local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
            local new_suit = pseudorandom_element(suits, pseudoseed('shaman'))
            for i = 1, #G.hand.cards do
                G.hand.cards[i]:change_suit(new_suit)
            end
            return {
                message = localize('k_suit'),
                colour = G.C.PURPLE
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_knight',
    discovered = true,
    config = { extra = { chips = 0, chip_gain = 50 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_knight',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips, extra.chip_gain } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
        if context.end_of_round and G.GAME.blind and G.GAME.blind.boss and not context.blueprint and not context.other_card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_ninja',
    discovered = true,
    config = { extra = { odds = 4 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_ninja',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal, extra.odds } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() and pseudorandom('ninja') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = copy_card(context.other_card, nil)
                        _card:add_to_deck()
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                        _card:juice_up()
                        return true
                    end
                }))
                return {
                    extra = {focus = context.other_card, message = localize('k_plus_card'), colour = G.C.BLUE},
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_samurai',
    discovered = true,
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_samurai',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_viking',
    discovered = true,
    config = { extra = { money_per_card = 1 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_viking',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = G.GAME.viking_destroyed_count or 0
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).money_per_card, count, count * ( (card and card.ability and card.ability.extra) or self.config.extra ).money_per_card } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.other_card then
            local count = G.GAME.viking_destroyed_count or 0
            if count > 0 then
                ease_dollars(count * card.ability.extra.money_per_card)
                return {
                    message = localize('$')..(count * card.ability.extra.money_per_card),
                    colour = G.C.MONEY
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_pirate',
    discovered = true,
    config = { extra = { money = 3 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_pirate',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'Flush' then
            ease_dollars(card.ability.extra.money)
            return {
                message = localize('$')..card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_gladiator',
    discovered = true,
    config = { extra = { mult_per_card = 10 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_gladiator',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult_per_card } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = #G.hand.cards
            if count > 0 then
                return {
                    message = localize{type='variable', key='a_mult', vars={count * card.ability.extra.mult_per_card}},
                    mult_mod = count * card.ability.extra.mult_per_card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_musketeer',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_musketeer',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'Three of a Kind' then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_legionnaire',
    discovered = true,
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_legionnaire',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'Four of a Kind' then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_emperor',
    discovered = true,
    config = { extra = {} },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_emperor',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.current_round.hands_played == 1 and not context.blueprint and not context.other_card then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_emperor', 'emperor')
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_high_priestess',
    discovered = true,
    config = { extra = {} },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_high_priestess',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.current_round.discards_used == 0 and not context.blueprint and not context.other_card then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_high_priestess', 'high_priestess')
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_the_hermit',
    discovered = true,
    config = { extra = {} },
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_the_hermit',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.dollars == 0 and not context.blueprint and not context.other_card then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_hermit', 'hermit')
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.PURPLE
                }
            end
        end
    end
})
