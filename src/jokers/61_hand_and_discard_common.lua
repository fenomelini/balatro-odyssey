-- ============================================
-- HAND AND DISCARD - Common (Jokers 651-670)
-- ============================================

-- 651. Extra Hand
SMODS.Joker({
    key = 'j_hand_and_discard_extra_hand',
    config = { extra = 1 },
    rarity = 1,
    atlas = 'j_hand_and_discard_extra_hand',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 652. Extra Discard
SMODS.Joker({
    key = 'j_hand_and_discard_extra_discard',
    config = { extra = 1 },
    rarity = 1,
    atlas = 'j_hand_and_discard_extra_discard',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 653. Recycling
SMODS.Joker({
    key = 'j_hand_and_discard_recycling',
    config = { extra = { hands_needed = 2, hands_played = 0 } },
    rarity = 1,
    atlas = 'j_hand_and_discard_recycling',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            card.ability.extra.hands_played = card.ability.extra.hands_played + 1
            if card.ability.extra.hands_played >= card.ability.extra.hands_needed then
                card.ability.extra.hands_played = 0
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + 1
                return {
                    message = localize('k_plus_discard'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).hands_needed, (( (card and card.ability and card.ability.extra) or self.config.extra )).hands_played } } end
})

-- 654. Trash Can
SMODS.Joker({
    key = 'j_hand_and_discard_trash_can',
    config = { extra = 1 },
    rarity = 1,
    atlas = 'j_hand_and_discard_trash_can',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.discard and G.GAME.current_round.discards_left <= 0 then
            ease_dollars(card.ability.extra)
            return {
                message = localize('$')..card.ability.extra,
                colour = G.C.MONEY,
                card = card
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 655. Full Hand
SMODS.Joker({
    key = 'j_hand_and_discard_full_hand',
    config = { extra = 20 },
    rarity = 1,
    atlas = 'j_hand_and_discard_full_hand',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand == 5 then
            return {
                message = localize{type='variable', key='a_chips', vars={card.ability.extra}},
                chip_mod = card.ability.extra,
                colour = G.C.CHIPS
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 656. Empty Hand
SMODS.Joker({
    key = 'j_hand_and_discard_empty_hand',
    config = { extra = 20 },
    rarity = 1,
    atlas = 'j_hand_and_discard_empty_hand',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand <= 2 then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra}},
                mult_mod = card.ability.extra,
                colour = G.C.MULT
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 657. Juggler
SMODS.Joker({
    key = 'j_hand_and_discard_juggler',
    config = { extra = 1 },
    rarity = 1,
    atlas = 'j_hand_and_discard_juggler',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then
            G.hand:change_size(card.ability.extra)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then
            G.hand:change_size(-card.ability.extra)
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 658. Street Magician
SMODS.Joker({
    key = 'j_hand_and_discard_street_magician',
    config = { extra = { odds = 5, money = 2 } },
    rarity = 1,
    atlas = 'j_hand_and_discard_street_magician',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.discard and not context.other_card then
            if pseudorandom('street_magician') < G.GAME.probabilities.normal / card.ability.extra.odds then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$')..card.ability.extra.money,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ).odds, ( (card and card.ability and card.ability.extra) or self.config.extra ).money } } end
})

-- 659. Cards Up Sleeve
SMODS.Joker({
    key = 'j_hand_and_discard_cards_up_sleeve',
    config = { extra = { odds = 4 } },
    rarity = 1,
    atlas = 'j_hand_and_discard_cards_up_sleeve',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if pseudorandom('cards_up_sleeve') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.5,
                    func = function()
                        draw_card(G.deck, G.hand, 90, 'up', nil)
                        return true
                    end
                }))
                return {
                    message = "Extra Card!",
                    colour = G.C.BLUE,
                    card = card
                }
            end
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ).odds } } end
})

-- 660. Dealer
SMODS.Joker({
    key = 'j_hand_and_discard_dealer',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_hand_and_discard_dealer',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra}},
                mult_mod = card.ability.extra,
                colour = G.C.MULT
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 661. Auto Shuffler
SMODS.Joker({
    key = 'j_hand_and_discard_auto_shuffler',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_hand_and_discard_auto_shuffler',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({ func = function()
                table.sort(G.deck.cards, function(a, b) 
                    return (a.base.value or 0) > (b.base.value or 0) 
                end)
                return true
            end }))
            return { message = "Sorted!", colour = G.C.BLUE }
        end
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end
})

-- 662. Deck Cut
SMODS.Joker({
    key = 'j_hand_and_discard_deck_cut',
    config = { extra = { mult = 15, cards = 5 } },
    rarity = 1,
    atlas = 'j_hand_and_discard_deck_cut',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({ func = function()
                for i=1, card.ability.extra.cards do
                    if G.deck.cards[1] then
                        local deleted_card = G.deck.cards[1]
                        draw_card(G.deck, G.discard, i*100/card.ability.extra.cards, 'down', false, deleted_card)
                    end
                end
                return true
            end }))
            return { message = "Cut!", colour = G.C.RED }
        end
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).cards, (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end
})

-- 663. Ghost Hand
SMODS.Joker({
    key = 'j_hand_and_discard_ghost_hand',
    config = { extra = 1, extra_hand_given = false },
    rarity = 1,
    atlas = 'j_hand_and_discard_ghost_hand',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.after and G.GAME.current_round.hands_left == 0 and not card.ability.extra_hand_given then
             G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 1
             card.ability.extra_hand_given = true
             return { 
                 message = "Ghost Hand!",
                 colour = G.C.FILTER
             }
        end
        if context.end_of_round and not context.other_card then card.ability.extra_hand_given = false end
    end
})

-- 664. Tactical Discard
SMODS.Joker({
    key = 'j_hand_and_discard_tactical_discard',
    config = { extra = { mult = 10, active = false } },
    rarity = 1,
    atlas = 'j_hand_and_discard_tactical_discard',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.discard and not context.other_card then
            if #context.full_hand == 1 then
                card.ability.extra.active = true
                return { 
                    message = "Tactical!",
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main and card.ability.extra.active then
            card.ability.extra.active = false
            return { 
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end
})

-- 665. Steady Hand
SMODS.Joker({
    key = 'j_hand_and_discard_steady_hand',
    config = { extra = 1.5 },
    rarity = 1,
    atlas = 'j_hand_and_discard_steady_hand',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_used == 0 then
            return { x_mult = card.ability.extra }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 666. Shaky Hand
SMODS.Joker({
    key = 'j_hand_and_discard_shaky_hand',
    config = { extra = 50 },
    rarity = 1,
    atlas = 'j_hand_and_discard_shaky_hand',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_left == 0 then
            return { chip_mod = card.ability.extra }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 667. Boxing Glove
SMODS.Joker({
    key = 'j_hand_and_discard_boxing_glove',
    config = { extra = 10 },
    rarity = 1,
    atlas = 'j_hand_and_discard_boxing_glove',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local hand_count = #G.hand.cards
            return { chip_mod = hand_count * card.ability.extra }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ), (G.hand and G.hand.cards and #G.hand.cards or 0) * ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 668. Silk Glove
SMODS.Joker({
    key = 'j_hand_and_discard_silk_glove',
    config = { extra = 5 },
    rarity = 1,
    atlas = 'j_hand_and_discard_silk_glove',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult_mod = G.GAME.current_round.discards_left * card.ability.extra }
        end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ), G.GAME.current_round.discards_left * ( (card and card.ability and card.ability.extra) or self.config.extra ) } } end
})

-- 669. Gauntlet
SMODS.Joker({
    key = 'j_hand_and_discard_gauntlet',
    config = { extra = { chips = 50, discards = 1 } },
    rarity = 1,
    atlas = 'j_hand_and_discard_gauntlet',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards end
    end,
    calculate = function(self, card, context)
        if context.joker_main then return { chip_mod = card.ability.extra.chips } end
    end,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).chips, (( (card and card.ability and card.ability.extra) or self.config.extra )).discards } } end
})

-- 670. Magic Finger
SMODS.Joker({
    key = 'j_hand_and_discard_magic_finger',
    config = { extra = 1 },
    rarity = 1,
    atlas = 'j_hand_and_discard_magic_finger',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME then G.play.config.card_limit = G.play.config.card_limit + 1 end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME then G.play.config.card_limit = G.play.config.card_limit - 1 end
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
