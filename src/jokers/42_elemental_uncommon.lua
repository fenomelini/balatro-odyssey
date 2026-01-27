-- ============================================
-- ELEMENTAL - Uncommon (Jokers 421-438)
-- ============================================

-- 421. Fire Spirit
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_fire_spirit',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_elemental_fire_spirit',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Flush" then
            local hearts = true
            for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Hearts") then hearts = false end end
            if hearts then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 422. Water Spirit
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_water_spirit',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_elemental_water_spirit',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Flush" then
            local spades = true
            for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Spades") then spades = false end end
            if spades then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 423. Earth Spirit
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_earth_spirit',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_elemental_earth_spirit',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Flush" then
            local diamonds = true
            for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Diamonds") then diamonds = false end end
            if diamonds then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 424. Air Spirit
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_air_spirit',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_elemental_air_spirit',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == "Flush" then
            local clubs = true
            for i=1, #context.scoring_hand do if not context.scoring_hand[i]:is_suit("Clubs") then clubs = false end end
            if clubs then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 425. Elemental Fusion
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_elemental_fusion',
    discovered = true,
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_elemental_elemental_fusion',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {Hearts=false, Spades=false, Diamonds=false, Clubs=false}
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then suits.Hearts = true end
                if context.scoring_hand[i]:is_suit("Spades") then suits.Spades = true end
                if context.scoring_hand[i]:is_suit("Diamonds") then suits.Diamonds = true end
                if context.scoring_hand[i]:is_suit("Clubs") then suits.Clubs = true end
            end
            local count = 0
            for _, v in pairs(suits) do if v then count = count + 1 end end
            if count >= 4 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 426. Steam
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_steam',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_elemental_steam',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local hearts = false
            local spades = false
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then hearts = true end
                if context.scoring_hand[i]:is_suit("Spades") then spades = true end
            end
            if hearts and spades then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
                }
            end
        end
    end
})

-- 427. Lava
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_lava',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_elemental_lava',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local hearts = false
            local diamonds = false
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Hearts") then hearts = true end
                if context.scoring_hand[i]:is_suit("Diamonds") then diamonds = true end
            end
            if hearts and diamonds then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
                }
            end
        end
    end
})

-- 428. Sandstorm
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_sandstorm',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_elemental_sandstorm',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local diamonds = false
            local clubs = false
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Diamonds") then diamonds = true end
                if context.scoring_hand[i]:is_suit("Clubs") then clubs = true end
            end
            if diamonds and clubs then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
                }
            end
        end
    end
})

-- 429. Storm
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_storm',
    discovered = true,
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_elemental_storm',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local spades = false
            local clubs = false
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i]:is_suit("Spades") then spades = true end
                if context.scoring_hand[i]:is_suit("Clubs") then clubs = true end
            end
            if spades and clubs then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
                }
            end
        end
    end
})

-- 430. Element Master
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_element_master',
    discovered = true,
    config = { extra = { mult = 10 } },
    rarity = 2,
    atlas = 'j_elemental_element_master',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            for k, v in ipairs(G.playing_cards) do suits[v.base.suit] = true end
            local count = 0
            for _ in pairs(suits) do count = count + 1 end
            return {
                mult_mod = count * card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={count * card.ability.extra.mult}}
            }
        end
    end
})

-- 431. Prism
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_prism',
    discovered = true,
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_elemental_prism',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition and context.other_card.edition.polychrome then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})

-- 432. Aether
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_aether',
    discovered = true,
    config = { extra = { mult = 50 } },
    rarity = 2,
    atlas = 'j_elemental_aether',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_emerald then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 433. Plasma
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_plasma',
    discovered = true,
    config = { extra = { x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_elemental_plasma',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Spades") then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})

-- 434. Geode
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_geode',
    discovered = true,
    config = { extra = { odds = 3, dollars = 5, mult = 20 } },
    rarity = 2,
    atlas = 'j_elemental_geode',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { G.GAME.probabilities.normal, (card and card.ability.extra or self.config.extra).odds, (card and card.ability.extra or self.config.extra).dollars, (card and card.ability.extra or self.config.extra).mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_emerald then
                if pseudorandom('geode') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    if pseudorandom('geode_type') < 0.5 then
                        ease_dollars(card.ability.extra.dollars)
                        return {
                            message = localize('$')..card.ability.extra.dollars,
                            colour = G.C.MONEY,
                            card = card
                        }
                    else
                        return {
                            mult = card.ability.extra.mult,
                            card = card
                        }
                    end
                end
            end
        end
    end
})

-- 435. Thunderbolt
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_thunderbolt',
    discovered = true,
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_elemental_thunderbolt',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Straight Flush" then
            if #context.scoring_hand >= 3 then
                local middle = math.ceil(#context.scoring_hand / 2)
                local target = context.scoring_hand[middle]
                if not target.ability.eternal then
                    target:start_dissolve()
                end
            end
        end
        if context.joker_main and context.scoring_name == "Straight Flush" then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}},
                card = card
            }
        end
    end
})

-- 436. Blizzard
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_blizzard',
    discovered = true,
    config = { extra = {} },
    rarity = 2,
    atlas = 'j_elemental_blizzard',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local spades = 0
            for i=1, #context.scoring_hand do if context.scoring_hand[i]:is_suit("Spades") then spades = spades + 1 end end
            if spades >= 5 then
                G.GAME.modifiers.odyssey_blizzard_frozen = true
                return {
                    message = "Frozen!",
                    colour = G.C.FILTER,
                    card = card
                }
            end
        end
    end
})

-- 437. Fire Meteor
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_fire_meteor',
    discovered = true,
    config = { extra = { chips = 100, mult = 10 } },
    rarity = 2,
    atlas = 'j_elemental_fire_meteor',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).chips, ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local hearts_in_hand = 0
            for i=1, #G.hand.cards do if G.hand.cards[i]:is_suit("Hearts") then hearts_in_hand = hearts_in_hand + 1 end end
            local bonus_mult = hearts_in_hand * card.ability.extra.mult
            return {
                chip_mod = card.ability.extra.chips,
                mult_mod = bonus_mult,
                message = localize{type='variable', key='a_mult', vars={bonus_mult}}
            }
        end
    end
})

-- 438. Garden
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_garden',
    discovered = true,
    config = { extra = { bonus = 1 } },
    rarity = 2,
    atlas = 'j_elemental_garden',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).bonus } } end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.other_card and not context.blueprint then
            for i=1, #G.hand.cards do
                if G.hand.cards[i]:is_suit("Diamonds") then
                    local c = G.hand.cards[i]
                    c.ability.perma_bonus = (c.ability.perma_bonus or 0) + card.ability.extra.bonus
                    c:juice_up()
                end
            end
            return {
                message = "Grown!",
                colour = G.C.CHIPS
            }
        end
    end
})
