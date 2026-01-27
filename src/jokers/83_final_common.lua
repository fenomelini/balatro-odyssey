-- J951-970: Final & Specials (Common)

-- The End (J951)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_the_end',
    config = { extra = { mult = 20, x_mult = 4 } },
    rarity = 1,
    atlas = 'j_final_the_end',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_left == 0 and G.GAME.round_resets.ante >= 8 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            else
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- The Beginning (J952)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_the_beginning',
    config = { extra = { mult = 20, chips = 100 } },
    rarity = 1,
    atlas = 'j_final_the_beginning',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).chips } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played < 3 then
            return {
                mult_mod = card.ability.extra.mult,
                chip_mod = card.ability.extra.chips,
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- The Middle (J953)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_the_middle',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_final_the_middle',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 3 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Prologue (J954)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_prologue',
    config = { extra = { mult = 10, last_ante = -1 } },
    rarity = 1,
    atlas = 'j_final_prologue',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and card.ability.extra.last_ante < G.GAME.round_resets.ante then
            card.ability.extra.last_ante = G.GAME.round_resets.ante
            local tag = Tag(get_next_tag_key('joker_prologue'))
            add_tag(tag)
            return {
                message = "TAG!",
                colour = G.C.FILTER
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

-- Epilogue (J955)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_epilogue',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_final_epilogue',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card then
            local overkill = G.GAME.chips - G.GAME.blind.chips
            if overkill > 0 then
                local dollars = math.min(10, math.floor(overkill / 100))
                if dollars > 0 then
                    ease_dollars(dollars)
                    return {
                        message = localize{type='variable', key='a_money', vars={dollars}},
                        colour = G.C.MONEY
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- Chapter 1 (J956)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_chapter1',
    config = { extra = { mult_per_hand = 5 } },
    rarity = 1,
    atlas = 'j_final_chapter1',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) 
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult_per_hand, (G.GAME.current_round.hands_played or 0) * ( (card and card.ability and card.ability.extra) or self.config.extra ).mult_per_hand } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local mult = (G.GAME.current_round.hands_played or 0) * card.ability.extra.mult_per_hand
            if mult > 0 then
                return {
                    mult_mod = mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { mult } }
                }
            end
        end
    end
})

-- Chapter 2 (J957)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_chapter2',
    config = { extra = { mult_per_discard = 5 } },
    rarity = 1,
    atlas = 'j_final_chapter2',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) 
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult_per_discard, (G.GAME.current_round.discards_used or 0) * ( (card and card.ability and card.ability.extra) or self.config.extra ).mult_per_discard } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local mult = (G.GAME.current_round.discards_used or 0) * card.ability.extra.mult_per_discard
            if mult > 0 then
                return {
                    mult_mod = mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { mult } }
                }
            end
        end
    end
})

-- Chapter 3 (J958)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_chapter3',
    config = { extra = { mult_per_card = 5 } },
    rarity = 1,
    atlas = 'j_final_chapter3',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult_per_card } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult_per_card,
                card = card
            }
        end
    end
})

-- Climax (J959)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_climax',
    config = { extra = { x_mult = 3 } },
    rarity = 1,
    atlas = 'j_final_climax',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            if (G.GAME.last_hand_sampling.flush or G.GAME.last_hand_sampling.straight) then
                local has_face = false
                for k, v in ipairs(context.scoring_hand) do
                    if v:is_face() then has_face = true; break end
                end
                if has_face then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                    }
                end
            end
        end
    end
})

-- Plot Twist (J960)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_plot_twist',
    config = { extra = { mult = 20 } },
    rarity = 1,
    atlas = 'j_final_plot_twist',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('plot_twist') < G.GAME.probabilities.normal / 4 and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult * 2
                return {
                    mult_mod = card.ability.extra.mult,
                    message = "TWIST! X2",
                    colour = G.C.MULT
                }
            end
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- Hero (J961)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_hero',
    config = { extra = { x_mult = 3 } },
    rarity = 1,
    atlas = 'j_final_hero',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and #G.jokers.cards <= 1 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Villain (J962)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_villain',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_final_villain',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    add_to_deck = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
        ease_hands_left(-1)
    end,
    remove_from_deck = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
        ease_hands_left(1)
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

-- Sidekick (J963)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_sidekick',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_final_sidekick',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) 
        local count = (G.jokers and G.jokers.cards) and #G.jokers.cards or 1
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult, (count - 1) * ( (card and card.ability and card.ability.extra) or self.config.extra ).mult } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = #G.jokers.cards - 1
            if count > 0 then
                return {
                    mult_mod = count * card.ability.extra.mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { count * card.ability.extra.mult } }
                }
            end
        end
    end
})

-- Mentor (J964)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_mentor',
    config = { extra = { mult = 5 } },
    rarity = 1,
    atlas = 'j_final_mentor',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) 
        local levels = 0
        for k, v in pairs(G.GAME.hands) do
            if v.played > 0 then levels = levels + v.level end
        end
        return { vars = { card.ability.extra.mult, levels * card.ability.extra.mult } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local levels = 0
            for k, v in pairs(G.GAME.hands) do
                if v.played > 0 then levels = levels + v.level end
            end
            if levels > 0 then
                return {
                    mult_mod = levels * card.ability.extra.mult,
                    message = localize{ type = 'variable', key = 'a_mult', vars = { levels * card.ability.extra.mult } }
                }
            end
        end
    end
})

-- Rival (J965)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_rival',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_final_rival',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.chips < G.GAME.blind.chips then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Love (J966)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_love',
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    atlas = 'j_final_love',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Hearts') then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})

-- Hate (J967)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_hate',
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    atlas = 'j_final_hate',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Spades') then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})

-- Peace (J968)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_peace',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_final_peace',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_used == 0 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- War (J969)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_war',
    config = { extra = { mult = 0, mult_per_dest = 2 } },
    rarity = 1,
    atlas = 'j_final_war',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult_per_dest, (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        -- Need global hook for destruction, but we can simulate with selling cards or specific effects
    end
})

-- Death (J970)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_death',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_final_death',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.hand.cards > 0 and not context.blueprint then
                local destroyed_card = G.hand.cards[math.random(#G.hand.cards)]
                destroyed_card:start_dissolve()
            end
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})
