-- J921-938: Conditions & Logic (Uncommon)

-- Boolean (J921)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_boolean',
    config = { extra = { x_mult_true = 2, x_mult_false = 0.5 } },
    rarity = 2,
    atlas = 'j_cond_boolean',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult_true, card.ability.extra.x_mult_false } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local cond = (pseudorandom('boolean') > 0.5)
            local mod = cond and card.ability.extra.x_mult_true or card.ability.extra.x_mult_false
            return {
                x_mult = mod,
                message = cond and "TRUE!" or "FALSE!",
                colour = cond and G.C.GREEN or G.C.RED
            }
        end
    end
})

-- Integer (J922)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_integer',
    rarity = 2,
    atlas = 'j_cond_integer',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            -- This would need to run after all other mults.
            -- In Balatro's calculate loop, we don't have a clean "post-process" hook for just one joker.
            -- But we can simulate it by being high index or just floor/ceil.
            return {
                message = "INT",
                colour = G.C.FILTER
            }
        end
    end
})

-- Float (J923)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_float',
    rarity = 2,
    atlas = 'j_cond_float',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        -- Balatro already allows floats, so this is flavor/enabler.
        if context.joker_main then
            return {
                mult_mod = 0.5,
                message = "+0.5"
            }
        end
    end
})

-- String (J924)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_string',
    config = { extra = { mult = 10 } },
    rarity = 2,
    atlas = 'j_cond_string',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local msgs = {"YOU CAN DO IT", "STAY FOCUSED", "BIG BLIND AHEAD", "LUA IS BEST"}
            local msg = msgs[math.random(#msgs)]
            return {
                mult_mod = card.ability.extra.mult,
                message = msg,
                colour = G.C.MULT
            }
        end
    end
})

-- Char (J925)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_char',
    rarity = 2,
    atlas = 'j_cond_char',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name then
            local char = string.sub(context.scoring_name, 1, 1)
            -- Different bonus per first char
            local bonus = 5
            if char == 'S' or char == 'F' then bonus = 15 end -- Straight, Flush, Full House
            return {
                mult_mod = bonus,
                message = char .. "!"
            }
        end
    end
})

-- Null (J926)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_null',
    rarity = 2,
    atlas = 'j_cond_null',
    pos = { x = 0, y = 0 },
    cost = 1,
    blueprint_compat = true,
    calculate = function(self, card, context)
        -- Literally does nothing.
    end
})

-- Undefined (J927)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_undefined',
    rarity = 2,
    atlas = 'j_cond_undefined',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local r = math.random()
            if r < 0.25 then return { mult = 10 }
            elseif r < 0.5 then return { chips = 50 }
            elseif r < 0.75 then return { x_mult = 1.5 }
            else return { message = "UNDEFINED", colour = G.C.FILTER } end
        end
    end
})

-- NaN (J928)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_nan',
    config = { extra = { mult = 11 } },
    rarity = 2,
    atlas = 'j_cond_nan',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "N/A/N",
                colour = G.C.BLACK
            }
        end
    end
})

-- Infinity (J929)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_infinity',
    rarity = 2,
    atlas = 'j_cond_infinity',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = 5,
                message = "INF",
                colour = G.C.MULT
            }
        end
    end
})

-- Exception (J930)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_exception',
    config = { extra = { money = 10 } },
    rarity = 2,
    atlas = 'j_cond_exception',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.money } } end,
    calculate = function(self, card, context)
        -- Triggered if something "fails" (like a 1 in X chance)
        if context.joker_main and G.GAME.probabilities.normal > 100 then -- fake cond
            ease_dollars(card.ability.extra.money)
            return {
                message = "EXC!",
                colour = G.C.MONEY
            }
        end
    end
})

-- Try Catch (J931)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_try_catch',
    config = { extra = { money = 5 } },
    rarity = 2,
    atlas = 'j_cond_try_catch',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.money } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            -- Tries to activate a random joker
            local other = G.jokers.cards[math.random(#G.jokers.cards)]
            if other and other ~= card then
                return other:calculate_joker(context)
            else
                ease_dollars(card.ability.extra.money)
                return {
                    message = "CATCH!",
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- Async (J932)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_async',
    rarity = 2,
    atlas = 'j_cond_async',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.after then
            return {
                mult = 20,
                message = "ASYNC"
            }
        end
    end
})

-- Await (J933)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_await',
    rarity = 2,
    atlas = 'j_cond_await',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind.boss then
            return {
                x_mult = 3,
                message = "AWAIT DONE"
            }
        end
    end
})

-- Promise (J934)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_promise',
    config = { extra = { rounds = 3, x_mult = 3 } },
    rarity = 2,
    atlas = 'j_cond_promise',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult, card.ability.extra.rounds } } end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.repetition and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds <= 0 then
                card:juice_up()
                return {
                    message = "FULFILLED!",
                    colour = G.C.GOLD
                }
            end
        end
        if context.joker_main and card.ability.extra.rounds <= 0 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = "PROMISED"
            }
        end
    end
})

-- Callback (J935)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_callback',
    rarity = 2,
    atlas = 'j_cond_callback',
    pos = { x = 0, y = 0 },
    cost = 6,
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

-- Recursion (J936)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_recursion',
    rarity = 2,
    atlas = 'j_cond_recursion',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.jokers and context.other_joker == card then
            -- Note: recursive repetition needs a limit to avoid lock
            if (context.recursion_count or 0) < 2 then
                context.recursion_count = (context.recursion_count or 0) + 1
                return {
                    message = "REC",
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- Stack (J937)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_stack',
    config = { extra = { mult = 0 } },
    rarity = 2,
    atlas = 'j_cond_stack',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.selling_card and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + 2
            return {
                message = "STACK+",
                colour = G.C.MULT
            }
        end
    end
})

-- Heap (J938)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_cond_heap',
    config = { extra = { money = 1 } },
    rarity = 2,
    atlas = 'j_cond_heap',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.money } } end,
    calc_dollar_bonus = function(self, card)
        return (G.jokers and G.jokers.cards and #G.jokers.cards or 0) * card.ability.extra.money
    end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
