-- 241. Visual Bug
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_visual_bug',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_glitch_visual_bug',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

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
        if context.before and not context.blueprint then
            -- Visual effect: flip cards face down only for this hand
            for k, v in ipairs(context.scoring_hand) do
                v.facing = 'back'
                v.sprite_facing = 'back'
            end
        end
        if context.after and not context.blueprint then
            -- Reset visual effect
            for k, v in ipairs(G.play.cards) do
                v.facing = 'front'
                v.sprite_facing = 'front'
            end
        end
    end
})

-- 242. Syntax Error
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_syntax_error',
    config = { extra = { chips = 50, money = 2 } },
    rarity = 1,
    atlas = 'j_glitch_syntax_error',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, extra.money } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
        if context.before and context.scoring_name == 'High Card' and not context.blueprint then
            ease_dollars(card.ability.extra.money)
            return {
                message = localize('$')..card.ability.extra.money,
                colour = G.C.MONEY,
                card = card
            }
        end
    end
})

-- 243. Lag
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_lag',
    config = { extra = { mult = 20, active = false } },
    rarity = 1,
    atlas = 'j_glitch_lag',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.active then
                card.ability.extra.active = false
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            else
                card.ability.extra.active = true
                return {
                    message = 'Lag...',
                    colour = G.C.ATTENTION
                }
            end
        end
    end
})

-- 244. Dead Pixel
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_dead_pixel',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_glitch_dead_pixel',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

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
        if context.before and not context.blueprint then
            local available_cards = {}
            for k, v in ipairs(G.hand.cards) do
                if not v.debuff then table.insert(available_cards, v) end
            end
            if #available_cards > 0 then
                local target = pseudorandom_element(available_cards, pseudorandom('dead_pixel'))
                target:set_debuff(true)
                return {
                    message = 'Dead Pixel!',
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end
})

-- 245. Money Glitch
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_money_glitch',
    config = { extra = { odds = 10, money = 5 } },
    rarity = 1,
    atlas = 'j_glitch_money_glitch',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money, G.GAME.probabilities.normal, extra.odds } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('money_glitch') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize('$')..card.ability.extra.money,
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

-- 246. Overflow
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_overflow',
    config = { extra = { threshold = 100, mult = 10 } },
    rarity = 1,
    atlas = 'j_glitch_overflow',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.threshold, extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local chips = G.GAME.hands[context.scoring_name].chips
            if chips > card.ability.extra.threshold then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 247. Underflow
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_underflow',
    config = { extra = { threshold = 20, mult = 30 } },
    rarity = 1,
    atlas = 'j_glitch_underflow',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.threshold, extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local chips = G.GAME.hands[context.scoring_name].chips
            if chips < card.ability.extra.threshold then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 248. Clipping
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_clipping',
    config = { extra = {} },
    rarity = 1,
    atlas = 'j_glitch_clipping',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #context.full_hand > 5 then
                local rightmost = context.full_hand[#context.full_hand]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function() 
                        draw_card(G.play, G.discard, 90, 'down', nil, rightmost)
                        return true 
                    end
                }))
                return {
                    message = 'Clipped!',
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 249. Corrupted
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_corrupted',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_glitch_corrupted',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

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
        if context.before and not context.blueprint then
            local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
            for k, v in ipairs(context.scoring_hand) do
                local new_suit = suits[pseudorandom('corrupted', 1, 4)]
                v:change_suit(new_suit)
            end
            return {
                message = 'Corrupted!',
                colour = G.C.PURPLE
            }
        end
    end
})

-- 250. MissingNo
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_missingno',
    config = { extra = { min = 1, max = 3 } },
    rarity = 1,
    atlas = 'j_glitch_missingno',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local xmult = card.ability.extra.min + (pseudorandom('missingno') * (card.ability.extra.max - card.ability.extra.min))
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { string.format("%.2f", xmult) } },
                Xmult_mod = xmult,
                colour = G.C.MULT
            }
        end
    end
})

-- 251. Blue Screen
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_blue_screen',
    config = { extra = { money = 4 } },
    rarity = 1,
    atlas = 'j_glitch_blue_screen',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.discard then
            if #context.full_hand == 5 then
                local suit = context.full_hand[1].base.suit
                local all_same = true
                for k, v in ipairs(context.full_hand) do
                    if v.base.suit ~= suit then all_same = false; break end
                end
                
                if all_same then
                    ease_dollars(card.ability.extra.money)
                    return {
                        message = localize('$')..card.ability.extra.money,
                        colour = G.C.MONEY,
                        card = card
                    }
                end
            end
        end
    end
})

-- 252. Error 404
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_error_404',
    config = { extra = { chips = 40, mult = 40 } },
    rarity = 1,
    atlas = 'j_glitch_error_404',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == 'High Card' then
                return {
                    message = localize('k_val_up'),
                    chip_mod = card.ability.extra.chips,
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
})

-- 253. Infinite Loop
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_infinite_loop',
    loc_txt = {
        name = "Infinite Loop",
        text = {
            "{C:mult}+5{} Mult.",
            "Increases by {C:mult}+1{} Mult",
            "each time it triggers in a round",
            "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}"
        }
    },
    config = { extra = { mult = 5, gain = 1, current = 5 } },
    rarity = 1,
    atlas = 'j_glitch_infinite_loop',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.current } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local current = card.ability.extra.current
            card.ability.extra.current = current + card.ability.extra.gain
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { current } },
                mult_mod = current,
                colour = G.C.MULT
            }
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.current = card.ability.extra.mult
        end
    end
})

-- 254. Stack Overflow
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_stack_overflow',
    loc_txt = {
        name = "Stack Overflow",
        text = {
            "{C:mult}+4{} Mult for each",
            "card in your {C:attention}hand{}"
        }
    },
    config = { extra = { mult_per_card = 4 } },
    rarity = 1,
    atlas = 'j_glitch_stack_overflow',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult_per_card } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local cards_in_hand = #G.hand.cards
            local mult = cards_in_hand * card.ability.extra.mult_per_card
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                mult_mod = mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 255. Memory Leak
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_memory_leak',
    loc_txt = {
        name = "Memory Leak",
        text = {
            "{C:mult}+20{} Mult.",
            "{C:red}-1{} Discard"
        }
    },
    config = { extra = { mult = 20 } },
    rarity = 1,
    atlas = 'j_glitch_memory_leak',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
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
})

-- 256. Patch
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_glitch_patch',
    loc_txt = {
        name = "Patch",
        text = {
            "{C:mult}+10{} Mult for each",
            "{C:attention}debuffed Joker{} you have"
        }
    },
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_glitch_patch',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local debuffed_count = 0
            for k, v in ipairs(G.jokers.cards) do
                if v.debuff then debuffed_count = debuffed_count + 1 end
            end
            
            if debuffed_count > 0 then
                local mult = debuffed_count * card.ability.extra.mult
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                    mult_mod = mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})
