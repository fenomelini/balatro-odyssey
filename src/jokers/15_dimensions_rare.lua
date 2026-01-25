-- ============================================
-- DIMENSIONS - Rare (Jokers 151-158)
-- ============================================

-- 151. Fusão Dimensional
SMODS.Joker({
    key = 'j_dimensions_merge',
    config = { extra = {} },
    rarity = 3,
    atlas = 'j_dimensions_merge',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    -- Mecânica implementada em 03_vanilla_override.lua
    calculate = function(self, card, context)
        if context.joker_main then
            if context.scoring_name == 'Four of a Kind' then
                local has_two_pair = false
                -- Verificar se as cartas marcadas originalmente continham dois pares
                -- Mas o override já mudou o nome da mão para Four of a Kind.
            end
        end
    end
})

-- 152. Universo de Bolso
SMODS.Joker({
    key = 'j_dimensions_pocket_universe',
    config = { extra = {} },
    rarity = 3,
    atlas = 'j_dimensions_pocket_universe',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.selling_card and context.card.ability.set == 'Joker' then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'pocket_universe')
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_planet'),
                    colour = G.C.SECONDARY_SET.Planet,
                    card = card
                }
            end
        end
    end
})

-- 153. Senhor Dimensional
SMODS.Joker({
    key = 'j_dimensions_lord',
    config = { extra = { x_mult_per_slot = 0.5 } },
    rarity = 3,
    atlas = 'j_dimensions_lord',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local empty_slots = 0
        if G.jokers then
            empty_slots = G.jokers.config.card_limit - #G.jokers.cards
        end
        local current_x_mult = 1 + (empty_slots * card.ability.extra.x_mult_per_slot)
        return { vars = { current_x_mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local empty_slots = G.jokers.config.card_limit - #G.jokers.cards
            local x_mult = 1 + (empty_slots * card.ability.extra.x_mult_per_slot)
            if x_mult > 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { x_mult } },
                    Xmult_mod = x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 154. Ruptura da Realidade
SMODS.Joker({
    key = 'j_dimensions_reality_breach',
    config = { extra = { mult = 0, mult_gain = 1 } },
    rarity = 3,
    atlas = 'j_dimensions_reality_breach',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        -- Reset after Boss
        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.other_card then
            card.ability.extra.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end

        -- Destroy discarded cards
        if context.discard then
            if context.other_card then
                -- Trigger dissolve
                if not context.other_card.ability.eternal then context.other_card:start_dissolve() end
                
                -- Add Mult
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } },
                    colour = G.C.MULT,
                    card = card
                }
            end
        end

        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 155. Onipresente
SMODS.Joker({
    key = 'j_dimensions_omnipresent',
    config = { extra = {} },
    rarity = 3,
    atlas = 'j_dimensions_omnipresent',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end
    end
})

-- 156. Colapso Dimensional
SMODS.Joker({
    key = 'j_dimensions_collapse',
    config = { extra = { active = false, xmult = 3, current_ante = 0 } },
    rarity = 3,
    atlas = 'j_dimensions_collapse',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.active and "Sim" or "Não" } }

    
    end,
    
    calculate = function(self, card, context)
        -- Reset if Ante changed
        if G.GAME.round_resets.ante > card.ability.extra.current_ante then
            card.ability.extra.current_ante = G.GAME.round_resets.ante
            card.ability.extra.active = false
        end

        -- Trigger on Boss Blind selection
        if context.setting_blind and not card.ability.extra.active then
            if G.GAME.blind.boss then
                local available_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal then
                        table.insert(available_jokers, G.jokers.cards[i])
                    end
                end
                
                if #available_jokers > 0 then
                    local victim = pseudorandom_element(available_jokers, pseudoseed('dimensions_collapse'))
                    victim:start_dissolve()
                    card.ability.extra.active = true
                    return {
                        message = localize('k_active_ex'),
                        colour = G.C.RED
                    }
                end
            end
        end

        if context.joker_main and card.ability.extra.active then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end
})

-- 157. Navegador do Multiverso
SMODS.Joker({
    key = 'j_dimensions_multiverse_navigator',
    config = { extra = {} },
    rarity = 3,
    atlas = 'j_dimensions_multiverse_navigator',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'Flush' then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'multiverse_navigator')
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.SECONDARY_SET.Tarot,
                    card = card
                }
            end
        end
    end
})

-- 158. Transcendência Dimensional
SMODS.Joker({
    key = 'j_dimensions_transcendence',
    config = { extra = { joker_slots = 1, hand_size = 1 } },
    rarity = 3,
    atlas = 'j_dimensions_transcendence',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})
