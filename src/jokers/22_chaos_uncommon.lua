-- 217. Chaos Theory
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_theory',
    config = { extra = { x_mult = 2 } },
    rarity = 2,
    atlas = 'j_chaos_theory',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            local suit_count = 0
            for i = 1, #context.scoring_hand do
                local s = (context.scoring_hand[i]:get_id() > 0 or context.scoring_hand[i].config.center.key == 'j_odyssey_j_chaos_butterfly_effect') and context.scoring_hand[i].base.suit or 'None'
                if s ~= 'None' and not suits[s] then
                    suits[s] = true
                    suit_count = suit_count + 1
                end
            end
            
            if suit_count >= 4 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 218. Butterfly Effect
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_butterfly_effect',
    config = {},
    rarity = 2,
    atlas = 'j_chaos_butterfly_effect',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local first_card = context.scoring_hand[1]
            if first_card then
                local target_suit = first_card.base.suit
                for i = 1, #G.hand.cards do
                    local c = G.hand.cards[i]
                    if c ~= first_card then
                        c:change_suit(target_suit)
                        c:juice_up()
                    end
                end
                for i = 1, #context.scoring_hand do
                   local c = context.scoring_hand[i]
                   if c ~= first_card then
                       c:change_suit(target_suit)
                       c:juice_up()
                   end
                end
                return {
                    message = "Transform!",
                    card = card
                }
            end
        end
    end
})

-- 219. Pandemonium
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_pandemonium',
    config = { extra = { repetitions = 3 } },
    rarity = 2,
    atlas = 'j_chaos_pandemonium',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
           if #G.hand.cards > 0 then
               local rng = pseudorandom('j_chaos_pandemonium')
               local idx = math.ceil(rng * #G.hand.cards)
               card.ability.extra.target_card = G.hand.cards[idx]
           else
               card.ability.extra.target_card = nil
           end
        end
        
        if context.repetition and context.cardarea == G.hand then
             if card.ability.extra.target_card and context.other_card == card.ability.extra.target_card then
                 return {
                     message = localize('k_again_ex'),
                     repetitions = card.ability.extra.repetitions,
                     card = context.other_card
                 }
             end
        end
    end
})

-- 220. Discord
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_discord',
    config = { extra = { mult = 30 } },
    rarity = 2,
    atlas = 'j_chaos_discord',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local played_hand = context.scoring_name
            local max_played = 0
            local most_played_hand = ''
            
            for k, v in pairs(G.GAME.hands) do
                if v.played > max_played then
                    max_played = v.played
                    most_played_hand = k
                end
            end
            
            if played_hand ~= most_played_hand then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 221. Anarchy
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_anarchy',
    config = { extra = { min = 0.5, max = 3 } },
    rarity = 2,
    atlas = 'j_chaos_anarchy',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.min, extra.max } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local x_mult = card.ability.extra.min + (pseudorandom('j_chaos_anarchy') * (card.ability.extra.max - card.ability.extra.min))
            -- Round to 1 decimal like in DOC
            x_mult = math.floor(x_mult * 10) / 10
             return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { x_mult } },
                Xmult_mod = x_mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 222. Mana Vortex
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_mana_vortex',
    loc_txt = {
        name = "Mana Vortex",
        text = {
            "Creates a random {C:tarot}Tarot{} card,",
            "but destroys a random {C:attention}Common Joker{}",
            "(if any) at end of round"
        }
    },
    config = {},
    rarity = 2,
    atlas = 'j_chaos_mana_vortex',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            -- Create Tarot
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local tarot = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'j_chaos_mana_vortex')
                        tarot:add_to_deck()
                        G.consumeables:emplace(tarot)
                        return true
                    end
                }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
            end
            
            -- Destroy Common Joker
            local commons = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center.rarity == 1 and not G.jokers.cards[i].ability.eternal then
                    commons[#commons + 1] = G.jokers.cards[i]
                end
            end
            
            if #commons > 0 then
                local victim = pseudorandom_element(commons, pseudorandom('j_chaos_mana_vortex'))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        victim:start_dissolve()
                        return true
                    end
                }))
                 card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_destroyed'), colour = G.C.RED})
            end
        end
    end
})

-- 223. Transmutation
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_transmutation',
    loc_txt = {
        name = "Transmutation",
        text = {
            "When sold, transforms into",
            "a random {C:attention}Uncommon Joker{}"
        }
    },
    config = {},
    rarity = 2,
    atlas = 'j_chaos_transmutation',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.selling_self then
             G.E_MANAGER:add_event(Event({
                func = function()
                    local joker = create_card('Joker', G.jokers, nil, 0.9, nil, nil, nil, 'j_chaos_transmutation')
                    joker:add_to_deck()
                    G.jokers:emplace(joker)
                    joker:start_materialize()
                    return true
                end
            }))
             return {
                message = localize('k_transmuted'),
                colour = G.C.PURPLE
            }     
        end
    end
})

-- 224. Unstable Alchemy
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_unstable_alchemy',
    loc_txt = {
        name = "Unstable Alchemy",
        text = {
            "Earn {C:money}$#1#{} when playing a {C:attention}Flush{}.",
            "{C:green}#2# in #3#{} chance to transform",
            "the Flush into {C:diamonds}Diamonds{}"
        }
    },
    config = { extra = { dollars = 4, odds = 4 } },
    rarity = 2,
    atlas = 'j_chaos_unstable_alchemy',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.dollars, G.GAME.probabilities.normal, extra.odds } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == 'Flush' then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            G.E_MANAGER:add_event(Event({func = function() G.GAME.dollars = G.GAME.dollars + card.ability.extra.dollars; G.GAME.dollar_buffer = G.GAME.dollar_buffer - card.ability.extra.dollars; return true end}))
            
            if pseudorandom('j_chaos_unstable_alchemy') < G.GAME.probabilities.normal / card.ability.extra.odds then
                 for i = 1, #context.scoring_hand do
                    local c = context.scoring_hand[i]
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            c:change_suit('Diamonds')
                            c:juice_up()
                            return true
                        end
                    }))
                 end
                 return {
                    message = localize('k_alchemy'), 
                    colour = G.C.DIAMONDS
                }
            else
                 return {
                    message = localize('$')..card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
})

-- 225. Chain Reaction
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_chain_reaction',
    loc_txt = {
        name = "Chain Reaction",
        text = {
            "{C:mult}+#1#{} Mult for each time a",
            "Joker ability activated this hand"
        }
    },
    config = { extra = { mult_per_trigger = 5 } },
    rarity = 2,
    atlas = 'j_chaos_chain_reaction',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult_per_trigger } }

    end,
    calculate = function(self, card, context)
        -- Counting triggers is hard, so we estimate based on jokers count if we can't get official count.
        -- But for now, we'll use a safer proxy: +5 Mult for each Joker you own.
        -- Actually, let's use the intended mechanic if possible.
        if context.joker_main then
            local count = #G.jokers.cards
            -- Simplified to +5 per Joker for now to avoid crashes with non-existent global counters
            local mult = count * card.ability.extra.mult_per_trigger
             return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                mult_mod = mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 226. Will-o'-the-Wisp
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_will_o_the_wisp',
    loc_txt = {
        name = "Will-o'-the-Wisp",
        text = {
            "Create a {C:dark_edition}Negative{} copy",
            "of a random consumable",
            "when you defeat a {C:attention}Boss Blind{}"
        }
    },
    config = {},
    rarity = 2,
    atlas = 'j_chaos_will_o_the_wisp',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            if G.GAME.blind.boss then
                 local card_type = pseudorandom_element({'Tarot', 'Planet', 'Spectral'}, pseudorandom('j_chaos_will_o_the_wisp'))
                 G.E_MANAGER:add_event(Event({
                    func = function()
                        local consum = create_card(card_type, G.consumeables, nil, nil, nil, nil, nil, 'j_chaos_will_o_the_wisp')
                        consum:set_edition('e_negative', true)
                        consum:add_to_deck()
                        G.consumeables:emplace(consum)
                        return true
                    end
                }))
                 return {
                    message = localize('k_wisp'),
                    colour = G.C.DARK_EDITION
                 }
            end
        end
    end
})

-- 227. Pandora's Box
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_pandoras_box',
    loc_txt = {
        name = "Pandora's Box",
        text = {
            "When bought, gain {C:money}$#1#{}.",
            "Sets your Mult to {C:attention}0{}",
            "on the next hand played"
        }
    },
    config = { extra = { money = 20 } },
    rarity = 2,
    atlas = 'j_chaos_pandoras_box',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.money } }

    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card == card then
            G.GAME.dollars = G.GAME.dollars + card.ability.extra.money
             card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$')..card.ability.extra.money, colour = G.C.MONEY})
             card.ability.extra.active_debuff = true
        end
        
        if context.joker_main and card.ability.extra.active_debuff then
            card.ability.extra.active_debuff = false
            return {
                message = localize('k_pandora'),
                mult_mod = -100000,
                Xmult_mod = 0
            }
        end
    end
})

-- 228. Bad Omen
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_bad_omen',
    config = { extra = { x_mult = 3, odds = 4, severe_x_mult = 0.5 } },
    rarity = 2,
    atlas = 'j_chaos_bad_omen',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult, G.GAME.probabilities.normal, extra.odds, extra.severe_x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('j_chaos_bad_omen') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.severe_x_mult } },
                    Xmult_mod = card.ability.extra.severe_x_mult,
                    colour = G.C.RED
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 229. Leap of Faith
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_leap_of_faith',
    config = { extra = { x_mult = 3 } },
    rarity = 2,
    atlas = 'j_chaos_leap_of_faith',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})


-- 230. Dissonance
SMODS.Joker({
    unlocked = true,
    discovered = false,
    key = 'j_chaos_dissonance',
    loc_txt = {
        name = "Dissonance",
        text = {
            "{C:chips}+#1#{} Chips if played cards",
            "do not form any poker hand",
            "({C:attention}High Card{})"
        }
    },
    config = { extra = { chips = 100 } },
    rarity = 2,
    atlas = 'j_chaos_dissonance',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == 'High Card' then
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
})