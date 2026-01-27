-- ============================================
-- CELESTIAL - Rare (Jokers 191-198)
-- ============================================

-- 191. Big Bang
SMODS.Joker({
    key = 'j_celestial_big_bang',
    rarity = 3,
    atlas = 'j_celestial_big_bang',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.selling_self then
            -- Destroy all other jokers
            local jokers_to_destroy = {}
            for _, v in ipairs(G.jokers.cards) do
                if v ~= card then
                    jokers_to_destroy[#jokers_to_destroy+1] = v
                end
            end
            
            for _, v in ipairs(jokers_to_destroy) do
                v:start_dissolve()
            end
            
            -- Create 5 random common jokers
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i = 1, 5 do
                        local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'celestial_big_bang')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    end
                    return true
                end
            }))
            return {
                message = localize('k_big_bang'),
                colour = G.C.RED
            }
        end
    end
})

-- 192. Buraco Negro Supermassivo
SMODS.Joker({
    key = 'j_celestial_supermassive_black_hole',
    config = { extra = { x_mult = 4 } },
    rarity = 3,
    atlas = 'j_celestial_supermassive_black_hole',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
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
        
        if context.after and not context.blueprint then
            if #G.hand.cards > 0 then
                local random_card = pseudorandom_element(G.hand.cards, pseudoseed('celestial_supermassive'))
                if random_card then
                    if not random_card.ability.eternal then random_card:start_dissolve() end
                    return {
                        message = localize('k_destroyed'),
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    end
})

-- 193. Explosão de Raios Gama
SMODS.Joker({
    key = 'j_celestial_gamma_ray_burst',
    config = { extra = { x_mult = 10 } },
    rarity = 3,
    atlas = 'j_celestial_gamma_ray_burst',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
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
        
        if context.after and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if not card.ability.eternal then card:start_dissolve() end
                    return true
                end
            }))
            return {
                message = localize('k_destroyed'),
                colour = G.C.RED
            }
        end
    end
})

-- 194. Matéria Escura
SMODS.Joker({
    key = 'j_celestial_dark_matter',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_celestial_dark_matter',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.current_round.discards_left == 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 195. Energia Escura
SMODS.Joker({
    key = 'j_celestial_dark_energy',
    rarity = 3,
    atlas = 'j_celestial_dark_energy',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- 196. Inflação Cósmica
SMODS.Joker({
    key = 'j_celestial_cosmic_inflation',
    config = { extra = { max_gain = 50 } },
    rarity = 3,
    atlas = 'j_celestial_cosmic_inflation',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local gain = math.min(G.GAME.dollars, card.ability.extra.max_gain)
            if gain > 0 then
                ease_dollars(gain)
                return {
                    message = localize('$') .. gain,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
})

-- 197. Falso Vácuo
SMODS.Joker({
    key = 'j_celestial_false_vacuum',
    config = { extra = { x_mult = 5, odds = 20 } },
    rarity = 3,
    atlas = 'j_celestial_false_vacuum',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
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
        
        if context.end_of_round and not context.repetition and not context.other_card then
            if pseudorandom('celestial_false_vacuum') < G.GAME.probabilities.normal / card.ability.extra.odds then
                ease_dollars(-G.GAME.dollars)
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end
})


-- 198. Esfera de Dyson
SMODS.Joker({
    key = 'j_celestial_dyson_sphere',
    rarity = 3,
    atlas = 'j_celestial_dyson_sphere',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.interest_cap = 100
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.interest_cap = 25
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
