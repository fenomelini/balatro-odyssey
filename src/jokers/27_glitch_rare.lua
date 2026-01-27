local local_jokers = {
    {
        key = 'j_glitch_game_breaker',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_game_breaker',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = false,
        add_to_deck = function(self, card, from_debuff)
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            G.hand.config.card_limit = G.hand.config.card_limit - 2
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            G.hand.config.card_limit = G.hand.config.card_limit + 2
        end
    },
    {
        key = 'j_glitch_kill_screen',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_kill_screen',
        pos = { x = 0, y = 0 },
        config = { extra = { threshold = 1000000, money = 20 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.money, extra.threshold } }

        end,
        calculate = function(self, card, context)
            if context.end_of_round and not context.repetition and not context.other_card then
                if G.GAME.blind.chips >= card.ability.extra.threshold then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = localize('$')..card.ability.extra.money,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_matrix_glitch',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_matrix_glitch',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.repetition then
                if context.cardarea == G.play then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = context.other_card
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_overwrite',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_overwrite',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = false,
        calculate = function(self, card, context)
            if context.selling_card and context.card.edition and context.card ~= card then
                card:set_edition(context.card.edition, true)
                return {
                    message = 'Overwritten!',
                    colour = G.C.RED
                }
            end
        end
    },
    {
        key = 'j_glitch_hex_editor',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_hex_editor',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                if context.other_card then
                    local new_rank = pseudorandom_element({'2','3','4','5','6','7','8','9','10','J','Q','K','A'}, pseudorandom('hex_editor_rank'))
                    local new_suit = pseudorandom_element({'Spades','Hearts','Clubs','Diamonds'}, pseudorandom('hex_editor_suit'))
                    context.other_card:set_base(G.P_CARDS[new_suit..'_'..new_rank])
                    return {
                        message = 'Edited!',
                        colour = G.C.PURPLE,
                        card = card
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_corruption',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_corruption',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 1.5, odds = 10 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, G.GAME.probabilities.normal, extra.odds } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local mult = 1
                for k, v in ipairs(G.jokers.cards) do
                    if v ~= card then
                        mult = mult * card.ability.extra.x_mult
                    end
                end
                if mult > 1 then
                    return {
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { mult } },
                        Xmult_mod = mult,
                        colour = G.C.MULT
                    }
                end
            end
            if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
                for k, v in ipairs(G.jokers.cards) do
                    if v ~= card and pseudorandom('corruption') < G.GAME.probabilities.normal / card.ability.extra.odds then
                        v:start_dissolve()
                    end
                end
            end
        end
    },
    {
        key = 'j_glitch_segfault',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_segfault',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 5 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if context.full_hand and #context.full_hand > 5 then
                    return {
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_root_access',
        rarity = 3,
        cost = 8,
        atlas = 'j_glitch_root_access',
        pos = { x = 0, y = 0 },
        config = { extra = { bonus_slots = 3 } },
        blueprint_compat = false,
        add_to_deck = function(self, card, from_debuff)
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.bonus_slots
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.bonus_slots
        end
    }
}

for _, joker in ipairs(local_jokers) do
    joker.unlocked = true
    joker.discovered = true
    SMODS.Joker(joker)
end