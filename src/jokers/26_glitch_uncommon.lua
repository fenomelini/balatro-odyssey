local local_jokers = {
    {
        key = 'j_glitch_exploit',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_exploit',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main and context.scoring_hand then
                local debuffed_found = false
                for _, other_card in ipairs(context.scoring_hand) do
                    if other_card.debuff then
                        debuffed_found = true
                        break
                    end
                end
                
                if debuffed_found then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_debug_mode',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_debug_mode',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 10 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_glitch_god_mode',
        rarity = 2,
        cost = 8,
        atlas = 'j_glitch_god_mode',
        pos = { x = 0, y = 0 },
        config = {},
        blueprint_compat = false,
        calculate = function(self, card, context)
            if context.game_over and (not context.repetition) and not context.blueprint then
                if G.GAME.chips / G.GAME.blind.chips < 1 then
                    return {
                        message = localize('k_saved_ex'),
                        saved = true,
                        colour = G.C.RED,
                        func = function() 
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                        func = function()
                                            G.jokers:remove_card(card)
                                            card:remove()
                                            card = nil
                                            return true; 
                                        end
                                    })) 
                                    return true
                                end
                            }))
                        end
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_noclip',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_noclip',
        pos = { x = 0, y = 0 },
        blueprint_compat = false,
        config = {},
    },
    {
        key = 'j_glitch_speedrun',
        rarity = 2,
        cost = 5,
        atlas = 'j_glitch_speedrun',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 50 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main and G.GAME.current_round.hands_played == 0 then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_glitch_softlock',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_softlock',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 3 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if G.GAME.current_round.discards_left == 0 and G.GAME.dollars <= 0 then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_duplication_glitch',
        rarity = 2,
        cost = 7,
        atlas = 'j_glitch_duplication_glitch',
        pos = { x = 0, y = 0 },
        config = { extra = { odds = 5 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { G.GAME.probabilities.normal, extra.odds } }

        end,
        calculate = function(self, card, context)
            if context.cardarea == G.jokers and context.before and not context.blueprint then
                if context.scoring_hand then
                    local triggered = false
                    for i = 1, #context.scoring_hand do
                        if pseudorandom('duplication_glitch') < G.GAME.probabilities.normal / card.ability.extra.odds then
                            triggered = true
                            local shop_card = context.scoring_hand[i]
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local _card = copy_card(shop_card, nil, nil, G.playing_card, nil)
                                    _card:add_to_deck()
                                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                                    table.insert(G.playing_cards, _card)
                                    G.hand:emplace(_card)
                                    _card:start_materialize()
                                    return true
                                end
                            }))
                        end
                    end
                    if triggered then
                        return {
                            message = localize('k_copied_ex'),
                            colour = G.C.CHIPS,
                            card = card
                        }
                    end
                end
            end
        end
    },
    {
        key = 'j_glitch_source_code',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_source_code',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 20 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.m_odyssey_emerald
            return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult } }
        end,
        calculate = function(self, card, context)
            if context.setting_blind and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('Default', G.hand, nil, nil, nil, nil, 'm_odyssey_emerald', 'odyssey_source_code')
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = localize('k_active_ex'),
                    colour = G.C.FILTER
                }
            end
            
            if context.joker_main then
                local stone_found = false
                if G.hand and G.hand.cards then
                    for _, c in ipairs(G.hand.cards) do
                        if c.config.center == G.P_CENTERS.m_odyssey_emerald then
                            stone_found = true
                            break
                        end
                    end
                end
                
                if stone_found then
                    return {
                        message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                        mult_mod = card.ability.extra.mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_hacker',
        rarity = 2,
        cost = 7,
        atlas = 'j_glitch_hacker',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 1.5 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
            
            if context.before and context.scoring_name then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex')})
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=context.scoring_name,level=G.GAME.hands[context.scoring_name].level})
                level_up_hand(context.blueprint_card or card, context.scoring_name, true, 1)        
            end

            if context.after and context.scoring_name and not context.blueprint then
                level_up_hand(card, context.scoring_name, true, -1)
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=context.scoring_name,level=G.GAME.hands[context.scoring_name].level})
            end 
        end
    },
    {
        key = 'j_glitch_firewall',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_firewall',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main and G.GAME.blind.boss then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_glitch_virus',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_virus',
        pos = { x = 0, y = 0 },
        config = {},
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                if context.scoring_hand and #context.scoring_hand > 0 and G.hand.cards and #G.hand.cards > 0 then
                    local target_suit = context.scoring_hand[1].base.suit
                    local random_card = pseudorandom_element(G.hand.cards, pseudorandom('virus'))
                    
                    random_card:change_suit(target_suit)
                    card:juice_up()
                    
                    return {
                        message = localize('k_active_ex'),
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_trojan',
        rarity = 2,
        cost = 6,
        atlas = 'j_glitch_trojan',
        pos = { x = 0, y = 0 },
        config = { extra = { mult = 4,  x_mult = 3, rounds_remaining = 3 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.mult, 3, extra.x_mult, extra.rounds_remaining } }

        end,
        calculate = function(self, card, context)
            if context.end_of_round and not context.repetition and not context.other_card then
                if card.ability.extra.rounds_remaining > 0 then
                    card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining - 1
                    return {
                        message = card.ability.extra.rounds_remaining .. '',
                        colour = G.C.FILTER
                    }
                else
                    return {
                        message = localize('k_active_ex'),
                        colour = G.C.FILTER
                    }
                end
            end
            
            if context.joker_main then
                if card.ability.extra.rounds_remaining > 0 then
                    return {
                        message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                        mult_mod = card.ability.extra.mult,
                        colour = G.C.MULT
                    }
                else
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    {
        key = 'j_glitch_phishing',
        rarity = 2,
        cost = 5,
        atlas = 'j_glitch_phishing',
        pos = { x = 0, y = 0 },
        config = { extra = { odds = 3, dollars = 1 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { G.GAME.probabilities.normal, extra.odds, extra.dollars } }

        end,
        calculate = function(self, card, context)
            if context.discard and not context.blueprint then
                if context.other_card and context.other_card:is_face() then
                     if pseudorandom('phishing') < G.GAME.probabilities.normal / card.ability.extra.odds then
                        ease_dollars(card.ability.extra.dollars)
                        return {
                            message = localize('$')..card.ability.extra.dollars,
                            colour = G.C.MONEY,
                            card = card
                        }
                     end
                end
            end
        end
    },
    {
        key = 'j_glitch_zero_day',
        rarity = 2,
        cost = 5,
        atlas = 'j_glitch_zero_day',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2.5 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                -- first hand of FIRST ante
                if G.GAME.round_resets.ante == 1 and G.GAME.current_round.hands_played == 0 then
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                        Xmult_mod = card.ability.extra.x_mult,
                        colour = G.C.MULT
                    } 
                end
            end
        end
    }
}

for _, joker in ipairs(local_jokers) do
    joker.unlocked = true
    joker.discovered = false
    SMODS.Joker(joker)
end
