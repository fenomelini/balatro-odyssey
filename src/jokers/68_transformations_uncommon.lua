----------------------------------------------
-- TRANSFORMATIONS (UNCOMMON) J771-J788
----------------------------------------------

-- J771 Vampire (Steamodded already has a Vampire, but we add our own or override)
-- We use a prefix to avoid conflict
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_vampire',
    config = { extra = { x_mult = 1, x_mult_mod = 0.2 } },
    rarity = 2,
    atlas = 'j_transformations_vampire',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult, extra.x_mult_mod } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.x_mult > 1 then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
        if context.before and not context.blueprint then
            local enhanced_found = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.config.center ~= G.P_CENTERS.c_base then
                    v:set_ability(G.P_CENTERS.c_base)
                    enhanced_found = enhanced_found + 1
                end
            end
            if enhanced_found > 0 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + (enhanced_found * card.ability.extra.x_mult_mod)
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- J772 Werewolf
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_werewolf',
    config = { extra = { chips = 50 } },
    rarity = 2,
    atlas = 'j_transformations_werewolf',
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
})

-- J773 Frankenstein
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_frankenstein',
    config = {},
    rarity = 2,
    atlas = 'j_transformations_frankenstein',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.discard and not context.other_card and not context.blueprint then
            -- We wait for the discard to finish
            if #context.full_hand >= 2 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Suit', G.hand, nil, nil, nil, nil, nil, 'frank')
                        new_card:add_to_deck()
                        G.hand:emplace(new_card)
                        return true
                    end
                }))
                return {
                    message = "It's Alive!",
                    colour = G.C.GREEN
                }
            end
        end
    end
})

-- J774 Zombie
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_zombie',
    config = { extra = { odds = 4 } },
    rarity = 2,
    atlas = 'j_transformations_zombie',
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { G.GAME.probabilities.normal or 1, extra.odds } }

    end,
    calculate = function(self, card, context)
        if context.discard and not context.other_card and not context.blueprint then
            if pseudorandom('zombie') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local discarded_card = context.other_card
                -- This is tricky because we are in the middle of a discard
                -- Let's just create a random card in hand as a "returned" one
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Suit', G.hand, nil, nil, nil, nil, nil, 'zombie')
                        new_card:add_to_deck()
                        G.hand:emplace(new_card)
                        return true
                    end
                }))
                return {
                    message = "Undead!",
                    colour = G.C.RED
                }
            end
        end
    end
})

-- J775 Phantom of the Opera
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_phantom_of_the_opera',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_transformations_phantom_of_the_opera',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            local faces = 0
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() then faces = faces + 1 end
            end
            if faces == 1 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J776 Jekyll & Hyde
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_jekyll_hyde',
    config = { extra = { active = false, x_mult_a = 0.5, x_mult_b = 4 } },
    rarity = 2,
    atlas = 'j_transformations_jekyll_hyde',
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local current_x = ( (card and card.ability and card.ability.extra) or self.config.extra ).active and ( (card and card.ability and card.ability.extra) or self.config.extra ).x_mult_b or ( (card and card.ability and card.ability.extra) or self.config.extra ).x_mult_a
        return { vars = { current_x } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local val = card.ability.extra.active and card.ability.extra.x_mult_b or card.ability.extra.x_mult_a
            return {
                x_mult = val,
                message = localize { type = 'variable', key = 'a_xmult', vars = { val } }
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.active = not card.ability.extra.active
        end
    end
})

-- J777 Mutant
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_mutant',
    config = { extra = { mult = 10 } },
    rarity = 2,
    atlas = 'j_transformations_mutant',
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J778 Hybrid
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_hybrid',
    config = {},
    rarity = 2,
    atlas = 'j_transformations_hybrid',
    pos = { x = 0, y = 0 },
    cost = 7,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J779 Chimera
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_chimera',
    config = { extra = { mult = 10, chips = 50, money = 1, x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_transformations_chimera',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                if context.other_card:is_suit('Hearts') then
                    return { mult = card.ability.extra.mult, card = card }
                elseif context.other_card:is_suit('Spades') then
                    return { chips = card.ability.extra.chips, card = card }
                elseif context.other_card:is_suit('Diamonds') then
                    return { dollars = card.ability.extra.money, card = card }
                elseif context.other_card:is_suit('Clubs') then
                    return { x_mult = card.ability.extra.x_mult, card = card }
                end
            end
        end
    end
})

-- J780 Hydra
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_hydra',
    config = {},
    rarity = 2,
    atlas = 'j_transformations_hydra',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.FUNCS.draw_from_deck_to_hand(2)
                    return true
                end
            }))
        end
    end
})

-- J781 Dark Phoenix
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_dark_phoenix',
    config = {},
    rarity = 2,
    atlas = 'j_transformations_dark_phoenix',
    pos = { x = 0, y = 0 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_odyssey_platinum
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        v:start_dissolve()
                        local new_card = create_card('Suit', G.deck, nil, nil, nil, nil, nil, 'dark_phoenix')
                        new_card:set_ability(G.P_CENTERS.m_odyssey_platinum)
                        new_card:add_to_deck()
                        G.deck:emplace(new_card)
                        return true
                    end
                }))
            end
            return {
                message = "Reborn!",
                colour = G.C.RED
            }
        end
    end
})

-- J782 Basilisk
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_basilisk',
    config = {},
    rarity = 2,
    atlas = 'j_transformations_basilisk',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS.m_odyssey_emerald)
            end
        end
    end
})

-- J783 Medusa
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_medusa',
    config = { extra = { mult = 50 } },
    rarity = 2,
    atlas = 'j_transformations_medusa',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() and not (v.config.center == G.P_CENTERS.m_odyssey_emerald) then
                    v:set_ability(G.P_CENTERS.m_odyssey_emerald)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
        end
    end
})

-- J784 Siren
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_siren',
    config = {},
    rarity = 2,
    atlas = 'j_transformations_siren',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            -- This is hard to implement with just calculate hooks without more complex logic
            -- Better to make it give a bonus to a specific suit that changes?
            -- Let's stick to a simpler interpretation for now:
            -- Better draw power?
        end
        if context.joker_main then
            -- Let's give it +10 chips for every card of the same suit as the first card in hand
            local first_card = G.hand.cards[1]
            if first_card then
                local first_suit = first_card.base.suit
                local count = 0
                for k, v in ipairs(context.scoring_hand) do
                    if v.base.suit == first_suit then
                        count = count + 1
                    end
                end
                if count > 0 then
                    return {
                        chips = count * 20,
                        message = localize { type = 'variable', key = 'a_chips', vars = { count * 20 } }
                    }
                end
            end
        end
    end
})

-- J785 Griffin
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_griffin',
    config = { extra = { chips = 0, chip_gain = 10 } },
    rarity = 2,
    atlas = 'j_transformations_griffin',
    pos = { x = 0, y = 0 },
    cost = 7,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips, extra.chip_gain } }

    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == 'Pair' or context.scoring_name == 'Two Pair' or context.scoring_name == 'Three of a Kind' or context.scoring_name == 'Full House' or context.scoring_name == 'Four of a Kind' or context.scoring_name == 'Five of a Kind' then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- J786 Dragon
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_dragon',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_transformations_dragon',
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
            local flush = true
            local gold = false
            local first_suit = context.scoring_hand[1].base.suit
            for k, v in ipairs(context.scoring_hand) do
                if v.base.suit ~= first_suit then flush = false end
                if v.ability.name == 'Gold Card' then gold = true end
            end
            if flush and gold then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J787 Unicorn
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_unicorn',
    config = { extra = { x_mult = 2.5 } },
    rarity = 2,
    atlas = 'j_transformations_unicorn',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            for k, v in ipairs(context.scoring_hand) do
                suits[v.base.suit] = true
            end
            local count = 0
            for _ in pairs(suits) do count = count + 1 end
            if count >= 4 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J788 Centaur
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_centaur',
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_transformations_centaur',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            local face = false
            local common = false
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() then face = true end
                if not v:is_face() and v.base.value ~= 'Ace' then common = true end
            end
            if face and common then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})
