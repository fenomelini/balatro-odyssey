-- ============================================
-- PARADOX - Common (Jokers 321-336)
-- ============================================

-- 321. Menos é Mais (Less is More)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_less_is_more',
    atlas = 'j_paradox_less_is_more',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 20, max_cards = 3 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult, extra.max_cards } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand < card.ability.extra.max_cards then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 322. Fraco é Forte (Weak is Strong)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_weak_is_strong',
    atlas = 'j_paradox_weak_is_strong',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 10 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local rank = context.other_card:get_id()
            if rank >= 2 and rank <= 4 then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 323. Perder para Ganhar (Lose to Win)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_lose_to_win',
    atlas = 'j_paradox_lose_to_win',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { dollars = 3 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context)
        if context.after and G.GAME.chips < (G.GAME.blind.chips * 0.1) then
            ease_dollars(card.ability.extra.dollars)
            return {
                message = localize('$')..card.ability.extra.dollars,
                colour = G.C.MONEY,
                card = card
            }
        end
    end
})

-- 324. Descarte Útil (Useful Discard)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_useful_discard',
    atlas = 'j_paradox_useful_discard',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { current_chips = 0, chip_gain = 2 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chip_gain, extra.current_chips } }

    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card and not context.blueprint then
            card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chip_gain
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
                colour = G.C.CHIPS,
                card = card
            }
        end
        if context.joker_main and card.ability.extra.current_chips > 0 then
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
                chip_mod = card.ability.extra.current_chips,
                colour = G.C.CHIPS
            }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current_chips = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
    end
})

-- 325. Mão Torta (Crooked Hand)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_crooked_hand',
    atlas = 'j_paradox_crooked_hand',
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 10 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == 'Flush' or context.scoring_name == 'Straight' or context.scoring_name == 'Straight Flush' then
                return nil
            end
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 326. Flush Reverso (Reverse Flush)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_reverse_flush',
    atlas = 'j_paradox_reverse_flush',
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { extra = { x_mult = 2 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = { ['Spades'] = 0, ['Hearts'] = 0, ['Clubs'] = 0, ['Diamonds'] = 0 }
            local unique_suits = 0
            for _, v in ipairs(context.scoring_hand) do
                if suits[v.base.suit] == 0 then
                    suits[v.base.suit] = 1
                    unique_suits = unique_suits + 1
                end
            end
            
            if unique_suits >= 4 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    x_mult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 327. Par Ímpar (Odd Pair)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_odd_pair',
    atlas = 'j_paradox_odd_pair',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 15 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local is_odd_pair = false
            if context.poker_hands and context.poker_hands['Pair'] and #context.poker_hands['Pair'] > 0 then
                for _, p in ipairs(context.poker_hands['Pair']) do
                    local rank = p[1]:get_id()
                    if rank % 2 ~= 0 then
                        is_odd_pair = true
                    end
                end
            end
            
            if is_odd_pair then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 328. Full House Vazio (Empty Full House)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_empty_full_house',
    atlas = 'j_paradox_empty_full_house',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 12 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand == 5 and context.scoring_name ~= 'Full House' then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 329. High Low (High Low)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_high_low',
    atlas = 'j_paradox_high_low',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 15 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local has_2 = false
            local has_ace_or_king = false
            for _, v in ipairs(context.scoring_hand) do
                local id = v:get_id()
                if id == 2 then has_2 = true end
                if id == 13 or id == 14 then has_ace_or_king = true end
            end
            if has_2 and has_ace_or_king then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 330. Cego que Vê (Seeing Blind)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_seeing_blind',
    atlas = 'j_paradox_seeing_blind',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 15 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind.boss then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 331. Pobre Rico (Rich Poor)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_rich_poor',
    atlas = 'j_paradox_rich_poor',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { threshold = 10, per_dollar = 1 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.per_dollar, extra.threshold } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.dollars < card.ability.extra.threshold then
            local diff = card.ability.extra.threshold - math.max(0, G.GAME.dollars)
            local bonus = diff * card.ability.extra.per_dollar
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { bonus } },
                mult_mod = bonus,
                colour = G.C.MULT
            }
        end
    end
})

-- 332. Lento Rápido (Slow Fast)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_slow_fast',
    atlas = 'j_paradox_slow_fast',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 10 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 333. Joker Pacifista (Pacifist Joker)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_pacifist_joker',
    atlas = 'j_paradox_pacifist_joker',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { x_mult = 1.2, active = false } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.active then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                x_mult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        if context.after and not context.blueprint then
            if G.GAME.chips < G.GAME.blind.chips then
                card.ability.extra.active = true
            else
                card.ability.extra.active = false
            end
        end
    end
})

-- 334. Paradoxo do Mentiroso (Liar's Paradox)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_liars_paradox',
    atlas = 'j_paradox_liars_paradox',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 20 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 335. Inversão de Valor (Value Inversion)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_value_inversion',
    atlas = 'j_paradox_value_inversion',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { chip_mod = -10, ace_bonus = 20 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chip_mod, extra.ace_bonus } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
               return {
                   chips = card.ability.extra.chip_mod,
                   card = card
               }
            elseif context.other_card:get_id() == 14 then
                return {
                    chips = card.ability.extra.ace_bonus,
                    card = card
                }
            end
        end
    end
})

-- 336. Silêncio Ruidoso (Loud Silence)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_paradox_loud_silence',
    atlas = 'j_paradox_loud_silence',
    rarity = 1,
    cost = 4,
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 30 } },
    blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local face = false
            for _, v in ipairs(context.scoring_hand) do
                if v:is_face() then face = true end
            end
            
            if not face then
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
})