----------------------------------------------
-- SOCIAL & META (UNCOMMON) J821-J838
----------------------------------------------

-- J821 Fourth Wall
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_fourth_wall',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_social_fourth_wall',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.CONTROLLER.cursor_hovering == card then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- J822 Developer
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_developer',
    config = { extra = { chips = 50 } },
    rarity = 2,
    atlas = 'j_social_developer',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = "DEBUG: "..card.ability.extra.chips,
                colour = G.C.BLUE
            }
        end
    end
})

-- J823 Beta Tester
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_beta_tester',
    config = { extra = { chips = 40, mult = 10 } },
    rarity = 2,
    atlas = 'j_social_beta_tester',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips, extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('beta') < 0.5 then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = "BUG FOUND!",
                    colour = G.C.BLUE
                }
            else
                return {
                    mult_mod = card.ability.extra.mult,
                    message = "PATCHED!",
                    colour = G.C.RED
                }
            end
        end
    end
})

-- J824 Speedrunner
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_speedrunner',
    config = { extra = { mult = 30, limit = 120 } },
    rarity = 2,
    atlas = 'j_social_speedrunner',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult, extra.limit, G.GAME.round_resets.hands_played } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if (G.GAME.round_resets.hands_played or 0) < 3 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = "FAST!",
                    colour = G.C.ORANGE
                }
            end
        end
    end
})

-- J825 Completionist
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_completionist',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_social_completionist',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.GAME and G.GAME.hands then
            for k, v in pairs(G.GAME.hands) do
                if v.played > 0 then count = count + 1 end
            end
        end
        return { vars = { card.ability.extra.x_mult, count } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_played = true
            for k, v in pairs(G.GAME.hands) do
                if v.played == 0 and v.visible then all_played = false break end
            end
            if all_played then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J826 Lore Master
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_lore_master',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_social_lore_master',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "LORE!",
                colour = G.C.MULT
            }
        end
    end
})

-- J827 Min-Maxer
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_min_maxer',
    config = { extra = { x_mult = 3, limit = 40 } },
    rarity = 2,
    atlas = 'j_social_min_maxer',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult, extra.limit } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.deck.cards < card.ability.extra.limit then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- J828 Casual
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_casual',
    config = { extra = { mult = 15 } },
    rarity = 2,
    atlas = 'j_social_casual',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if (G.GAME.round_resets.hands_played or 0) > 5 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = "RELAX...",
                    colour = G.C.GREEN
                }
            end
        end
    end
})

-- J829 Tryhard
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_tryhard',
    config = { extra = { mult = 30 } },
    rarity = 2,
    atlas = 'j_social_tryhard',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.shake = G.shake + 1
                    return true
                end
            }))
            return {
                mult_mod = card.ability.extra.mult,
                message = "TRYHARD!",
                colour = G.C.RED
            }
        end
    end
})

-- J830 Rage Quit
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_rage_quit',
    config = { extra = { active = true } },
    rarity = 2,
    atlas = 'j_social_rage_quit',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            G.GAME.odyssey_rage_quit_active = true
        end
    end
})

-- J831 Save Scummer
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_save_scummer',
    config = { extra = { uses = 1 } },
    rarity = 2,
    atlas = 'j_social_save_scummer',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
             G.GAME.chips = 0
             G.GAME.hands_played = 0
             G.GAME.discards_used = 0
             card_eval_status_text(card, 'extra', nil, nil, nil, {message = "SAVE LOADED", colour = G.C.BLUE})
        end
    end
})

-- J832 Modder
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_modder',
    config = { extra = { mult = 10 } },
    rarity = 2,
    atlas = 'j_social_modder',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

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

-- J833 Pirate
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_pirate',
    config = { extra = { x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_social_pirate',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = "PIRACY!",
                colour = G.C.BLACK
            }
        end
    end
})

-- J834 DRM
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_drm',
    config = { extra = { mult = 40 } },
    rarity = 2,
    atlas = 'j_social_drm',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "DRM PROTECTED",
                colour = G.C.MULT
            }
        end
    end
})

-- J835 Microtransaction
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_microtransaction',
    config = { extra = { mult = 5, cost = 1 } },
    rarity = 2,
    atlas = 'j_social_microtransaction',
    pos = { x = 0, y = 0 },
    cost = 1,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult, extra.cost } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.dollars >= card.ability.extra.cost then
             ease_dollars(-card.ability.extra.cost)
             return {
                 mult_mod = card.ability.extra.mult,
                 message = "-$1 MULT!",
                 colour = G.C.MONEY
             }
        end
    end
})

-- J836 DLC
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_dlc',
    config = { extra = { chips = 20 } },
    rarity = 2,
    atlas = 'j_social_dlc',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = "DLC ACTIVE",
                colour = G.C.CHIPS
            }
        end
    end
})

-- J837 Patch Notes
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_patch_notes',
    config = { extra = { mult = 10 } },
    rarity = 2,
    atlas = 'j_social_patch_notes',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = card and card.ability.extra or self.config.extra

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "v1.0."..G.GAME.round_resets.ante,
                colour = G.C.MULT
            }
        end
    end
})

-- J838 Easter Egg
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_social_easter_egg',
    config = { extra = { clicks = 0, req = 10, dollars = 10 } },
    rarity = 2,
    atlas = 'j_social_easter_egg',
    pos = { x = 0, y = 0 },
    cost = 1,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.joker_main then
             card.ability.extra.clicks = card.ability.extra.clicks + 1
             if card.ability.extra.clicks >= card.ability.extra.req then
                ease_dollars(card.ability.extra.dollars)
                card.ability.extra.clicks = 0
                return {
                    message = "EASTER EGG! "..localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
             end
        end
    end
})
