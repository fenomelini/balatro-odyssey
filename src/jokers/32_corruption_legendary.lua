local local_jokers = {
    {
        key = 'j_corruption_world_eater',
        rarity = 4,
        cost = 20,
        atlas = 'j_corruption_world_eater',
        pos = { x = 0, y = 0 },
        config = { extra = { x_mult = 1, gain = 0.5 } },
        blueprint_compat = false,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, extra.gain } }

        end,
        calculate = function(self, card, context)
            if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
                local destroyed_count = 0
                if G.playing_cards then
                    for k, v in pairs(G.playing_cards) do
                        if not v.ability.eternal then
                            v:start_dissolve(nil, true)
                            destroyed_count = destroyed_count + 1
                        end
                    end
                end
                
                if destroyed_count > 0 then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + (destroyed_count * card.ability.extra.gain)
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.RED
                    }
                end
            end
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    x_mult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    },
    {
        key = 'j_corruption_the_entity',
        rarity = 4,
        cost = 20,
        atlas = 'j_corruption_the_entity',
        pos = { x = 0, y = 0 },
        config = { extra = {} },
        blueprint_compat = false,
        eternal_compat = true,
        calculate = function(self, card, context)
            if context.blueprint then return end
            
            local ret = {}
            local triggered = false
            
            if G.jokers then
                for k, v in pairs(G.jokers.cards) do
                    if v ~= card and v.edition and v.edition.negative then
                        context.blueprint = true
                        context.blueprint_card = card
                        if v.ability.blueprint_compat then
                            local other_joker_ret = v:calculate_joker(context)
                            if other_joker_ret then
                                triggered = true
                                if other_joker_ret.mult_mod then
                                    ret.mult_mod = (ret.mult_mod or 0) + other_joker_ret.mult_mod
                                end
                                if other_joker_ret.chip_mod then
                                    ret.chip_mod = (ret.chip_mod or 0) + other_joker_ret.chip_mod
                                end
                                if other_joker_ret.x_mult_mod then
                                    ret.x_mult_mod = (ret.x_mult_mod or 1) * other_joker_ret.x_mult_mod
                                end
                                if other_joker_ret.message then
                                    ret.message = other_joker_ret.message
                                end
                                if other_joker_ret.colour then
                                    ret.colour = other_joker_ret.colour
                                end
                            end
                        end
                        context.blueprint = false
                        context.blueprint_card = nil
                    end
                end
            end
            
            if triggered then
                return ret
            end
        end
    }
}

for _, joker in ipairs(local_jokers) do
    joker.unlocked = true
    joker.discovered = true
    SMODS.Joker(joker)
end
