----------------------------------------------
-- POSITIONING & ADJACENCY (UNCOMMON) J871-J888
----------------------------------------------

-- J871 Battle Formation
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_battle_formation',
    config = { extra = { mult = 15, chips = 50 } },
    rarity = 2,
    atlas = 'j_pos_battle_formation',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            if idx == 1 or idx == #G.jokers.cards then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            else
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
        end
    end
})

-- J872 Frontline
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_frontline',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_pos_frontline',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            if idx <= 2 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J873 Backline
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_backline',
    config = { extra = { chips = 100 } },
    rarity = 2,
    atlas = 'j_pos_backline',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
             local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            if idx >= #G.jokers.cards - 1 then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
        end
    end
})

-- J874 Flank
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_flank',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_pos_flank',
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.jokers.cards >= 2 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J875 Siege
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_siege',
    config = { extra = { mult = 50 } },
    rarity = 2,
    atlas = 'j_pos_siege',
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.jokers.cards >= G.jokers.config.card_limit then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- J876 Isolation
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_isolation',
    config = { extra = { x_mult = 2.5 } },
    rarity = 2,
    atlas = 'j_pos_isolation',
    pos = { x = 0, y = 0 },
    cost = 9,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            local isolated = true
            -- Simplified check: usually jokers are always adjacent in the UI
            -- but maybe we can check if they are "separated" by something
            if isolated then
                 return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J877 Clumping
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_clumping',
    config = { extra = { mult = 30 } },
    rarity = 2,
    atlas = 'j_pos_clumping',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
             if #G.jokers.cards >= 3 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- J878 Musical Chairs
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_musical_chairs',
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_pos_musical_chairs',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.other_card then
            -- Randomize positions
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.jokers:shuffle()
                    return true
                end
            }))
        end
        if context.joker_main then
             return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J879 Carousel
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_carousel',
    config = { extra = { mult = 10 } },
    rarity = 2,
    atlas = 'j_pos_carousel',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.first_hand_column and not context.blueprint then
             -- Shift right
             G.E_MANAGER:add_event(Event({
                func = function()
                    local last = G.jokers.cards[#G.jokers.cards]
                    table.remove(G.jokers.cards, #G.jokers.cards)
                    table.insert(G.jokers.cards, 1, last)
                    return true
                end
             }))
        end
    end
})

-- J880 Rook
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_rook',
    config = { extra = { mult = 25 } },
    rarity = 2,
    atlas = 'j_pos_rook',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local king_present = false
            if G.jokers then
                for _, v in ipairs(G.jokers.cards) do
                    if v.config.center.key == 'j_odyssey_j_pos_king' then
                        king_present = true
                        break
                    end
                end
            end

            if king_present then
                return {
                    x_mult = 2,
                    message = "PROTECTED!",
                    colour = G.C.BLUE
                }
            else
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- J881 Bishop
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_bishop',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_pos_bishop',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i=1, #G.jokers.cards do if G.jokers.cards[i] == card then my_pos = i break end end
            if my_pos and my_pos % 2 == 1 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J882 Knight
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_knight',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_pos_knight',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J883 King
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_king',
    config = { extra = { x_mult = 2.5 } },
    rarity = 2,
    atlas = 'j_pos_king',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             local my_pos = nil
             for i=1, #G.jokers.cards do if G.jokers.cards[i] == card then my_pos = i break end end
             local neighbors = 0
             if my_pos > 1 then neighbors = neighbors + 1 end
             if my_pos < #G.jokers.cards then neighbors = neighbors + 1 end
             if neighbors == 2 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
             end
        end
    end
})

-- J884 Queen
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_queen',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_pos_queen',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- J885 Pawn
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_pawn',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_pos_pawn',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            if idx == #G.jokers.cards then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "QUEENED!",
                    colour = G.C.PURPLE
                }
            end
        end
    end
})

-- J886 Castling
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_castling',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_pos_castling',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J887 Check
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_check',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_pos_check',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.blind.boss then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "CHECK!",
                    colour = G.C.RED
                }
            end
        end
    end
})

-- J888 Checkmate
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_pos_checkmate',
    config = { extra = { x_mult = 10 } },
    rarity = 2,
    atlas = 'j_pos_checkmate',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.chips >= G.GAME.blind.chips * 0.9 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = "CHECKMATE!",
                colour = G.C.GOLD
            }
        end
    end
})
