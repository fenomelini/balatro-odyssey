----------------------------------------------
-- POSITIONING & ADJACENCY (LEGENDARY) J899-J900
----------------------------------------------

-- J899 The Architect
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_the_architect',
    config = { extra = { slots = 5 } },
    rarity = 4,
    atlas = 'j_pos_the_architect',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.slots } }

    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J900 The Conductor
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_the_conductor',
    config = { extra = { x_mult = 5, step = 0.2 } },
    rarity = 4,
    atlas = 'j_pos_the_conductor',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult, extra.step } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i=1, #G.jokers.cards do if G.jokers.cards[i] == card then my_pos = i break end end
            local bonus = (my_pos - 1) * card.ability.extra.step
            return {
                x_mult = card.ability.extra.x_mult + bonus,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult + bonus } },
                colour = G.C.RED
            }
        end
        -- Also buff others when they calculate?
        -- Actually, it's easier to just have the Conductor provide the cumulative bonus itself based on its own position.
        -- But the description says "All Jokers trigger in sequence with cumulative multiplier".
        -- Let's make it a global hook in other_joker context.
        if context.other_joker and context.other_joker ~= card then
             local other_pos = nil
             for i=1, #G.jokers.cards do if G.jokers.cards[i] == context.other_joker then other_pos = i break end end
             if other_pos then
                return {
                    x_mult = 1 + (other_pos * card.ability.extra.step),
                    message = "VIVO!",
                    colour = G.C.GOLD
                }
             end
        end
    end
})
