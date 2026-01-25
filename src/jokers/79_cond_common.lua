-- J901-920: Conditions & Logic (Common)

-- Hair Trigger (J901)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_hair_trigger',
    config = { extra = { mult = 2 } },
    rarity = 1,
    atlas = 'j_cond_hair_trigger',
    pos = { x = 0, y = 0 },
    cost = 2,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                card = card
            }
        end
    end
})

-- Heavy Trigger (J902)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_heavy_trigger',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_cond_heavy_trigger',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and context.full_hand and #context.full_hand == 5 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- Conditional (J903)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_conditional',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_cond_conditional',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_left == 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- If (J904)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_if',
    config = { extra = { mult = 20 } },
    rarity = 1,
    atlas = 'j_cond_if',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.dollars == 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- Else (J905)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_else',
    config = { extra = { mult = 5 } },
    rarity = 1,
    atlas = 'j_cond_else',
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.dollars ~= 0 then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- While (J906)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_while',
    config = { extra = { chips = 10 } },
    rarity = 1,
    atlas = 'j_cond_while',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.chips } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_left > 0 then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- For Loop (J907)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_for_loop',
    config = { extra = { mult = 2 } },
    rarity = 1,
    atlas = 'j_cond_for_loop',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = #G.hand.cards
            return {
                mult_mod = card.ability.extra.mult * count,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult * count } }
            }
        end
    end
})

-- Switch (J908)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_switch',
    config = { extra = { mult = 10, chips = 50, money = 2 } },
    rarity = 1,
    atlas = 'j_cond_switch',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Hearts') then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            elseif context.other_card:is_suit('Spades') then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            elseif context.other_card:is_suit('Diamonds') then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$')..card.ability.extra.money,
                    colour = G.C.MONEY,
                    card = card
                }
            elseif context.other_card:is_suit('Clubs') then
                return {
                    extra = { focus = card, message = localize('k_again_ex'), func = function() return true end },
                    card = card
                }
            end
        end
    end
})

-- Break (J909)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_break',
    rarity = 1,
    atlas = 'j_cond_break',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.chips + (G.GAME.current_round.current_hand and G.GAME.current_round.current_hand.chips or 0) >= G.GAME.blind.chips then
            -- Note: We can't easily "stop" scoring in many ways without complex hooks, 
            -- but we can signal it. For now, it's a flavor/utility card that might need custom hooks.
            return {
                message = "BREAK!",
                colour = G.C.FILTER
            }
        end
    end
})

-- Continue (J910)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_continue',
    rarity = 1,
    atlas = 'j_cond_continue',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            -- This is tricky. Repetitions normally happen card by card.
            -- This joker would need to track "next card" which is hard in calculate.
            return {
                message = "CONTINUE!",
                repetitions = 1,
                card = card
            }
        end
    end
})

-- Return (J911)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_return',
    rarity = 1,
    atlas = 'j_cond_return',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    draw_card(G.play, G.hand, 100, 'up', true, context.other_card)
                    return true
                end
            }))
            return {
                message = "RETURN!",
                colour = G.C.BLUE,
                card = card
            }
        end
    end
})

-- Print (J912)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_print',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_cond_print',
    pos = { x = 0, y = 0 },
    cost = 2,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "Hello World!",
                colour = G.C.WHITE
            }
        end
    end
})

-- Input (J913)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_input',
    rarity = 1,
    atlas = 'j_cond_input',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            -- In Balatro, we don't have "click to activate" easily in calculate.
            -- Using a probability or simple mult for now.
            return {
                mult_mod = 10,
                message = "INPUT RECEIVED"
            }
        end
    end
})

-- Output (J914)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_output',
    config = { extra = { money = 5 } },
    rarity = 1,
    atlas = 'j_cond_output',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.money } } end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
    end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- Variable (J915)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_variable',
    config = { extra = { mult = 0 } },
    rarity = 1,
    atlas = 'j_cond_variable',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.end_of_round and not context.other_card and not context.repetition and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + 1
            return {
                message = "++Var",
                colour = G.C.MULT
            }
        end
    end
})

-- Constant (J916)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_constant',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_cond_constant',
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- Function (J917)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_function',
    rarity = 1,
    atlas = 'j_cond_function',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.jokers then
            local my_pos = nil
            for i=1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i; break end
            end
            if my_pos and my_pos > 1 and G.jokers.cards[my_pos-1] == context.other_joker then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- Class (J918)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_class',
    config = { extra = { mult = 4 } },
    rarity = 1,
    atlas = 'j_cond_class',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker.config.rarity == 1 and context.other_joker ~= card then
            if context.joker_main then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- Object (J919)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_object',
    rarity = 1,
    atlas = 'j_cond_object',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'obj')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    return true
                end
            }))
        end
    end
})

-- Array (J920)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_array',
    config = { extra = { mult = 5 } },
    rarity = 1,
    atlas = 'j_cond_array',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = #G.jokers.cards
            return {
                mult_mod = card.ability.extra.mult * count,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult * count } }
            }
        end
    end
})
