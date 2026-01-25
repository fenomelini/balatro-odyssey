----------------------------------------------
-- PROFESSIONS GROUP (RARE)
----------------------------------------------

-- 539. CEO
SMODS.Joker({
    key = 'j_professions_ceo',
    atlas = 'j_professions_ceo',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3, money = 1 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult, extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            local dollars = #G.jokers.cards * card.ability.extra.money
            ease_dollars(dollars)
            return { message = localize('$')..dollars, colour = G.C.MONEY }
        end
    end
})

-- 540. President
SMODS.Joker({
    key = 'j_professions_president',
    atlas = 'j_professions_president',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 4, money = 10 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult, extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
             ease_dollars(card.ability.extra.money)
            return { message = localize('$')..card.ability.extra.money, colour = G.C.MONEY }
        end
    end
})

-- 541. Dictator
SMODS.Joker({
    key = 'j_professions_dictator',
    atlas = 'j_professions_dictator',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 5 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             -- Only works if playing the most played hand
             local most_played = 'High Card'
             local max_p = 0
             for k, v in pairs(G.GAME.hands) do
                 if v.played > max_p then
                     max_p = v.played
                     most_played = k
                 end
             end
             if context.scoring_name == most_played then
                return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
             end
        end
    end
})

-- 542. Revolutionary
SMODS.Joker({
    key = 'j_professions_revolutionary',
    atlas = 'j_professions_revolutionary',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.other_card then
            local most_expensive = nil
            local max_cost = -1
            for i=1, #G.jokers.cards do
                local j = G.jokers.cards[i]
                if j ~= card and j.cost > max_cost then
                    max_cost = j.cost
                    most_expensive = j
                end
            end
            if most_expensive then
                most_expensive:start_dissolve()
                G.GAME.odyssey_revolutionary_active = (G.GAME.odyssey_revolutionary_active or 0) + 1
                return {
                    message = "X3 Mult!",
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and G.GAME.odyssey_revolutionary_active and G.GAME.odyssey_revolutionary_active > 0 then
             local total_x = 3 ^ G.GAME.odyssey_revolutionary_active
             return { x_mult = total_x, message = "X"..total_x }
        end
    end
})

-- 543. Prophet
SMODS.Joker({
    key = 'j_professions_prophet',
    atlas = 'j_professions_prophet',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    add_to_deck = function(self, card)
        G.GAME.modifiers.booster_view_all = true
    end,
    remove_from_deck = function(self, card)
        G.GAME.modifiers.booster_view_all = false
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
        end
    end
})

-- 544. Magician
SMODS.Joker({
    key = 'j_professions_magician',
    atlas = 'j_professions_magician',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card) G.GAME.odyssey_magician_active = (G.GAME.odyssey_magician_active or 0) + 1 end,
    remove_from_deck = function(self, card) G.GAME.odyssey_magician_active = (G.GAME.odyssey_magician_active or 0) - 1 end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 545. Illusionist
SMODS.Joker({
    key = 'j_professions_illusionist',
    atlas = 'j_professions_illusionist',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
        end
    end
})

-- 546. Hypnotist
SMODS.Joker({
    key = 'j_professions_hypnotist',
    atlas = 'j_professions_hypnotist',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'Straight' then
            local has_face = false
            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() >= 11 and v:get_id() <= 13 then has_face = true break end
            end
            if has_face then
                return { x_mult = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}} }
            end
        end
    end
})

-- 547. Beast Tamer
SMODS.Joker({
    key = 'j_professions_beast_tamer',
    atlas = 'j_professions_beast_tamer',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 2 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_wild then
                return { x_mult = card.ability.extra.x_mult, card = card }
            end
        end
    end
})

-- 548. Foreman
SMODS.Joker({
    key = 'j_professions_foreman',
    atlas = 'j_professions_foreman',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { rounds = 0 } },
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.rounds } }

    end,
    calculate = function(self, card, context)
         if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == 5 then
                 G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                 return { left = true, message = localize('k_plus_joker_slot') }
            end
         end
    end
})

