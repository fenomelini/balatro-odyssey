local jokers = {
    -- 377. Gravitational Anomaly
    {
        key = 'j_anomaly_gravitational_anomaly',
        config = { extra = { mult = 20 } },
        rarity = 2,
        atlas = 'j_anomaly_gravitational_anomaly',
        cost = 6,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local low_ranks = true
                for _, playing_card in ipairs(context.scoring_hand) do
                    if playing_card:get_id() > 5 then
                        low_ranks = false
                        break
                    end
                end
                
                if low_ranks then
                    return {
                        message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        mult_mod = card.ability.extra.mult,
                        colour = G.C.MULT
                    }
                end
            end
        end
    },
    -- 378. Temporal Anomaly
    {
        key = 'j_anomaly_temporal_anomaly',
        config = { },
        rarity = 2,
        atlas = 'j_anomaly_temporal_anomaly',
        cost = 8,
        blueprint_compat = false,
        calculate = function(self, card, context)
            if context.selling_self then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('timpani')
                        G.GAME.blind:defeat()
                        return true
                    end
                })) 
            end
        end
    },
    -- 379. Spatial Anomaly
    {
        key = 'j_anomaly_spatial_anomaly',
        config = { extra = { hand_size = 2, joker_slot = 1 } },
        rarity = 2,
        atlas = 'j_anomaly_spatial_anomaly',
        cost = 6,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.hand_size, extra.joker_slot } }

        end,
        add_to_deck = function(self, card, from_debuff)
            G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.hand_size
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slot
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.hand_size
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slot
        end
    },
    -- 380. Unstable Wormhole
    {
        key = 'j_anomaly_unstable_wormhole',
        config = { extra = { x_mult = 2, odds = 10 } },
        rarity = 2,
        atlas = 'j_anomaly_unstable_wormhole',
        cost = 6,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, (G.GAME and G.GAME.probabilities.normal or 1), extra.odds } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if not context.blueprint and not context.retrigger_joker then
                    if pseudorandom('wormhole') < G.GAME.probabilities.normal / card.ability.extra.odds then
                        local neighbors = {}
                        local my_pos = -1
                        for i, j in ipairs(G.jokers.cards) do
                            if j == card then my_pos = i; break end
                        end
                        if my_pos > 1 then table.insert(neighbors, G.jokers.cards[my_pos-1]) end
                        if my_pos < #G.jokers.cards then table.insert(neighbors, G.jokers.cards[my_pos+1]) end
                        
                        if #neighbors > 0 then
                            local target = neighbors[pseudorandom('wormhole_target') % #neighbors + 1]
                            if not target.ability.eternal then
                                target.getting_sliced = true
                                G.E_MANAGER:add_event(Event({func = function()
                                    target:start_dissolve()
                                return true end }))
                                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_eaten_ex')})
                            end
                        end
                    end
                end
                
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end
    },
    -- 381. Augmented Reality
    {
        key = 'j_anomaly_augmented_reality',
        config = { },
        rarity = 2,
        atlas = 'j_anomaly_augmented_reality',
        cost = 6,
        eternal_compat = true,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_glass_safe = true
        end,
        remove_from_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_glass_safe = nil
        end
    },
    -- 382. Simulation
    {
        key = 'j_anomaly_simulation',
        config = { extra = { x_mult = 4 } },
        rarity = 2,
        atlas = 'j_anomaly_simulation',
        cost = 7,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if G.GAME.current_round.odyssey_last_hand_ranks then
                    local current_ranks = ''
                    for _, c in ipairs(context.scoring_hand) do current_ranks = current_ranks .. c.base.id .. ',' end
                    
                    if current_ranks == G.GAME.current_round.odyssey_last_hand_ranks then
                        return {
                            message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                            Xmult_mod = card.ability.extra.x_mult
                        }
                    end
                end
            end
            if context.after and not context.blueprint then
                local current_ranks = ''
                for _, c in ipairs(context.scoring_hand) do current_ranks = current_ranks .. c.base.id .. ',' end
                G.GAME.current_round.odyssey_last_hand_ranks = current_ranks
            end
        end
    },
    -- 383. Broken Code
    {
        key = 'j_anomaly_broken_code',
        config = { extra = { chips = 100 } },
        rarity = 2,
        atlas = 'j_anomaly_broken_code',
        cost = 5,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

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
    -- 384. Hidden Variable
    {
        key = 'j_anomaly_hidden_variable',
        config = { extra = { x_mult = 0.5 } },
        rarity = 2,
        atlas = 'j_anomaly_hidden_variable',
        cost = 6,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local count = 0
                for _, v in pairs(G.jokers.cards) do
                    if v.config.center.key and string.find(v.config.center.key, 'anomaly') then
                        count = count + 1
                    end
                end
                
                local total_xmult = 1 + (count * card.ability.extra.x_mult)
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { total_xmult } },
                    Xmult_mod = total_xmult
                }
            end
        end
    },
    -- 385. Unhandled Exception
    {
        key = 'j_anomaly_unhandled_exception',
        config = { extra = { money = 10 } },
        rarity = 2,
        atlas = 'j_anomaly_unhandled_exception',
        cost = 5,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.money } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if G.GAME.current_round.discards_left <= 0 then
                     return {
                        dollars = card.ability.extra.money,
                        message = localize('$')..card.ability.extra.money,
                        colour = G.C.MONEY
                     }
                end
            end
        end
    },
    -- 386. Buffer Overflow
    {
        key = 'j_anomaly_buffer_overflow',
        config = { },
        rarity = 2,
        atlas = 'j_anomaly_buffer_overflow',
        cost = 6,
        blueprint_compat = true,
        calculate = function(self, card, context)
            if context.repetition and context.cardarea == G.play then
                if #G.play.cards == 5 then
                    local middle_card = G.play.cards[3]
                    if context.other_card == middle_card then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = 2,
                            card = card
                        }
                    end
                end
            end
        end
    },
    -- 387. Memory Dump
    {
        key = 'j_anomaly_memory_dump',
        config = { },
        rarity = 2,
        atlas = 'j_anomaly_memory_dump',
        cost = 4,
        calculate = function(self, card, context)
            if context.selling_self then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i=1, 3 do
                            local _card = create_card('Default', G.pack_cards, nil, nil, true, true, nil, 'memdump')
                            _card:add_to_deck()
                            G.hand:emplace(_card)
                        end
                        return true
                    end
                }))
            end
        end
    },
    -- 388. Race Condition
    {
        key = 'j_anomaly_race_condition',
        config = { extra = { mult = 50, seconds = 5 } },
        rarity = 2,
        atlas = 'j_anomaly_race_condition',
        cost = 6,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.mult, extra.seconds } }

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
    },
    -- 389. Deadlock
    {
        key = 'j_anomaly_deadlock',
        config = { extra = { x_mult = 3 } },
        rarity = 2,
        atlas = 'j_anomaly_deadlock',
        cost = 6,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                if G.GAME.current_round.discards_left == 0 and G.GAME.current_round.hands_left == 0 then
                    return {
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                        Xmult_mod = card.ability.extra.x_mult
                    }
                end
            end
        end
    },
    -- 390. Heisenbug
    {
        key = 'j_anomaly_heisenbug',
        config = { extra = { mult = 15, chips = 100, dollars = 5, mode = 1 } },
        rarity = 2,
        atlas = 'j_anomaly_heisenbug',
        cost = 5,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            local modes = {"Mult", "Chips", "Money"}
            return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult, ( (card and card.ability and card.ability.extra) or self.config.extra ).chips, ( (card and card.ability and card.ability.extra) or self.config.extra ).dollars, modes[( (card and card.ability and card.ability.extra) or self.config.extra ).mode] } }
        end,
        calculate = function(self, card, context)
             if context.end_of_round and not context.repetition and not context.other_card then
                 card.ability.extra.mode = pseudorandom('heisenbug') % 3 + 1
                 return { message = 'Glitch!', colour = G.C.RED }
             end
             
             if context.joker_main then
                 if card.ability.extra.mode == 1 then
                     return { mult_mod = card.ability.extra.mult, message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } } }
                 elseif card.ability.extra.mode == 2 then
                     return { chip_mod = card.ability.extra.chips, message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } } }
                 else
                     return { dollars = card.ability.extra.dollars, message = localize('$')..card.ability.extra.dollars, colour = G.C.MONEY }
                 end
             end
        end
    }
}

for _, joker_def in ipairs(jokers) do
    joker_def.unlocked = true
    joker_def.discovered = false
    SMODS.Joker(joker_def)
end