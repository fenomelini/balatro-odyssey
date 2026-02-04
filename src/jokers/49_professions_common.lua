----------------------------------------------
-- PROFESSIONS GROUP (COMMON)
----------------------------------------------

-- 501. Miner
SMODS.Joker({
    key = 'j_professions_miner',
    atlas = 'j_professions_miner',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chance = 4 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card then -- Trigger once per discard action
             if pseudorandom('miner') < G.GAME.probabilities.normal / card.ability.extra.chance then
                 G.E_MANAGER:add_event(Event({func = function()
                     local c = create_playing_card(pseudorandom_element(G.P_CARDS, pseudoseed('miner_card')), G.deck, nil, nil, nil)
                     c:set_ability(G.P_CENTERS.m_odyssey_emerald)
                     c:add_to_deck()
                     G.deck:emplace(c)
                     return true
                 end}))
                 return { message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced }
             end
        end
    end
})

-- 502. Farmer
SMODS.Joker({
    key = 'j_professions_farmer',
    atlas = 'j_professions_farmer',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for k, v in pairs(G.playing_cards) do
                local id = v:get_id()
                if id >= 2 and id <= 5 then count = count + 1 end
            end
             return { mult_mod = count * card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={count * card.ability.extra.mult}} }
        end
    end
})

-- 503. Fisherman
SMODS.Joker({
    key = 'j_professions_fisherman',
    atlas = 'j_professions_fisherman',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chance = 3 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
             if pseudorandom('fisherman') < G.GAME.probabilities.normal / card.ability.extra.chance then
                 G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.4,
                    func = function()
                        local card_type = pseudorandom_element({'Tarot', 'Planet', 'Spectral'}, pseudoseed('fish'))
                        local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, 'fish')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        return true
                    end
                }))
                return { message = localize('k_plus_card'), colour = G.C.SECONDARY_SET.Tarot }
             end
        end
    end
})

-- 504. Chef
SMODS.Joker({
    key = 'j_professions_chef',
    atlas = 'j_professions_chef',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if #G.jokers.cards < G.jokers.config.card_limit then
                local food_jokers = { 'j_gros_michel', 'j_ice_cream', 'j_turtle_bean', 'j_popcorn', 'j_ramen', 'j_selzer' }
                local chosen_food = food_jokers[pseudorandom('chef', 1, #food_jokers)]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_food, 'chef')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        return true
                    end
                }))
                return { message = localize('k_plus_joker'), colour = G.C.BLUE }
            end
        end
    end
})

-- 505. Doctor
SMODS.Joker({
    key = 'j_professions_doctor',
    atlas = 'j_professions_doctor',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.game_over and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.card_eval_status_text:ease_text(localize('k_saved_ex'), 0.5, 0.5, 0.5)
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                    if not card.ability.eternal then card:start_dissolve() end
                    return true
                end
            }))
            return { saved = true }
        end
    end
})

-- 506. Engineer
SMODS.Joker({
    key = 'j_professions_engineer',
    atlas = 'j_professions_engineer',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.current_round.hands_played == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end
                }))
                return { message = localize('k_plus_joker_slot'), colour = G.C.DARK_EDITION }
            end
        end
    end
})

-- 507. Architect
SMODS.Joker({
    key = 'j_professions_architect',
    atlas = 'j_professions_architect',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { hand_size = 1 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.hand_size } }

    end,
    add_to_deck = function(self, card) G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size end,
    remove_from_deck = function(self, card) G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 508. Astronomer
SMODS.Joker({
    key = 'j_professions_astronomer',
    atlas = 'j_professions_astronomer',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_astronomer_planets_free = (G.GAME.odyssey_astronomer_planets_free or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_astronomer_planets_free = (G.GAME.odyssey_astronomer_planets_free or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 509. Librarian
SMODS.Joker({
    key = 'j_professions_librarian',
    atlas = 'j_professions_librarian',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 10 } },
    loc_vars = function(self, info_queue, card)
        local views = G.GAME.odyssey_deck_clicks or 0
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).chips, views, ( (card and card.ability and card.ability.extra) or self.config.extra ).chips * views } }
    end,
    add_to_deck = function(self, card) G.GAME.odyssey_librarian_active = (G.GAME.odyssey_librarian_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_librarian_active = (G.GAME.odyssey_librarian_active or 0) - 1 end,
    calculate = function(self, card, context)
         if context.joker_main then
              local views = G.GAME.odyssey_deck_clicks or 0
              return { chip_mod = views * card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={views * card.ability.extra.chips}} }
        end
    end
})

-- 510. Mailman
SMODS.Joker({
    key = 'j_professions_mailman',
    atlas = 'j_professions_mailman',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { dollars = 1 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card and context.other_card:get_id() == 14 then
             ease_dollars(card.ability.extra.dollars)
             return { message = localize('$')..card.ability.extra.dollars, colour = G.C.MONEY }
        end
    end
})

-- 511. Firefighter
SMODS.Joker({
    config = { odyssey_immune = true },
    key = 'j_professions_firefighter',
    atlas = 'j_professions_firefighter',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_firefighter_active = (G.GAME.odyssey_firefighter_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_firefighter_active = (G.GAME.odyssey_firefighter_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 512. Police
SMODS.Joker({
    key = 'j_professions_police',
    atlas = 'j_professions_police',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { dollars = 5 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
             ease_dollars(card.ability.extra.dollars)
             return { message = localize('$')..card.ability.extra.dollars, colour = G.C.MONEY }
        end
    end
})

-- 513. Judge
SMODS.Joker({
    key = 'j_professions_judge',
    atlas = 'j_professions_judge',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 10 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.scoring_hand == 5 then
             return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
        end
    end
})

-- 514. Lawyer
SMODS.Joker({
    key = 'j_professions_lawyer',
    atlas = 'j_professions_lawyer',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 15 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
        end
    end
})

-- 515. Teacher
SMODS.Joker({
    key = 'j_professions_teacher',
    atlas = 'j_professions_teacher',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult_gain = 2, mult = 0 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult_gain, extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
        end
    end
})

-- 516. Student
SMODS.Joker({
    key = 'j_professions_student',
    atlas = 'j_professions_student',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 0, gain = 1, rounds = 0, graduated = false } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.gain, extra.mult, extra.rounds, (extra.graduated and 2 or 1) } }

    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds >= 10 then card.ability.extra.graduated = true end
            if not card.ability.extra.graduated then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
            end
            return { message = localize('k_upgrade_ex') }
        end
        if context.joker_main then
            if card.ability.extra.graduated then
                 return { x_mult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
            else
                 return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
            end
        end
    end
})

-- 517. Scientist
SMODS.Joker({
    key = 'j_professions_scientist',
    atlas = 'j_professions_scientist',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chance = 4 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
             if pseudorandom('scientist') < G.GAME.probabilities.normal / card.ability.extra.chance then
                local card_to_upgrade = pseudorandom_element(context.scoring_hand, pseudoseed('scientist_card'))
                local enhancements = { 'm_bonus', 'm_mult', 'm_wild', 'm_odyssey_ceramic', 'm_odyssey_platinum', 'm_odyssey_emerald', 'm_odyssey_plastic', 'm_lucky' }
                local enhancement = pseudorandom_element(enhancements, pseudoseed('scientist_enh'))
                card_to_upgrade:set_ability(G.P_CENTERS[enhancement])
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card_to_upgrade
                }
             end
        end
    end
})

-- 518. Artist
SMODS.Joker({
    key = 'j_professions_artist',
    atlas = 'j_professions_artist',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 10 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                 return { chips = card.ability.extra.chips, card = card }
            end
        end
    end
})

-- 519. Musician
SMODS.Joker({
    key = 'j_professions_musician',
    atlas = 'j_professions_musician',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 10 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
         if context.joker_main and next(context.poker_hands['Straight']) then
              return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
        end
    end
})

-- 520. Actor
SMODS.Joker({
    key = 'j_professions_actor',
    atlas = 'j_professions_actor',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        local right_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                right_joker = G.jokers.cards[i+1]
                break
            end
        end
        if right_joker and right_joker ~= card then
            context.blueprint = (context.blueprint or 0) + 1
            context.blueprint_card = card
            local res = right_joker:calculate_joker(context)
            if res then
                res.card = card
                return res
            end
        end
    end
})

