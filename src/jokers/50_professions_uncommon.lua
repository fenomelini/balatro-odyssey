----------------------------------------------
-- PROFESSIONS GROUP (UNCOMMON)
----------------------------------------------

-- 521. Surgeon
SMODS.Joker({
    key = 'j_professions_surgeon',
    atlas = 'j_professions_surgeon',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint and #context.full_hand == 2 then
            local card1 = context.full_hand[1]
            local card2 = context.full_hand[2]
            if card1.base.value == card2.base.value then
                local new_rank = card1.base.id + 1
                if new_rank > 14 then new_rank = 14 end
                
                -- Construct key: 10 -> T, 11 -> J, etc.
                local rank_suffix = tostring(new_rank)
                if new_rank == 10 then rank_suffix = 'T'
                elseif new_rank == 11 then rank_suffix = 'J'
                elseif new_rank == 12 then rank_suffix = 'Q'
                elseif new_rank == 13 then rank_suffix = 'K'
                elseif new_rank == 14 then rank_suffix = 'A'
                end
                local suit_prefix = card1.base.suit:sub(1,1)
                local target_key = suit_prefix..'_'..rank_suffix
                
                if G.P_CARDS[target_key] then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            local _card = create_playing_card({front = G.P_CARDS[target_key], center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                            _card:juice_up()
                            return true
                        end
                    }))
                    return {
                        message = localize('k_active_ex'),
                        card = card
                    }
                end
            end
        end
    end
})

-- 522. Chemist
SMODS.Joker({
    key = 'j_professions_chemist',
    atlas = 'j_professions_chemist',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local cards_to_change = {}
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i].config.center == G.P_CENTERS.m_odyssey_plastic then
                    cards_to_change[#cards_to_change+1] = context.scoring_hand[i]
                end
            end
            if #cards_to_change > 0 then
                for i=1, #cards_to_change do
                    cards_to_change[i]:set_ability(G.P_CENTERS.m_odyssey_platinum)
                    cards_to_change[i]:juice_up()
                end
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.GOLD
                }
            end
        end
    end
})

-- 523. Geologist
SMODS.Joker({
    key = 'j_professions_geologist',
    atlas = 'j_professions_geologist',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 50 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_emerald then
                return { chips = card.ability.extra.chips, card = card }
            end
        end
    end
})

-- 524. Botanist
SMODS.Joker({
    key = 'j_professions_botanist',
    atlas = 'j_professions_botanist',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 1.5 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Clubs') then
                return { x_mult = card.ability.extra.x_mult, card = card }
            end
        end
    end
})

-- 525. Zoologist
SMODS.Joker({
    key = 'j_professions_zoologist',
    atlas = 'j_professions_zoologist',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
         if context.joker_main and next(context.poker_hands['Pair']) then
             return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
        end
    end
})

-- 526. Archaeologist
SMODS.Joker({
    key = 'j_professions_archaeologist',
    atlas = 'j_professions_archaeologist',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    add_to_deck = function(self, card) G.GAME.odyssey_archaeologist_active = (G.GAME.odyssey_archaeologist_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_archaeologist_active = (G.GAME.odyssey_archaeologist_active or 0) - 1 end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local is_old = false
            for i=1, math.min(10, #G.deck.cards) do
                if G.deck.cards[i] == context.other_card then is_old = true break end
            end
            if is_old then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})

-- 527. Historian
SMODS.Joker({
    key = 'j_professions_historian',
    atlas = 'j_professions_historian',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
         if context.joker_main then
             local r = G.GAME.round or 0
             return { mult_mod = r, message = localize{type='variable',key='a_mult',vars={r}} }
        end
    end
})

-- 528. Futurist
SMODS.Joker({
    key = 'j_professions_futurist',
    atlas = 'j_professions_futurist',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
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

-- 529. Investor
SMODS.Joker({
    key = 'j_professions_investor',
    atlas = 'j_professions_investor',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.other_card then
            if G.GAME.dollars >= 50 then
                ease_dollars(5)
                return {
                    message = "$5",
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 530. Banker
SMODS.Joker({
    key = 'j_professions_banker',
    atlas = 'j_professions_banker',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_banker_active = (G.GAME.odyssey_banker_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_banker_active = (G.GAME.odyssey_banker_active or 0) - 1 end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.other_card then
            if G.GAME.odyssey_banker_money and G.GAME.odyssey_banker_money > 0 then
                ease_dollars(G.GAME.odyssey_banker_money)
                local m = G.GAME.odyssey_banker_money
                G.GAME.odyssey_banker_money = 0
                return {
                    message = "$" .. m,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 531. Cat Burglar
SMODS.Joker({
    key = 'j_professions_cat_burglar',
    atlas = 'j_professions_cat_burglar',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.buy_joker and not context.blueprint and not G.GAME.odyssey_cat_burglar_used then
             G.GAME.odyssey_cat_burglar_used = true
             ease_dollars(context.card.cost)
             return { message = "Stolen!", colour = G.C.MONEY }
        end
    end
})

-- 532. Spy
SMODS.Joker({
    key = 'j_professions_spy',
    atlas = 'j_professions_spy',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 10 } },
    loc_vars = function(self, info_queue, card)
        local next_card = (G.deck and G.deck.cards) and G.deck.cards[#G.deck.cards] or nil
        local display = "None"
        if next_card then
            display = next_card.base.value .. " of " .. next_card.base.suit
        end
        return { vars = { card.ability.extra.mult, display } }
    end,
    add_to_deck = function(self, card) G.GAME.odyssey_spy_active = (G.GAME.odyssey_spy_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_spy_active = (G.GAME.odyssey_spy_active or 0) - 1 end,
    calculate = function(self, card, context)
         if context.joker_main then
              return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
         end
    end
})

-- 533. Diplomat
SMODS.Joker({
    key = 'j_professions_diplomat',
    atlas = 'j_professions_diplomat',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_diplomat_active = (G.GAME.odyssey_diplomat_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_diplomat_active = (G.GAME.odyssey_diplomat_active or 0) - 1 end,
    calculate = function(self, card, context)
        -- Logic handled in Blind:set_blind override
    end
})

-- 534. General
SMODS.Joker({
    key = 'j_professions_general',
    atlas = 'j_professions_general',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
         if context.joker_main and G.GAME.current_round.hands_played == 0 then
             return { x_mult = card.ability.extra.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}} }
        end
    end
})

-- 535. Admiral
SMODS.Joker({
    key = 'j_professions_admiral',
    atlas = 'j_professions_admiral',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context)
         if context.joker_main and G.GAME.current_round.hands_left == 0 then
             return { x_mult = card.ability.extra.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}} }
        end
    end
})

-- 536. Astronaut
SMODS.Joker({
    key = 'j_professions_astronaut',
    atlas = 'j_professions_astronaut',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 20 } },
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

-- 537. Diver
SMODS.Joker({
    key = 'j_professions_diver',
    atlas = 'j_professions_diver',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 20 } },
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
         if context.joker_main then
            local black = true
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit('Hearts') or v:is_suit('Diamonds') then black = false end
            end
            if black then
                  return { mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
            end
         end
    end
})

-- 538. Pilot
SMODS.Joker({
    key = 'j_professions_pilot',
    atlas = 'j_professions_pilot',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    end,
    remove_from_deck = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
    end,
    calculate = function(self, card, context)
        -- Passive
    end
})

