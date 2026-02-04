-- ============================================
-- ELEMENTAL - Common (Jokers 401-420)
-- ============================================

-- 401. Eternal Flame
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_eternal_flame',
    discovered = false,
    config = { extra = { mult = 4 } },
    rarity = 1,
    atlas = 'j_elemental_eternal_flame',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 402. Raindrop
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_raindrop',
    discovered = false,
    config = { extra = { chips = 20 } },
    rarity = 1,
    atlas = 'j_elemental_raindrop',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).chips } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
})

-- 403. Runestone
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_runestone',
    discovered = false,
    config = { extra = { mult = 4 } },
    rarity = 1,
    atlas = 'j_elemental_runestone',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Diamonds") then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 404. Gentle Breeze
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_gentle_breeze',
    discovered = false,
    config = { extra = { chips = 20 } },
    rarity = 1,
    atlas = 'j_elemental_gentle_breeze',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).chips } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Clubs") then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
})

-- 405. Inferno
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_inferno',
    discovered = false,
    config = { extra = { mult = 15, perma_mult = 0, gain = 2 } },
    rarity = 1,
    atlas = 'j_elemental_inferno',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) 
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult, ( (card and card.ability and card.ability.extra) or self.config.extra ).perma_mult, ( (card and card.ability and card.ability.extra) or self.config.extra ).gain } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_mult = card.ability.extra.mult + card.ability.extra.perma_mult
            return {
                mult_mod = total_mult,
                message = localize{type='variable', key='a_mult', vars={total_mult}}
            }
        end
        if context.before and not context.blueprint then
            local hearts = 0
            for i=1, #context.scoring_hand do 
                if context.scoring_hand[i]:is_suit("Hearts") then hearts = hearts + 1 end 
            end
            if hearts >= 5 then
                card.ability.extra.perma_mult = card.ability.extra.perma_mult + card.ability.extra.gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
})

-- 406. Tsunami
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_tsunami',
    discovered = false,
    config = { extra = { chips = 50, perma_chips = 0, gain = 10 } },
    rarity = 1,
    atlas = 'j_elemental_tsunami',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) 
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).chips, ( (card and card.ability and card.ability.extra) or self.config.extra ).perma_chips, ( (card and card.ability and card.ability.extra) or self.config.extra ).gain } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_chips = card.ability.extra.chips + card.ability.extra.perma_chips
            return {
                chip_mod = total_chips,
                message = localize{type='variable', key='a_chips', vars={total_chips}}
            }
        end
        if context.before and not context.blueprint then
            local spades = 0
            for i=1, #context.scoring_hand do 
                if context.scoring_hand[i]:is_suit("Spades") then spades = spades + 1 end 
            end
            if spades >= 5 then
                card.ability.extra.perma_chips = card.ability.extra.perma_chips + card.ability.extra.gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    card = card
                }
            end
        end
    end
})

-- 407. Earthquake
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_earthquake',
    discovered = false,
    config = { extra = { mult = 10, dollars = 2 } },
    rarity = 1,
    atlas = 'j_elemental_earthquake',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).dollars } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
        if context.discard and not context.blueprint then
            if context.other_card:is_suit("Diamonds") then
                ease_dollars(card.ability.extra.dollars)
                if not context.other_card.ability.eternal then context.other_card:start_dissolve() end
                return {
                    message = localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

-- 408. Tornado
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_tornado',
    discovered = false,
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_elemental_tornado',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
        if (context.after or context.discard) and not context.blueprint then
             G.FUNCS.sort_hand_suit(nil)
        end
    end
})

-- 409. Volcano
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_volcano',
    discovered = false,
    config = { extra = { odds = 4, x_mult = 2 } },
    rarity = 1,
    atlas = 'j_elemental_volcano',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ).odds, ( (card and card.ability and card.ability.extra) or self.config.extra ).x_mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") then
                if pseudorandom('volcano') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    if not context.other_card.ability.eternal then context.other_card:start_dissolve() end
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end
        end
    end
})

-- 410. Iceberg
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_iceberg',
    discovered = false,
    config = { extra = { chips = 10, mult = 2 } },
    rarity = 1,
    atlas = 'j_elemental_iceberg',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).chips, (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Spades") then
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 411. Lightning
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_lightning',
    discovered = false,
    config = { extra = { mult = 30 } },
    rarity = 1,
    atlas = 'j_elemental_lightning',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local clubs = false
            local diamonds = false
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Clubs") then clubs = true end
                if context.scoring_hand[i]:is_suit("Diamonds") then diamonds = true end
            end
            if clubs and diamonds then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
                }
            end
        end
    end
})

-- 412. Magma
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_magma',
    discovered = false,
    config = { extra = { } },
    rarity = 1,
    atlas = 'j_elemental_magma',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.odyssey_magma_active = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.odyssey_magma_active = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 413. Mud
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_mud',
    discovered = false,
    config = { extra = { } },
    rarity = 1,
    atlas = 'j_elemental_mud',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.odyssey_mud_active = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.odyssey_mud_active = nil
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 414. Ember
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_ember',
    discovered = false,
    config = { extra = { mult = 5, gain = 1 } },
    rarity = 1,
    atlas = 'j_elemental_ember',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult, (( (card and card.ability and card.ability.extra) or self.config.extra )).gain } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
        if context.before and not context.blueprint then
            if context.scoring_name == "Flush" then
                local hearts = true
                for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Hearts") then hearts = false end end
                if hearts then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
})

-- 415. Dew
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_dew',
    discovered = false,
    config = { extra = { chips = 20, gain = 5 } },
    rarity = 1,
    atlas = 'j_elemental_dew',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).chips, (( (card and card.ability and card.ability.extra) or self.config.extra )).gain } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}}
            }
        end
        if context.before and not context.blueprint then
            if context.scoring_name == "Flush" then
                local spades = true
                for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Spades") then spades = false end end
                if spades then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.gain
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS
                    }
                end
            end
        end
    end
})

-- 416. Crystal
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_crystal',
    discovered = false,
    config = { extra = { x_mult = 1.5 } },
    rarity = 1,
    atlas = 'j_elemental_crystal',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local only_diamonds = true
            for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Diamonds") then only_diamonds = false end end
            if only_diamonds then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 417. Smoke
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_smoke',
    discovered = false,
    config = { extra = { odds = 3 } },
    rarity = 1,
    atlas = 'j_elemental_smoke',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, ( (card and card.ability and card.ability.extra) or self.config.extra ).odds } } end,
    calculate = function(self, card, context)
        if context.before and G.GAME.blind.boss and not G.GAME.blind.disabled then
            local clubs = false
            for i=1, #context.scoring_hand do if context.scoring_hand[i]:is_suit("Clubs") then clubs = true end end
            if clubs and pseudorandom('smoke') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.GAME.blind:disable()
                return {
                    message = localize('k_safe_ex'),
                    colour = G.C.FILTER,
                    card = card
                }
            end
        end
    end
})

-- 418. Spark
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_spark',
    discovered = false,
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_elemental_spark',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            local red = true
            for i=1, #context.scoring_hand do 
                if not (context.scoring_hand[i]:is_suit("Hearts") or context.scoring_hand[i]:is_suit("Diamonds")) then red = false end 
            end
            if red then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
                }
            end
        end
    end
})

-- 419. Wave
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_wave',
    discovered = false,
    config = { extra = { chips = 40 } },
    rarity = 1,
    atlas = 'j_elemental_wave',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).chips } } end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            local black = true
            for i=1, #context.scoring_hand do 
                if not (context.scoring_hand[i]:is_suit("Spades") or context.scoring_hand[i]:is_suit("Clubs")) then black = false end 
            end
            if black then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}}
                }
            end
        end
    end
})

-- 420. Ash
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_ash',
    discovered = false,
    config = { extra = { dollars = 3 } },
    rarity = 1,
    atlas = 'j_elemental_ash',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).dollars } } end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            local red_count = 0
            for i=1, #context.full_hand do
                if context.full_hand[i]:is_suit("Hearts") or context.full_hand[i]:is_suit("Diamonds") then
                    red_count = red_count + 1
                end
            end
            if red_count >= 5 then
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

