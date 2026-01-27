-- local commons = require('src/jokers/33_paradox_common')

-- 359. Ouroboros
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_ouroboros',
    discovered = true,
    atlas = 'j_paradox_ouroboros',
    config = { extra = { x_mult = 3 } },
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult
            }
        end
        
        if context.end_of_round and not context.repetition and not context.blueprint and not context.other_card then
            if G.GAME.round_resets.ante >= 8 and G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.GAME.chips >= G.GAME.blind.chips then
                             -- Reset Ante to 1
                             G.GAME.round_resets.ante = 0 -- Becomes 1
                             G.GAME.round_resets.ante_scaling = (G.GAME.round_resets.ante_scaling or 1) * 1.5
                             play_sound('gold_seal', 1.2, 0.4)
                        end
                        return true
                    end
                }))
            end
        end
    end
})

-- 360. Grandfather Paradox
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_grandfather_paradox',
    discovered = true,
    atlas = 'j_paradox_grandfather_paradox',
    rarity = 4,
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.blueprint and not context.other_card then
            if G.GAME.chips < G.GAME.blind.chips then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('timpani')
                        return true
                    end
                })) 
                if not card.ability.eternal then card:start_dissolve() end
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED
                }
            end
        end
    end
})
