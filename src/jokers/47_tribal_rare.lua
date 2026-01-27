SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_council_of_kings',
    discovered = true,
    config = { extra = { x_mult = 4, count_needed = 4, rank = 13 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_council_of_kings',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.count_needed } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == card.ability.extra.rank then
                    count = count + 1
                end
            end
            if count >= card.ability.extra.count_needed then
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
    key = 'j_tribal_harem',
    discovered = true,
    config = { extra = { x_mult = 4, count_needed = 4, rank = 12 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_harem',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.count_needed } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == card.ability.extra.rank then
                    count = count + 1
                end
            end
            if count >= card.ability.extra.count_needed then
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
    key = 'j_tribal_brotherhood',
    discovered = true,
    config = { extra = { x_mult = 4, count_needed = 4, rank = 11 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_brotherhood',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.count_needed } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == card.ability.extra.rank then
                    count = count + 1
                end
            end
            if count >= card.ability.extra.count_needed then
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
    key = 'j_tribal_mage_circle',
    discovered = true,
    config = { extra = { consumable_slots = 1 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_mage_circle',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.consumable_slots } }

    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable_slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable_slots
    end,
    calculate = function(self, card, context)
        -- Passive effect for Tarot frequency handled in pool overrides
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_thieves_guild',
    discovered = true,
    config = { extra = { money = 1 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_thieves_guild',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.after_hand then
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
    key = 'j_tribal_holy_order',
    discovered = true,
    config = { extra = { mult = 20 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_holy_order',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #G.hand.cards do
                G.hand.cards[i].debuff = false
            end
            return {
                message = localize('k_active_ex'),
                colour = G.C.WHITE
            }
        end
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_shadow_army',
    discovered = true,
    config = { extra = {} },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_shadow_army',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            local cards_to_copy = {}
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_face() then
                    table.insert(cards_to_copy, context.scoring_hand[i])
                end
            end
            if #cards_to_copy > 0 then
                for _, face_card in ipairs(cards_to_copy) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = copy_card(face_card, nil)
                            _card:add_to_deck()
                            table.insert(G.playing_cards, _card)
                            G.deck:emplace(_card)
                            _card:juice_up()
                            return true
                        end
                    }))
                end
                return {
                    message = localize('k_plus_card'),
                    colour = G.C.BLUE
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_champion',
    discovered = true,
    config = { extra = { x_mult = 3, permanent_gain = 0.5 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_champion',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.permanent_gain } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
        if context.end_of_round and G.GAME.blind and G.GAME.blind.boss and not context.blueprint and not context.other_card then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.permanent_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_dark_lord',
    discovered = true,
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_dark_lord',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            local face_cards = {}
            for i = #G.playing_cards, 1, -1 do
                if G.playing_cards[i]:is_face() then
                    table.insert(face_cards, G.playing_cards[i])
                end
            end
            for _, face_card in ipairs(face_cards) do
                if not face_card.ability.eternal then face_card:start_dissolve() end
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_hero',
    discovered = true,
    config = { extra = { x_mult = 5, hands_needed = 1 } },
    rarity = 3,
    cost = 9,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_hero',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult, extra.hands_needed } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == card.ability.extra.hands_needed then
            return {
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                x_mult = card.ability.extra.x_mult
            }
        end
    end
})
