local jokers = {
    -- 361. Spade Anomaly
    {
        key = 'j_anomaly_spade_anomaly',
        config = { extra = { mult = 10 } },
        rarity = 1,
        atlas = 'j_anomaly_spade_anomaly',
        cost = 5,
        blueprint_compat = true,
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
        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_spade_heart = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_spade_heart = nil
        end
    },
    -- 362. Heart Anomaly
    {
        key = 'j_anomaly_heart_anomaly',
        config = { extra = { mult = 10 } },
        rarity = 1,
        atlas = 'j_anomaly_heart_anomaly',
        cost = 5,
        blueprint_compat = true,
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
        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_heart_club = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_heart_club = nil
        end
    },
    -- 363. Club Anomaly
    {
        key = 'j_anomaly_club_anomaly',
        config = { extra = { mult = 10 } },
        rarity = 1,
        atlas = 'j_anomaly_club_anomaly',
        cost = 5,
        blueprint_compat = true,
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
        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_club_diamond = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_club_diamond = nil
        end
    },
    -- 364. Diamond Anomaly
    {
        key = 'j_anomaly_diamond_anomaly',
        config = { extra = { mult = 10 } },
        rarity = 1,
        atlas = 'j_anomaly_diamond_anomaly',
        cost = 5,
        blueprint_compat = true,
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
        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_diamond_spade = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_diamond_spade = nil
        end
    },
    -- 365. Rank Shift (Ases = 2s, 2s = Ases)
    {
        key = 'j_anomaly_rank_shift',
        config = { },
        rarity = 1,
        atlas = 'j_anomaly_rank_shift',
        cost = 4,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_rank_shift = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_rank_shift = nil
        end
    },
    -- 366. Numeric Inversion (Evens = Mult, Odds = Chips)
    {
        key = 'j_anomaly_numeric_inversion',
        config = { extra = { mult = 4, chips = 20 } },
        rarity = 1,
        atlas = 'j_anomaly_numeric_inversion',
        cost = 4,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult, extra.chips } }

        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() % 2 == 0 then
                    -- Even
                    return {
                        mult = card.ability.extra.mult,
                        card = card
                    }
                elseif context.other_card:get_id() % 2 ~= 0 then
                    -- Odd (includes Ace=14, Jack=11, King=13. Queen=12 is even)
                    return {
                        chips = card.ability.extra.chips,
                        card = card
                    }
                end
            end
        end
    },
    -- 367. Chromatic Anomaly
    {
        key = 'j_anomaly_chromatic_anomaly',
        config = { },
        rarity = 1,
        atlas = 'j_anomaly_chromatic_anomaly',
        cost = 6,
        add_to_deck = function(self, card, from_debuff)
            if not G.GAME.modifiers.odyssey_chromatic_rate then G.GAME.modifiers.odyssey_chromatic_rate = 1 end
            G.GAME.modifiers.odyssey_chromatic_rate = G.GAME.modifiers.odyssey_chromatic_rate + 2
        end,
        remove_from_deck = function(self, card, from_debuff)
            if G.GAME.modifiers.odyssey_chromatic_rate then
                G.GAME.modifiers.odyssey_chromatic_rate = G.GAME.modifiers.odyssey_chromatic_rate - 2
            end
        end
    },
    -- 368. Material Anomaly (Stone = Gold)
    {
        key = 'j_anomaly_material_anomaly',
        config = { extra = { money = 3 } },
        rarity = 1,
        atlas = 'j_anomaly_material_anomaly',
        cost = 5,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.money } }

        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card.config.center == G.P_CENTERS.m_odyssey_emerald then
                    return {
                        dollars = card.ability.extra.money,
                        card = card
                    }
                end
            end
            -- Also Held
             if context.individual and context.end_of_round and context.cardarea == G.hand then
                 if context.other_card.config.center == G.P_CENTERS.m_odyssey_emerald then
                     return {
                         dollars = card.ability.extra.money,
                         card = card
                     }
                 end
             end
        end
    },
    -- 369. Anomalous Echo
    {
        key = 'j_anomaly_anomalous_echo',
        config = { },
        rarity = 1,
        atlas = 'j_anomaly_anomalous_echo',
        cost = 5,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play then
                local scoring = context.scoring_hand
                if scoring and #scoring > 1 and context.other_card == scoring[#scoring] then
                    local first = scoring[1]
                    if not context.other_card:is_suit(first.base.suit) then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = 1,
                            card = card
                        }
                    end
                end
            end
        end
    },
    -- 370. Phantom
    {
        key = 'j_anomaly_phantom',
        config = { extra = { mult = 20 } },
        rarity = 1,
        atlas = 'j_anomaly_phantom',
        cost = 6,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult } }

        end,
        add_to_deck = function(self, card, from_debuff)
            if not from_debuff then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            if not from_debuff then
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            end
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    },
    -- 371. Instability
    {
        key = 'j_anomaly_instability',
        config = { extra = { mult = 15, current_suit = 'Spades' } },
        rarity = 1,
        atlas = 'j_anomaly_instability',
        cost = 5,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult, localize(extra.current_suit, 'suits_singular') } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local has_suit = false
                for _, playing_card in ipairs(context.scoring_hand) do
                    if playing_card:is_suit(card.ability.extra.current_suit) then
                        has_suit = true
                        break
                    end
                end
                
                if has_suit then
                    return {
                        mult_mod = card.ability.extra.mult,
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                    }
                end
            end
            if context.end_of_round and not context.repetition and not context.other_card then
                local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
                card.ability.extra.current_suit = suits[pseudorandom('instability') % 4 + 1]
                return {
                    message = localize(card.ability.extra.current_suit, 'suits_singular'),
                    colour = G.C.ORANGE
                }
            end
        end
    },
    -- 372. Distortion
    {
        key = 'j_anomaly_distortion',
        config = { extra = { chips = 50 } },
        rarity = 1,
        atlas = 'j_anomaly_distortion',
        cost = 5,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.chips } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
        end
    },
    -- 373. Interference
    {
        key = 'j_anomaly_interference',
        config = { extra = { mult = 10, bonus = 20 } },
        rarity = 1,
        atlas = 'j_anomaly_interference',
        cost = 5,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.mult, extra.bonus } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local bonus = card.ability.extra.mult
                local has_another = false
                for k, v in pairs(G.jokers.cards) do
                    if v ~= card and v.config.center.key and string.find(v.config.center.key, 'anomaly') then
                        has_another = true
                        break 
                    end
                end
                if has_another then
                    bonus = bonus + card.ability.extra.bonus
                end
                return {
                    mult_mod = bonus,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { bonus } }
                }
            end
        end
    },
    -- 374. Static Noise
    {
        key = 'j_anomaly_static_noise',
        config = { extra = { money = 5, odds = 4 } },
        rarity = 1,
        atlas = 'j_anomaly_static_noise',
        cost = 4,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.money, (G.GAME and G.GAME.probabilities.normal or 1), extra.odds } }

        end,
        calculate = function(self, card, context)
            if context.end_of_round and not context.repetition and not context.other_card then
                if pseudorandom('static_noise') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    return {
                        dollars = card.ability.extra.money,
                        message = localize('$')..card.ability.extra.money,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    },
    -- 375. Lost Signal
    {
        key = 'j_anomaly_lost_signal',
        config = { extra = { hands = 1 } },
        rarity = 1,
        atlas = 'j_anomaly_lost_signal',
        cost = 6,
        blueprint_compat = false,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.hands } }

        end,
        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                if #context.full_hand == 5 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_hands_played(card.ability.extra.hands)
                            return true
                        end
                    }))
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.BLUE
                    }
                end
            end
        end
    },
    -- 376. Audio Glitch
    {
        key = 'j_anomaly_audio_glitch',
        config = { extra = { chips = 30 } },
        rarity = 1,
        atlas = 'j_anomaly_audio_glitch',
        cost = 4,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = card and card.ability.extra or self.config.extra

            return { vars = { extra.chips } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
        end
    }
}

for _, joker_def in ipairs(jokers) do
    joker_def.unlocked = true
    joker_def.discovered = true
    SMODS.Joker(joker_def)
end
