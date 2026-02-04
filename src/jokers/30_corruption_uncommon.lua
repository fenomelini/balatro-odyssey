local local_jokers = {
    {
        key = 'j_corruption_cannibalism',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_cannibalism',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 3, active = false } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.setting_blind and not context.blueprint then
                local destroyable_jokers = {}
                if G.jokers then
                    for k, v in pairs(G.jokers.cards) do
                        if v ~= card and not v.ability.eternal then
                            table.insert(destroyable_jokers, v)
                        end
                    end
                end
                
                if #destroyable_jokers > 0 then
                    local joker_to_destroy = pseudorandom_element(destroyable_jokers, pseudorandom('cannibalism'))
                    joker_to_destroy:start_dissolve(nil, true)
                    card.ability.extra.active = true
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex')})
                else
                    card.ability.extra.active = false
                end
            end
            if context.joker_main and card.ability.extra.active then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
            if context.end_of_round and not context.repetition and not context.other_card then
                card.ability.extra.active = false
            end
        end
    },
    {
        key = 'j_corruption_vampirism',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_vampirism',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 0, gain = 2 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.mult, extra.gain } }

        end,
        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                for k, v in ipairs(context.scoring_hand) do
                    if v.config.center ~= G.P_CENTERS.c_base then
                        v:set_ability(G.P_CENTERS.c_base, nil, true)
                        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                    end
                end
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
        key = 'j_corruption_necromancy',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_necromancy',
        pos = { x = 0, y = 0 },
        config = { extra = { triggered_this_round = false } },
        blueprint_compat = false,
        eternal_compat = true,
        calculate = function(self, card, context)
            if context.destroying_card and not context.blueprint then
                    if not card.ability.extra.triggered_this_round then
                        local destroyed_card = context.destroying_card
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                G.playing_card = (G.playing_card or 0) + 1
                                local _card = copy_card(destroyed_card, nil, nil, G.playing_card)
                                _card:add_to_deck()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                table.insert(G.playing_cards, _card)
                                G.hand:emplace(_card)
                                return true
                            end
                        }))
                        card.ability.extra.triggered_this_round = true
                        return {
                            message = localize('k_saved'),
                            colour = G.C.GREEN
                        }
                    end
            end
            if context.end_of_round and not context.repetition and not context.other_card then
                card.ability.extra.triggered_this_round = false
            end
        end
    },
    {
        key = 'j_corruption_offering',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_offering',
        pos = { x = 0, y = 0 },
        config = { extra = { dollars = 50 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                if #context.full_hand == 5 then
                    local suits = {}
                    local ranks = {}
                    for _, c in ipairs(context.full_hand) do
                        suits[c.base.suit] = (suits[c.base.suit] or 0) + 1
                        ranks[c.base.id] = (ranks[c.base.id] or 0) + 1
                    end
                    local is_flush = false
                    for s, count in pairs(suits) do
                        if count == 5 then is_flush = true break end
                    end
                    local is_royal = ranks[10] and ranks[11] and ranks[12] and ranks[13] and ranks[14]
                    
                    if is_flush and is_royal then
                        ease_dollars(card.ability.extra.dollars)
                        return {
                            message = localize('k_val_up'),
                            colour = G.C.MONEY
                        }
                    end
                end
            end
        end
    },
    {
        key = 'j_corruption_curse_of_gold',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_curse_of_gold',
        pos = { x = 0, y = 0 },
        config = { extra = { dollars = 1 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                ease_dollars(card.ability.extra.dollars)
                context.other_card.ability.perma_bonus = 0 
                return {
                    chips = -context.other_card.base.nominal, 
                    card = card
                }
            end
        end
    },
    {
        key = 'j_corruption_void_whispers',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_void_whispers',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2.5, threshold = 20 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, extra.threshold } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if #G.playing_cards < card.ability.extra.threshold then
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
        key = 'j_corruption_mark_of_the_beast',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_mark_of_the_beast',
        pos = { x = 0, y = 0 },
        config = { extra = { chips = 666, hands_mod = 0 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.chips } }

        end,
        add_to_deck = function(self, card, from_debuff)
            card.ability.extra.hands_mod = G.GAME.round_resets.hands - 1
            G.GAME.round_resets.hands = 1
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + (card.ability.extra.hands_mod or 0)
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
        key = 'j_corruption_soul_corruption',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_soul_corruption',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = false,
        eternal_compat = true,
        update = function(self, card, dt)
            if G.consumeables then
                for k, v in pairs(G.consumeables.cards) do
                    if v.config.center.set == 'Tarot' then
                        local spectral = pseudorandom_element(G.P_CENTER_POOLS.Spectral, pseudorandom('soul_corruption'))
                        v:set_ability(spectral)
                        v:set_edition(nil, true)
                    end
                end
            end
        end
    },
    {
        key = 'j_corruption_decadence',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_decadence',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 4, loss = 1 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, extra.loss } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local current_ante = G.GAME.round_resets.ante
                local mult = math.max(1, card.ability.extra.x_mult - (current_ante - 1) * card.ability.extra.loss)
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { mult } },
                    Xmult_mod = mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_corruption_toxin',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_toxin',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 50 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

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
                for k, v in ipairs(context.scoring_hand) do
                    v.ability.perma_debuff = true
                    v:set_debuff(true)
                end
            end
        end
    },
    {
        key = 'j_corruption_mutation',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_mutation',
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
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
            if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
                local random_card = pseudorandom_element(G.playing_cards, pseudorandom('mutation'))
                local new_rank = pseudorandom_element({'2','3','4','5','6','7','8','9','10','J','Q','K','A'}, pseudorandom('mutation_rank'))
                local new_suit = pseudorandom_element({'Spades','Hearts','Clubs','Diamonds'}, pseudorandom('mutation_suit'))
                
                assert(SMODS.change_base(random_card, new_suit, new_rank))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.PURPLE})
            end
        end
    },
    {
        key = 'j_corruption_scar',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_scar',
        pos = { x = 0, y = 0 },
        config = { extra = { chips = 0 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.chips } }

        end,
        calculate = function(self, card, context)
            if context.destroying_card and not context.blueprint then
                card.ability.extra.chips = (card.ability.extra.chips or 0) + 10
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
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
        key = 'j_corruption_slow_poison',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_slow_poison',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 3, limit = 3 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, extra.limit } }

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
                if G.GAME.current_round.hands_played >= card.ability.extra.limit and G.GAME.chips < G.GAME.blind.chips then
                    G.STATE = G.STATES.GAME_OVER
                    G.STATE_COMPLETE = false
                    return {
                        message = localize('k_game_over'),
                        colour = G.C.RED
                    }
                end
            end
        end
    },
    {
        key = 'j_corruption_grim_harvest',
        rarity = 2,
        cost = 6,
        atlas = 'j_corruption_grim_harvest',
        pos = { x = 0, y = 0 },
        config = { extra = { dollars = 0 } },
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.destroying_card and not context.blueprint then
                card.ability.extra.dollars = card.ability.extra.dollars + 1
            end
            if context.end_of_round and not context.repetition and not context.other_card then
                local gain = card.ability.extra.dollars
                card.ability.extra.dollars = 0
                ease_dollars(gain)
                return {
                    message = localize{ type = 'variable', key = 'a_dollars', vars = { gain } },
                    colour = G.C.MONEY
                }
            end
        end
    }
}

for _, joker in ipairs(local_jokers) do
    joker.unlocked = true
    joker.discovered = false
    SMODS.Joker(joker)
end