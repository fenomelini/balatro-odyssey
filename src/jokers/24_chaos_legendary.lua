-- 239. Azathoth
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_azathoth',
    config = { extra = { x_mult = 10 } },
    rarity = 4,
    atlas = 'j_chaos_azathoth',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card then
            if G.playing_cards and #G.playing_cards > 0 then
                local target = G.playing_cards[pseudorandom('j_chaos_azathoth', 1, #G.playing_cards)]
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        target:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 240. Crawling Chaos
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_crawling_chaos',
    config = { extra = { x_mult = 2, gain = 0.5 } },
    rarity = 4,
    atlas = 'j_chaos_crawling_chaos',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult, extra.gain } }

    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})