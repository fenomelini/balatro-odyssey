local local_jokers = {
    {
        key = 'j_corruption_blood_pact',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_blood_pact',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 30, hands_lost = 1 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
                if G.GAME.round_resets.hands > 1 then
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands_lost
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = '-1 Hand'})
                end
            end
        end
    },
    {
        key = 'j_corruption_sold_soul',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_sold_soul',
        pos = { x = 0, y = 0 },
        config = { extra = { chips = 100 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.chips } }

        end,
        add_to_deck = function(self, card, from_debuff)
            ease_dollars(-G.GAME.dollars, true)
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    },
    {
        key = 'j_corruption_cursed_blade',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_cursed_blade',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 15 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.after and not context.blueprint then
                if context.scoring_hand and #context.scoring_hand > 0 then
                    local target = context.scoring_hand[#context.scoring_hand]
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target:start_dissolve()
                            return true
                        end
                    }))
                    return {
                        message = localize('k_destroyed'),
                        colour = G.C.RED
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_poisoned_chalice',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_poisoned_chalice',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2, dollars = 2 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.x_mult, extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
            if context.after and not context.blueprint then
                ease_dollars(-card.ability.extra.dollars)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = '-$'..card.ability.extra.dollars, colour = G.C.MONEY})
            end
        end
    },
    {
        key = 'j_corruption_minor_sacrifice',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_minor_sacrifice',
        pos = { x = 0, y = 0 },
        config = { extra = { dollars = 3 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.discard and #context.full_hand == 1 and not context.blueprint then
                return {
                    message = localize('k_val_up'),
                    remove = true,
                    dollars = card.ability.extra.dollars
                }
            end
        end
    },
    {
        key = 'j_corruption_life_drain',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_life_drain',
        pos = { x = 0, y = 0 },
        config = { extra = { mult_per_hand = 10, hands_lost = 1 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult_per_hand } }

        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands_lost
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands_lost
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local hands_left = G.GAME.current_round.hands_left
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { hands_left * card.ability.extra.mult_per_hand } },
                    mult_mod = hands_left * card.ability.extra.mult_per_hand,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_corruption_parasite',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_parasite',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 5 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local other_jokers = 0
                if G.jokers then
                    for k, v in pairs(G.jokers.cards) do
                        if v ~= card then other_jokers = other_jokers + 1 end
                    end
                end
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { other_jokers * card.ability.extra.mult } },
                    mult_mod = other_jokers * card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end,
        update = function(self, card, dt)
            if G.jokers then
                for k, v in pairs(G.jokers.cards) do
                    if v ~= card and not v.debuff then
                        v.debuff = true
                    end
                end
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            if G.jokers then
                for k, v in pairs(G.jokers.cards) do
                    if v ~= card then
                        v.debuff = false
                    end
                end
            end
        end
    },
    {
        key = 'j_corruption_decomposition',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_decomposition',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 0, gain = 5 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult, extra.gain } }

        end,
        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MULT,
                    remove = true
                }
            end
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_corruption_rust',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_rust',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 1.5, odds = 6 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.x_mult, G.GAME.probabilities.normal, extra.odds } }

        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card.ability.effect == 'Steel Card' then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end
            if context.after and not context.blueprint then
                for _, other_card in ipairs(context.scoring_hand) do
                    if other_card.ability.effect == 'Steel Card' then
                         if pseudorandom('rust') < G.GAME.probabilities.normal / card.ability.extra.odds then
                            if not other_card.ability.eternal then other_card:start_dissolve() end
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_shattered')})
                         end
                    end
                end
            end
        end
    },
    {
        key = 'j_corruption_noxious_spores',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_noxious_spores',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 20 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.m_odyssey_emerald
            return { vars = { card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.before and not context.blueprint then
                for k, v in ipairs(context.scoring_hand) do
                    v:set_ability(G.P_CENTERS.m_odyssey_emerald, nil, true)
                end
            end
        end
    },
    {
        key = 'j_corruption_contamination',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_contamination',
        pos = { x = 0, y = 0 },
        config = { extra = { chips = 10 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.chips } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
            if context.after and not context.blueprint then
                for k, v in ipairs(context.scoring_hand) do
                    v:change_suit('Spades')
                end
            end
        end
    },
    {
        key = 'j_corruption_necrosis',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_necrosis',
        pos = { x = 0, y = 0 },
        config = { extra = { face_pen = -10, num_bonus = 20 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.face_pen, extra.num_bonus } }

        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_face() then
                    return {
                        chips = card.ability.extra.face_pen,
                        card = card
                    }
                else
                    return {
                        chips = card.ability.extra.num_bonus,
                        card = card
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_plague',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_plague',
        pos = { x = 0, y = 0 },
        config = { extra = { odds = 3 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { G.GAME.probabilities.normal, extra.odds } }

        end,
        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                if pseudorandom('plague') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    return {
                        remove = true,
                        message = localize('k_destroyed')
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_rotten_hand',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_rotten_hand',
        pos = { x = 0, y = 0 },
        config = { extra = { dollars = 10 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                if G.GAME.last_hand_played == context.scoring_name then
                    ease_dollars(card.ability.extra.dollars)
                end
            end
            if context.joker_main then
                 if G.GAME.last_hand_played == context.scoring_name then
                     return {
                         message = localize('k_nope_ex'),
                         Xmult_mod = 0,
                         colour = G.C.RED
                     }
                 end
            end
        end
    },
    {
        key = 'j_corruption_dark_heart',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_dark_heart',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 15 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local has_hearts = false
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Hearts' then has_hearts = true break end
                end
                if not has_hearts then
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        mult_mod = card.ability.extra.mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_corrupted_mind',
        rarity = 1,
        cost = 4,
        atlas = 'j_corruption_corrupted_mind',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 25, hand_size = -1 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult, extra.hand_size } }

        end,
        add_to_deck = function(self, card, from_debuff)
            G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
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
