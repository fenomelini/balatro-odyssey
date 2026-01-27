-- 231. Agent of Chaos
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_agent_of_chaos',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_chaos_agent_of_chaos',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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
        if context.before and not context.blueprint then
            if #G.hand.cards > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local victim = pseudorandom_element(G.hand.cards, pseudorandom('j_chaos_agent'))
                        G.hand:add_to_highlighted(victim)
                        return true
                    end
                }))
            end
        end
    end
})

-- 232. Improbability Drive
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_improbability_drive',
    config = { extra = { odds = 100, dollars = 100 } },
    rarity = 3,
    atlas = 'j_chaos_improbability_drive',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { G.GAME.probabilities.normal, extra.odds } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('j_chaos_improbability_drive') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                G.E_MANAGER:add_event(Event({func = function() G.GAME.dollars = G.GAME.dollars + card.ability.extra.dollars; G.GAME.dollar_buffer = G.GAME.dollar_buffer - card.ability.extra.dollars; return true end}))
                return {
                    message = localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 233. Chance Nexus
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_chance_nexus',
    loc_txt = {
        name = "Chance Nexus",
        text = {
            "Increases probabilities list in",
            "other Jokers by {C:attention}25%{}",
            "{C:inactive}(e.g. 1 in 4 becomes 1 in 3){}"
        }
    },
    config = { extra = { percentage = 1.25 } },
    rarity = 3,
    atlas = 'j_chaos_chance_nexus',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    -- Implementing this by multiplying G.GAME.probabilities.normal
    add_to_deck = function(self, card, from_debuff)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.percentage
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.percentage
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 234. Primal Form
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_primal_form',
    config = {},
    rarity = 3,
    atlas = 'j_chaos_primal_form',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i = 1, #G.hand.cards do
                local c = G.hand.cards[i]
                c:set_base(G.P_CARDS[c.base.suit..'_A'])
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    if not card.ability.eternal then card:start_dissolve() end
                    return true
                end
            }))
            return {
                message = localize('k_primal'),
                colour = G.C.FILTER
            }
        end
    end
})

-- 235. Maximum Entropy
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_maximum_entropy',
    config = { extra = { x_mult = 4 } },
    rarity = 3,
    atlas = 'j_chaos_maximum_entropy',
    pos = { x = 0, y = 0 },
    cost = 9,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
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
        if context.end_of_round and not context.repetition and not context.other_card then
            local victim = pseudorandom_element(G.jokers.cards, pseudorandom('maximum_entropy'))
            if victim then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        victim:start_dissolve()
                        return true
                    end
                }))
            end
        end
    end
})

-- 236. Heart of Chaos
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_heart_of_chaos',
    config = { extra = { copy_target = nil } },
    rarity = 3,
    atlas = 'j_chaos_heart_of_chaos',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local right_jokers = {}
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i end
            end
            if my_pos then
                for i = my_pos + 1, #G.jokers.cards do
                    right_jokers[#right_jokers+1] = G.jokers.cards[i]
                end
            end
            if #right_jokers > 0 then
                card.ability.extra.copy_target = pseudorandom_element(right_jokers, pseudorandom('j_chaos_heart'))
            else
                card.ability.extra.copy_target = nil
            end
        end
        
        if card.ability.extra.copy_target then
            local other_joker = card.ability.extra.copy_target
            context.blueprint = true
            local ret = other_joker:calculate_joker(context)
            if ret then
                ret.card = card
                return ret
            end
        end
    end
})

-- 237. Warp Storm
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_warp_storm',
    config = { extra = { mult_per_suit = 10 } },
    rarity = 3,
    atlas = 'j_chaos_warp_storm',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult_per_suit } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            local suit_count = 0
            for i = 1, #G.playing_cards do
                local s = G.playing_cards[i].base.suit
                if not suits[s] then
                    suits[s] = true
                    suit_count = suit_count + 1
                end
            end
            local mult = suit_count * card.ability.extra.mult_per_suit
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                mult_mod = mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 238. The Great Filter
SMODS.Joker({
    unlocked = true,
    discovered = true,
    key = 'j_chaos_the_great_filter',
    config = { extra = { x_mult = 1 } },
    rarity = 3,
    atlas = 'j_chaos_the_great_filter',
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.x_mult > 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
        if context.before and not context.blueprint then
            if context.scoring_name == '5 of a Kind' and card.ability.extra.x_mult < 5 then
                card.ability.extra.x_mult = 5
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end
    end
})
