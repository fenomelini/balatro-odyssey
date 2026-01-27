local jokers = {
    -- 391. The Monolith
    {
        key = 'j_anomaly_the_monolith',
        config = { extra = { x_mult = 4 } },
        rarity = 3,
        atlas = 'j_anomaly_the_monolith',
        cost = 8,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = false,
        add_to_deck = function(self, card, from_debuff)
            if not from_debuff then
                card.ability.eternal = true
            end
        end,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end
    },
    -- 392. Primordial Anomaly
    {
        key = 'j_anomaly_primordial_anomaly',
        config = { },
        rarity = 3,
        atlas = 'j_anomaly_primordial_anomaly',
        cost = 8,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
                if G.GAME.blind.boss and G.GAME.current_round.discards_used == 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_soul', 'primordial')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            return true
                        end
                    }))
                    return {
                        message = localize('k_soul_ex'),
                        colour = G.C.PURPLE
                    }
                end
            end
        end
    },
    -- 393. Reality Rift
    {
        key = 'j_anomaly_reality_rift',
        config = { extra = { consumable = 1, joker = 1 } },
        rarity = 3,
        atlas = 'j_anomaly_reality_rift',
        cost = 8,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.consumable, extra.joker } }

        end,
        add_to_deck = function(self, card, from_debuff)
            if not from_debuff then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            if not from_debuff then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker
            end
        end
    },
    -- 394. Mirror Universe
    {
        key = 'j_anomaly_mirror_universe',
        config = { },
        rarity = 3,
        atlas = 'j_anomaly_mirror_universe',
        cost = 8,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_mirror_universe = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_mirror_universe = nil
        end
    },
    -- 395. Strange Matter
    {
        key = 'j_anomaly_strange_matter',
        config = { },
        rarity = 3,
        atlas = 'j_anomaly_strange_matter',
        cost = 8,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                 for _, c in ipairs(context.scoring_hand) do
                    c:set_ability(G.P_CENTERS.m_odyssey_plastic)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            c:juice_up()
                            return true
                        end
                    }))
                 end
                 return {
                    message = localize('k_gold'),
                    colour = G.C.MONEY
                 }
            end
        end
    },
    -- 396. Phantom Energy
    {
        key = 'j_anomaly_phantom_energy',
        config = { extra = { consumable = 1, joker = 1, hand = 2 } },
        rarity = 3,
        atlas = 'j_anomaly_phantom_energy',
        cost = 8,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.consumable, extra.joker, extra.hand } }

        end,
        add_to_deck = function(self, card, from_debuff)
            if not from_debuff then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker
                G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            if not from_debuff then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker
                G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand
            end
        end
    },
    -- 397. Function Collapse
    {
        key = 'j_anomaly_function_collapse',
        config = { extra = { x_mult = 3 } },
        rarity = 3,
        atlas = 'j_anomaly_function_collapse',
        cost = 8,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                 return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_faceless_suits = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_faceless_suits = nil
        end
    },
    -- 398. Parity Error
    {
        key = 'j_anomaly_parity_error',
        config = { extra = { money = 20 } },
        rarity = 3,
        atlas = 'j_anomaly_parity_error',
        cost = 8,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

            return { vars = { extra.money } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if #context.scoring_hand == 5 then
                    local odds = 0
                    local evens = 0
                    for _, c in ipairs(context.scoring_hand) do
                        if c:get_id() % 2 == 0 then evens = evens + 1 else odds = odds + 1 end
                    end
                    
                    if evens == 5 or odds == 5 then
                        return {
                            dollars = card.ability.extra.money,
                            message = localize('$')..card.ability.extra.money,
                            colour = G.C.MONEY
                        }
                    end
                end
            end
        end
    }
}

for _, joker_def in ipairs(jokers) do
    joker_def.unlocked = true
    joker_def.discovered = true
    SMODS.Joker(joker_def)
end
