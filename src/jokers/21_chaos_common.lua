-- ============================================
-- CHAOS - Common (Jokers 201-216)
-- ============================================

-- 201. Dado Viciado (Loaded Die)
SMODS.Joker({
    key = 'j_chaos_loaded_die',
    config = { extra = { mult = 30, odds = 6 } },
    rarity = 1,
    atlas = 'j_chaos_loaded_die',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('j_chaos_loaded_die') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 202. Moeda da Sorte (Lucky Coin)
SMODS.Joker({
    key = 'j_chaos_lucky_coin',
    config = { extra = { mult = 15, odds = 2 } },
    rarity = 1,
    atlas = 'j_chaos_lucky_coin',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('j_chaos_lucky_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 203. Roleta (Roulette)
SMODS.Joker({
    key = 'j_chaos_roulette',
    config = { extra = { x_mult = 4, odds = 20 } },
    rarity = 1,
    atlas = 'j_chaos_roulette',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('j_chaos_roulette') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 204. Imprevisível (Unpredictable)
SMODS.Joker({
    key = 'j_chaos_unpredictable',
    config = { extra = { max_mult = 20 } },
    rarity = 1,
    atlas = 'j_chaos_unpredictable',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.max_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local rand_mult = pseudorandom('j_chaos_unpredictable') * card.ability.extra.max_mult
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { math.floor(rand_mult) } },
                mult_mod = rand_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 205. Caos Controlado (Controlled Chaos)
SMODS.Joker({
    key = 'j_chaos_controlled_chaos',
    config = { extra = { mult = 10, chips = 50 } },
    rarity = 1,
    atlas = 'j_chaos_controlled_chaos',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local is_red = false
            for _, c in ipairs(context.scoring_hand) do
                if c:is_suit('Hearts') or c:is_suit('Diamonds') then
                    is_red = true
                    break
                end
            end

            if is_red then
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 206. Entropia Menor (Minor Entropy)
SMODS.Joker({
    key = 'j_chaos_minor_entropy',
    config = { extra = { mult = 4 } },
    rarity = 1,
    atlas = 'j_chaos_minor_entropy',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local odd_count = 0
            for _, c in ipairs(G.hand.cards) do
                if not c.debuff and (c:get_id() == 14 or c:get_id() == 3 or c:get_id() == 5 or c:get_id() == 7 or c:get_id() == 9) then
                    odd_count = odd_count + 1
                end
            end
            if odd_count > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult * odd_count } },
                    mult_mod = card.ability.extra.mult * odd_count,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 207. Embaralhador (Shuffler)
SMODS.Joker({
    key = 'j_chaos_shuffler',
    config = { extra = { chips = 50 } },
    rarity = 1,
    atlas = 'j_chaos_shuffler',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
        if context.after and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand:shuffle('j_chaos_shuffler')
                    return true
                end
            }))
            return {
                message = localize('k_shuffled'),
                colour = G.C.ORANGE
            }
        end
    end
})

-- 208. Coringa Selvagem (Wild Joker)
SMODS.Joker({
    key = 'j_chaos_wild_joker',
    config = { extra = { mult = 10, odds = 5 } },
    rarity = 1,
    atlas = 'j_chaos_wild_joker',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        if context.before and not context.blueprint then
            for _, c in ipairs(context.scoring_hand) do
                if pseudorandom('j_chaos_wild_joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
                    local new_suit = suits[pseudorandom('j_chaos_wild_joker_suit', 1, 4)]
                    c:change_suit(new_suit)
                    card_eval_status_text(c, 'extra', nil, nil, nil, {message = localize(new_suit, 'suits_singular'), colour = G.C.SUITS[new_suit]})
                end
            end
        end
    end
})

-- 209. Sorte de Principiante (Beginner's Luck)
SMODS.Joker({
    key = 'j_chaos_beginners_luck',
    config = { extra = { x_mult = 2, odds = 3 } },
    rarity = 1,
    atlas = 'j_chaos_beginners_luck',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            if pseudorandom('j_chaos_beginners_luck') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 210. Aposta Alta (High Stakes)
SMODS.Joker({
    key = 'j_chaos_high_stakes',
    config = { extra = { mult = 20, dollars = 1 } },
    rarity = 1,
    atlas = 'j_chaos_high_stakes',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, extra.dollars } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if not context.blueprint then
                ease_dollars(-card.ability.extra.dollars)
            end
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 211. Risco Calculado (Calculated Risk)
SMODS.Joker({
    key = 'j_chaos_calculated_risk',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_chaos_calculated_risk',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.discards_left == 0 then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 212. Frenesi (Frenzy)
SMODS.Joker({
    key = 'j_chaos_frenzy',
    config = { extra = { mult_gain = 5, current_mult = 0 } },
    rarity = 1,
    atlas = 'j_chaos_frenzy',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult_gain, extra.current_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
                mult_mod = card.ability.extra.current_mult,
                colour = G.C.MULT
            }
        end
        if context.discard and not context.blueprint and not context.other_card then
            card.ability.extra.current_mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card then
            card.ability.extra.current_mult = 0
        end
    end
})

-- 213. Dispersão (Scatter)
SMODS.Joker({
    key = 'j_chaos_scatter',
    config = { extra = { max_chips = 10 } },
    rarity = 1,
    atlas = 'j_chaos_scatter',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.max_chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local rand_chips = pseudorandom('j_chaos_scatter') * card.ability.extra.max_chips
            return {
                chips = rand_chips,
                card = context.other_card
            }
        end
    end
})

-- 214. Ruído Branco (White Noise)
SMODS.Joker({
    key = 'j_chaos_white_noise',
    config = { extra = { mult = 10, odds = 10 } },
    rarity = 1,
    atlas = 'j_chaos_white_noise',
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, G.GAME.probabilities.normal, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        if context.before and not context.blueprint then
            for _, c in ipairs(context.scoring_hand) do
                if pseudorandom('j_chaos_white_noise') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    c:set_ability(G.P_CENTERS.m_odyssey_emerald)
                    card_eval_status_text(c, 'extra', nil, nil, nil, {message = localize('k_stone'), colour = G.C.GREY})
                end
            end
        end
    end
})

-- 215. Turbulência (Turbulence)
SMODS.Joker({
    key = 'j_chaos_turbulence',
    config = { extra = { chips = 40, penalty = 10 } },
    rarity = 1,
    atlas = 'j_chaos_turbulence',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.chips, extra.penalty } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local chips = card.ability.extra.chips
            if #context.scoring_hand == 5 then
                chips = chips - card.ability.extra.penalty
            end
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { chips } },
                chip_mod = chips,
                colour = G.C.CHIPS
            }
        end
    end
})

-- 216. Instável (Unstable)
SMODS.Joker({
    key = 'j_chaos_unstable',
    config = { extra = { x_mult = 1.5, odds = 10 } },
    rarity = 1,
    atlas = 'j_chaos_unstable',
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult, G.GAME.probabilities.normal, extra.odds } }

    
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
            if pseudorandom('j_chaos_unstable') < G.GAME.probabilities.normal / card.ability.extra.odds then
                if not card.ability.eternal then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }))
                    return {
                        message = localize('k_destroyed'),
                        colour = G.C.RED
                    }
                end
            end
        end
    end
})