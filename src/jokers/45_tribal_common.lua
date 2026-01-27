SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_squire',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_squire',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_jack = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 11 then
                    has_jack = true
                    break
                end
            end
            if has_jack then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_lady_in_waiting',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_lady_in_waiting',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_queen = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 12 then
                    has_queen = true
                    break
                end
            end
            if has_queen then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_royal_guard',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_royal_guard',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_king = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 13 then
                    has_king = true
                    break
                end
            end
            if has_king then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_jester',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_jester',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_ace = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 14 then
                    has_ace = true
                    break
                end
            end
            if has_ace then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_warrior',
    discovered = true,
    config = { extra = { chips = 20 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_warrior',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Spades') then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips * count}},
                    chip_mod = card.ability.extra.chips * count
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_mage',
    discovered = true,
    config = { extra = { mult = 4 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_mage',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Clubs') then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult * count}},
                    mult_mod = card.ability.extra.mult * count
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_rogue',
    discovered = true,
    config = { extra = { money = 1 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_rogue',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                G.GAME.dollar_cap = G.GAME.dollar_cap or 0
                ease_dollars(card.ability.extra.money)
                return {
                    extra = {focus = context.other_card, message = localize('$')..card.ability.extra.money, colour = G.C.MONEY},
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_cleric',
    discovered = true,
    config = { extra = { hearts_needed = 5, hand_gained = 1 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_cleric',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.hearts_needed, extra.hand_gained } }

    end,
    calculate = function(self, card, context)
        if context.after_hand and not context.blueprint then
            local hearts = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit('Hearts') then
                    hearts = hearts + 1
                end
            end
            if hearts >= card.ability.extra.hearts_needed and not G.GAME.current_round.odyssey_cleric_activated then
                G.GAME.current_round.odyssey_cleric_activated = true
                ease_hands_played(card.ability.extra.hand_gained)
                return {
                    message = localize('k_plus_one_hand'),
                    colour = G.C.CHIPS
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_barbarian',
    discovered = true,
    config = { extra = { mult = 30 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_barbarian',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_face = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:is_face() then
                    has_face = true
                    break
                end
            end
            if not has_face then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_paladin',
    discovered = true,
    config = { extra = { chips = 50 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_paladin',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_face = true
            for i = 1, #context.full_hand do
                if not context.full_hand[i]:is_face() then
                    all_face = false
                    break
                end
            end
            if all_face and #context.full_hand > 0 then
                return {
                    message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}},
                    chip_mod = card.ability.extra.chips
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_druid',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_druid',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            local suit_count = 0
            for i = 1, #context.scoring_hand do
                local suit = context.scoring_hand[i].base.suit
                if not suits[suit] then
                    suits[suit] = true
                    suit_count = suit_count + 1
                end
            end
            if suit_count > 1 then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_necromancer',
    discovered = true,
    config = { extra = {} },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_necromancer',
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and G.GAME.last_destroyed_face_card then
            local card_data = G.GAME.last_destroyed_face_card
            G.GAME.last_destroyed_face_card = nil
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = create_playing_card(G.P_CARDS[card_data.card_key], G.deck, nil, nil, nil)
                    
                    _card:set_ability(card_data.ability)
                    _card:set_edition(card_data.edition)
                    _card:set_seal(card_data.seal)
                    _card:juice_up()
                    
                    return true
                end
            }))
            return {
                message = localize('k_plus_card'),
                colour = G.C.BLUE
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_bard',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_bard',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end
        if context.repetition and context.cardarea == G.play then
            -- Retrigger last face card played
            local last_face = nil
            for i = #context.scoring_hand, 1, -1 do
                if context.scoring_hand[i]:is_face() then
                    last_face = context.scoring_hand[i]
                    break
                end
            end
            if last_face and context.other_card == last_face then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_monk',
    discovered = true,
    config = { extra = { chips = 20 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_monk',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.scoring_hand do
                local id = context.scoring_hand[i]:get_id()
                if id >= 2 and id <= 4 then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips * count}},
                    chip_mod = card.ability.extra.chips * count
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_hunter',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_hunter',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind and G.GAME.blind.boss then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_blacksmith',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_blacksmith',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_platinum or context.other_card.ability.effect == 'Steel Card' then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_platinum or context.other_card.ability.effect == 'Steel Card' then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_merchant',
    discovered = true,
    config = { extra = { money = 2 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_merchant',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_plastic or context.other_card.ability.effect == 'Gold Card' then
                ease_dollars(card.ability.extra.money)
                return {
                    extra = {focus = context.other_card, message = localize('$')..card.ability.extra.money, colour = G.C.MONEY},
                    card = card
                }
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_plastic or context.other_card.ability.effect == 'Gold Card' then
                ease_dollars(card.ability.extra.money)
                return {
                    extra = {focus = context.other_card, message = localize('$')..card.ability.extra.money, colour = G.C.MONEY},
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_alchemist',
    discovered = true,
    config = { extra = { odds = 5 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_alchemist',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal, extra.odds } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.c_base and pseudorandom('alchemist') < G.GAME.probabilities.normal / card.ability.extra.odds then
                context.other_card:set_ability(G.P_CENTERS.m_odyssey_platinum)
                return {
                    extra = {focus = context.other_card, message = localize('k_platinum'), colour = G.C.CHIPS},
                    card = card
                }
            end
        end
    end
})

SMODS.Joker({
    unlocked = true,
    key = 'j_tribal_seer',
    discovered = true,
    config = { extra = { mult = 5 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_seer',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local next_card = (G.deck and G.deck.cards) and G.deck.cards[#G.deck.cards] or nil
        local next_suit = next_card and next_card.base.suit or 'None'
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult, next_suit } }
    end,
    calculate = function(self, card, context)
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
    key = 'j_tribal_peasant',
    discovered = true,
    config = { extra = { mult = 5 } },
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    atlas = 'j_tribal_peasant',
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #context.scoring_hand do
                local id = context.scoring_hand[i]:get_id()
                if id >= 2 and id <= 5 then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult * count}},
                    mult_mod = card.ability.extra.mult * count
                }
            end
        end
    end
})
