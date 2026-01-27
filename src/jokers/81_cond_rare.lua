-- J939-948: Conditions & Logic (Rare)

-- Algorithm (J939)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_algorithm',
    config = { extra = { mult = 15 } },
    rarity = 3,
    atlas = 'j_cond_algorithm',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.hand:sort()
            return {
                message = "SORTED",
                colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- AI (J940)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_ai',
    config = { extra = { x_mult = 1 } },
    rarity = 3,
    atlas = 'j_cond_ai',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
        if context.before and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + 0.1
            return {
                message = "LEARNING...",
                colour = G.C.FILTER
            }
        end
    end
})

-- Neural Net (J941)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_neural_net',
    rarity = 3,
    atlas = 'j_cond_neural_net',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local target = G.jokers.cards[math.random(#G.jokers.cards)]
            if target and target ~= card then
                return target:calculate_joker(context)
            end
        end
    end
})

-- Deep Learning (J942)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_deep_learning',
    config = { extra = { x_mult = 1, gain = 0.5 } },
    rarity = 3,
    atlas = 'j_cond_deep_learning',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).gain } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
        if context.end_of_round and not context.other_card and G.GAME.blind.boss and not context.repetition and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
            return {
                message = "DEEPENED!",
                colour = G.C.MULT
            }
        end
    end
})

-- Machine Learning (J943)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_machine_learning',
    config = { extra = { last_hand = nil, count = 0 } },
    rarity = 3,
    atlas = 'j_cond_machine_learning',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.before then
            if context.scoring_name == card.ability.extra.last_hand then
                card.ability.extra.played = card.ability.extra.played + 1
            else
                card.ability.extra.last_hand = context.scoring_name
                card.ability.extra.played = 1
            end
            
            if card.ability.extra.played >= 3 then
                card.ability.extra.played = 0
                update_hand_stats(context.scoring_name, 1)
                return {
                    message = "LEVEL UP!",
                    colour = G.C.ATTENTION
                }
            end
        end
    end
})

-- Big Data (J944)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_big_data',
    rarity = 3,
    atlas = 'j_cond_big_data',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { (G.playing_cards and #G.playing_cards or 52) } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = #G.playing_cards
            return {
                mult_mod = count,
                message = localize{ type = 'variable', key = 'a_mult', vars = { count } }
            }
        end
    end
})

-- Blockchain (J945)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_blockchain',
    config = { extra = { gain = 2 } },
    rarity = 3,
    atlas = 'j_cond_blockchain',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).gain } } end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.repetition then
            card.ability.sell_cost = card.ability.sell_cost + card.ability.extra.gain
            return {
                message = "MINED!",
                colour = G.C.GOLD
            }
        end
    end
})

-- NFT (J946)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_nft',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_cond_nft',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    add_to_deck = function(self, card)
        card.ability.eternal = true
        card.ability.sell_cost = 0
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Metaverse (J947)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_metaverse',
    rarity = 3,
    atlas = 'j_cond_metaverse',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local target = G.jokers.cards[math.random(#G.jokers.cards)]
            if target and target ~= card then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local _card = copy_card(target)
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        _card.ability.eternal = true -- temporary hack
                        -- We need a way to remove it later, maybe tag it
                        _card.meta_temporary = true
                        return true
                    end
                }))
                return {
                    message = "VIRTUAL CLONE",
                    colour = G.C.PURPLE
                }
            end
        end
        if context.end_of_round and not context.other_card then
             for i = #G.jokers.cards, 1, -1 do
                 if G.jokers.cards[i].meta_temporary then
                     G.jokers.cards[i]:remove()
                 end
             end
        end
    end
})

-- Web 3.0 (J948)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_web3',
    rarity = 3,
    atlas = 'j_cond_web3',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = false,
    add_to_deck = function(self, card)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
    end,
    remove_from_deck = function(self, card)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
