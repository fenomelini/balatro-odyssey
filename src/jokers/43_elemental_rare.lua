-- ============================================
-- ELEMENTAL - Rare (Jokers 439-448)
-- ============================================

-- 439. Phoenix
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_phoenix',
    discovered = true,
    config = { extra = { mult = 0, gain = 1 } },
    rarity = 3,
    atlas = 'j_elemental_phoenix',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult, ((card and card.ability.extra or self.config.extra)).gain } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}}
            }
        end
        if context.discard and not context.blueprint then
             local hearts = 0
             for i=1, #context.full_hand do if context.full_hand[i]:is_suit("Hearts") then hearts = hearts + 1 end end
             if hearts >= 5 then
                 card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                 return {
                     message = localize('k_upgrade_ex'),
                     colour = G.C.MULT
                 }
             end
        end
    end
})

-- 440. Leviathan
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_leviathan',
    discovered = true,
    config = { extra = { hands = 1 } },
    rarity = 3,
    atlas = 'j_elemental_leviathan',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Flush" then
            local spades = 0
            for i=1, #context.scoring_hand do if context.scoring_hand[i]:is_suit("Spades") then spades = spades + 1 end end
            if spades >= 5 then
                ease_hands_played(card.ability.extra.hands)
                return {
                    message = "+"..card.ability.extra.hands.." Hand",
                    colour = G.C.BLUE
                }
            end
        end
    end
})

-- 441. Behemoth
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_behemoth',
    discovered = true,
    config = { extra = { slots = 1 } },
    rarity = 3,
    atlas = 'j_elemental_behemoth',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Flush" then
            local diamonds = 0
            for i=1, #context.scoring_hand do if context.scoring_hand[i]:is_suit("Diamonds") then diamonds = diamonds + 1 end end
            if diamonds >= 5 and not context.blueprint then
                G.GAME.modifiers.odyssey_behemoth_slots = (G.GAME.modifiers.odyssey_behemoth_slots or 0) + card.ability.extra.slots
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
                return {
                    message = "+1 Slot!",
                    colour = G.C.JOKER_GREY,
                    card = card
                }
            end
        end
        if context.end_of_round and not context.other_card and not context.blueprint then
            if G.GAME.modifiers.odyssey_behemoth_slots and G.GAME.modifiers.odyssey_behemoth_slots > 0 then
                G.jokers.config.card_limit = G.jokers.config.card_limit - G.GAME.modifiers.odyssey_behemoth_slots
                G.GAME.modifiers.odyssey_behemoth_slots = 0
            end
        end
    end
})

-- 442. Ziz
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_ziz',
    discovered = true,
    config = { extra = { discards = 1, dollars = 5 } },
    rarity = 3,
    atlas = 'j_elemental_ziz',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Flush" then
            local clubs = 0
            for i=1, #context.scoring_hand do if context.scoring_hand[i]:is_suit("Clubs") then clubs = clubs + 1 end end
            if clubs >= 5 then
                ease_discard(card.ability.extra.discards)
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = "+1 Discard / $5",
                    colour = G.C.GREEN
                }
            end
        end
    end
})

-- 443. Fifth Element
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_fifth_element',
    discovered = true,
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    atlas = 'j_elemental_fifth_element',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local elements = { fire=false, water=false, earth=false, air=false }
            for i = 1, #G.jokers.cards do
                local j = G.jokers.cards[i]
                if j.config.center.key == 'j_elemental_fire_spirit' or j.config.center.key == 'odyssey_j_elemental_fire_spirit' then elements.fire = true end
                if j.config.center.key == 'j_elemental_water_spirit' or j.config.center.key == 'odyssey_j_elemental_water_spirit' then elements.water = true end
                if j.config.center.key == 'j_elemental_earth_spirit' or j.config.center.key == 'odyssey_j_elemental_earth_spirit' then elements.earth = true end
                if j.config.center.key == 'j_elemental_air_spirit' or j.config.center.key == 'odyssey_j_elemental_air_spirit' then elements.air = true end
            end
            local count = 0
            for _, v in pairs(elements) do if v then count = count + 1 end end
            if count >= 4 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
                }
            end
        end
    end
})

-- 444. Master Alchemist
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_master_alchemist',
    discovered = true,
    config = { extra = {} },
    rarity = 3,
    atlas = 'j_elemental_master_alchemist',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss and not context.blueprint then
            for i=1, #G.hand.cards do
                local c = G.hand.cards[i]
                local new_base = 'D_' .. (c.base.value == '10' and 'T' or string.sub(c.base.value, 1, 1))
                if c.base.value == 'Ace' then new_base = 'D_A' end
                if c.base.value == 'Jack' then new_base = 'D_J' end
                if c.base.value == 'Queen' then new_base = 'D_Q' end
                if c.base.value == 'King' then new_base = 'D_K' end
                -- Safe way:
                local rank = c.base.value
                local suit = 'Diamonds'
                c:set_base(G.P_CARDS[suit .. '_' .. rank])
            end
            return {
                message = "Golden Hand!",
                colour = G.C.MONEY
            }
        end
    end
})

-- 445. Heart of the World
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_heart_of_the_world',
    discovered = true,
    config = { extra = { x_mult = 3, odyssey_suit_immune = true } },
    rarity = 3,
    atlas = 'j_elemental_heart_of_the_world',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
            }
        end
        if context.setting_blind then
            G.GAME.modifiers.odyssey_suit_immune = true
        end
    end
})

-- 446. Neutron Star
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_neutron_star',
    discovered = true,
    config = { extra = { mult = 20 } },
    rarity = 3,
    atlas = 'j_elemental_neutron_star',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).mult } } end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local c = context.other_card
            if c.config.center == G.P_CENTERS.m_odyssey_platinum or c.config.center == G.P_CENTERS.m_odyssey_plastic or c.config.center == G.P_CENTERS.m_odyssey_emerald then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 447. Superconductor
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_superconductor',
    discovered = true,
    config = { extra = {} },
    rarity = 3,
    atlas = 'j_elemental_superconductor',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.config.center == G.P_CENTERS.m_odyssey_plastic then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- 448. Absolute Zero
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_absolute_zero',
    discovered = true,
    config = { extra = { x_mult = 10, next_hand_active = false } },
    rarity = 3,
    atlas = 'j_elemental_absolute_zero',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { ((card and card.ability.extra or self.config.extra)).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.next_hand_active then
            card.ability.extra.next_hand_active = false
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
            }
        end
        if context.after and not context.blueprint then
            if G.GAME.chips - G.GAME.chips_at_start_of_hand == 0 then
                card.ability.extra.next_hand_active = true
            end
        end
    end
})
