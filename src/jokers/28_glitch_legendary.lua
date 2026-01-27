local local_jokers = {
    {
        key = 'j_glitch_the_architect',
        rarity = 4,
        cost = 20,
        atlas = 'j_glitch_the_architect',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 2 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = (card and card.ability.extra or self.config.extra)

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
        end,
        update = function(self, card, dt)
            if G.GAME and G.GAME.current_round then
                G.GAME.current_round.reroll_cost = 0
            end
        end
    },
    {
        key = 'j_glitch_digital_singularity',
        rarity = 4,
        cost = 20,
        atlas = 'j_glitch_digital_singularity',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 5, gain = 1 } },
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            local count = 0
            if G.jokers then
                for k, v in ipairs(G.jokers.cards) do
                    if v ~= card and v.config.center.key and string.find(v.config.center.key, 'j_glitch_') then
                        count = count + 1
                    end
                end
            end
            return { vars = { card.ability.extra.x_mult, card.ability.extra.gain, card.ability.extra.x_mult + (count * card.ability.extra.gain) } }
        end,
        calculate = function(self, card, context)
            if context.joker_main then
                local count = 0
                for k, v in ipairs(G.jokers.cards) do
                    if v ~= card and v.config.center.key and string.find(v.config.center.key, 'j_glitch_') then
                        count = count + 1
                    end
                end
                local total_xmult = card.ability.extra.x_mult + (count * card.ability.extra.gain)
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { total_xmult } },
                    Xmult_mod = total_xmult,
                    colour = G.C.MULT
                }
            end
        end
    }
}

for _, joker in ipairs(local_jokers) do
    joker.unlocked = true
    joker.discovered = true
    SMODS.Joker(joker)
end
