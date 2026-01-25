----------------------------------------------
-- SOCIAL & META (RARE) J839-J848
----------------------------------------------

-- J839 Game Master
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_game_master',
    config = { extra = { used = false } },
    rarity = 3,
    atlas = 'j_social_game_master',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and G.GAME.blind.boss then
            G.GAME.blind:set_blind(nil, true, nil)
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "REGRAS ALTERADAS", colour = G.C.PURPLE})
        end
    end
})

-- J840 Admin
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_admin',
    config = {},
    rarity = 3,
    atlas = 'j_social_admin',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            ease_dollars(20)
            local tag = Tag('tag_double')
            add_tag(tag)
            add_tag(Tag('tag_double'))
            -- Simplified: $20 and 2 Double Tags
        end
    end
})

-- J841 God Mode
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_god_mode',
    config = { extra = { rounds = 1 } },
    rarity = 3,
    atlas = 'j_social_god_mode',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.GAME.odyssey_god_mode = true
        end
        if context.end_of_round and not context.repetition and not context.other_card then
            G.GAME.odyssey_god_mode = false
        end
    end
})

-- J842 Noclip
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_noclip',
    config = { extra = { x_mult = 2 } },
    rarity = 3,
    atlas = 'j_social_noclip',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = "NOCLIP",
                colour = G.C.PURPLE
            }
        end
        if context.setting_blind then
            G.GAME.odyssey_noclip = true
        end
    end
})

-- J843 Infinite Ammo
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_infinite_ammo',
    config = { extra = { discards = 5 } },
    rarity = 3,
    atlas = 'j_social_infinite_ammo',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.discards } }

    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            ease_discard(card.ability.extra.discards)
        end
    end
})

-- J844 Aimbot
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_aimbot',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_social_aimbot',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             local count = 0
             local suit = nil
             for i=1, #context.scoring_hand do
                if not suit then suit = context.scoring_hand[i].base.suit end
                if context.scoring_hand[i]:is_suit(suit) then count = count + 1 end
             end
             if count >= 4 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = "HEADSHOT!",
                    colour = G.C.RED
                }
             end
        end
    end
})

-- J845 Wallhack
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_wallhack',
    config = { extra = { chips = 150 } },
    rarity = 3,
    atlas = 'j_social_wallhack',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local next_cards = "???, ???, ???"
        if G.deck and G.deck.cards then
            next_cards = ""
            for i=1, 3 do
                local c = G.deck.cards[#G.deck.cards - i + 1]
                if c then
                    next_cards = next_cards .. (i > 1 and ", " or "") .. localize(c.base.value, 'ranks') .. " " .. localize(c.base.suit, 'suits_plural')
                end
            end
        end
        return { vars = { card.ability.extra.chips, next_cards } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- J846 Lag Switch
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_lag_switch',
    config = { extra = { chips = 100, x_mult = 1.5 } },
    rarity = 3,
    atlas = 'j_social_lag_switch',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips, extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                x_mult = card.ability.extra.x_mult,
                message = "LAGGING...",
                colour = G.C.CHIPS
            }
        end
    end
})

-- J847 Ban Hammer
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_ban_hammer',
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    atlas = 'j_social_ban_hammer',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i=1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i break end
            end
            if my_pos and G.jokers.cards[my_pos + 1] then
                local target = G.jokers.cards[my_pos + 1]
                if not target.ability.eternal then
                    target:start_dissolve()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "BANNED!", colour = G.C.RED})
                    return {
                        x_mult = card.ability.extra.x_mult,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                    }
                end
            end
        end
    end
})

-- J848 Credits
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_credits',
    config = { extra = { x_mult = 1 } },
    rarity = 3,
    atlas = 'j_social_credits',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult + (G.GAME.round_resets.ante or 0) } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local bonus = G.GAME.round_resets.ante or 0
            return {
                x_mult = card.ability.extra.x_mult + bonus,
                message = "THANKS FOR PLAYING!",
                colour = G.C.GOLD
            }
        end
        if context.selling_self and G.GAME.round_resets.ante >= 8 then
            -- Win game logic (hard to trigger directly, maybe just massive money)
            ease_dollars(100)
        end
    end
})
