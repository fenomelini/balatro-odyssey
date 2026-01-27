----------------------------------------------
-- POSITIONING & ADJACENCY (RARE) J889-J898
----------------------------------------------

-- J889 Pentagram
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_pentagram',
    config = { extra = { x_mult = 6.66 } },
    rarity = 3,
    atlas = 'j_pos_pentagram',
    pos = { x = 0, y = 0 },
    cost = 13,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.jokers.cards == 5 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = "THE BEAST",
                colour = G.C.RED
            }
        end
    end
})

-- J890 Alignment
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_alignment',
    config = { extra = { x_mult = 4 } },
    rarity = 3,
    atlas = 'j_pos_alignment',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local same = true
            local first_rarity = G.jokers.cards[1].config.rarity
            for i = 2, #G.jokers.cards do
                if G.jokers.cards[i].config.rarity ~= first_rarity then same = false; break end
            end
            if same and #G.jokers.cards > 1 then
                 return {
                    x_mult = card.ability.extra.x_mult,
                    message = "ALIGNED",
                    colour = G.C.BLUE
                }
            end
        end
    end
})

-- J891 Disorder
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_disorder',
    config = { extra = { x_mult = 4 } },
    rarity = 3,
    atlas = 'j_pos_disorder',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local seen = {}
            local unique = true
            for i = 1, #G.jokers.cards do
                local r = G.jokers.cards[i].config.rarity
                if seen[r] then unique = false; break end
                seen[r] = true
            end
            if unique and #G.jokers.cards > 1 then
                 return {
                    x_mult = card.ability.extra.x_mult,
                    message = "DISORDER",
                    colour = G.C.ORANGE
                }
            end
        end
    end
})

-- J892 Symmetry
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_symmetry',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_pos_symmetry',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local is_symmetric = true
            for i = 1, math.floor(#G.jokers.cards / 2) do
                if G.jokers.cards[i].config.rarity ~= G.jokers.cards[#G.jokers.cards - i + 1].config.rarity then
                    is_symmetric = false
                    break
                end
            end
            if is_symmetric and #G.jokers.cards > 1 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "SYMMETRY",
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

-- J893 Positional Chaos
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_positional_chaos',
    config = { extra = { mult = 40 } },
    rarity = 3,
    atlas = 'j_pos_positional_chaos',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "CHAOS!",
                colour = G.C.FILTER
            }
        end
    end
})

-- J894 Black Hole
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_black_hole',
    config = { extra = { x_mult = 4 } },
    rarity = 3,
    atlas = 'j_pos_black_hole',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i=1, #G.jokers.cards do if G.jokers.cards[i] == card then my_pos = i break end end
            if my_pos == math.ceil(#G.jokers.cards / 2) and #G.jokers.cards % 2 ~= 0 then -- True center
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "SINGULARITY!",
                    colour = G.C.BLACK
                }
            end
        end
    end
})

-- J895 Supernova
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_supernova',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_pos_supernova',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i=1, #G.jokers.cards do if G.jokers.cards[i] == card then my_pos = i break end end
            if my_pos == 1 or my_pos == #G.jokers.cards then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "EXPLOSION!",
                    colour = G.C.ORANGE
                }
            end
        end
    end
})

-- J896 Galaxy
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_galaxy',
    config = { extra = { x_mult_mod = 1.2 } },
    rarity = 3,
    atlas = 'j_pos_galaxy',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = (G.jokers and G.jokers.cards) and #G.jokers.cards or 0
        local total_xmult = (card and card.ability.extra or self.config.extra).x_mult_mod ^ count
        return { vars = { (card and card.ability.extra or self.config.extra).x_mult_mod, total_xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_xmult = card.ability.extra.x_mult_mod ^ #G.jokers.cards
            return {
                x_mult = total_xmult,
                message = "ORBITAL",
                colour = G.C.BLUE
            }
        end
    end
})

-- J897 Universe
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_universe',
    config = { extra = { slots = 4 } },
    rarity = 3,
    atlas = 'j_pos_universe',
    pos = { x = 0, y = 0 },
    cost = 12,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

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

-- J898 Multiverse
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_multiverse',
    config = { extra = { x_mult = 2 } },
    rarity = 3,
    atlas = 'j_pos_multiverse',
    pos = { x = 0, y = 0 },
    cost = 12,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.GAME and G.GAME.probabilities then
            for k, v in pairs(G.GAME.probabilities) do count = count + 1 end
        end
        return { vars = { 1 + (count * 0.1) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
             local count = 0
             for k, v in pairs(G.GAME.probabilities) do count = count + 1 end
             return {
                x_mult = 1 + (count * 0.1),
                message = "MULTIVERSE",
                colour = G.C.PURPLE
             }
        end
    end
})
