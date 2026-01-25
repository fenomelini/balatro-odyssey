-- ============================================
-- QUANTUM - Rare (Jokers 71-78)
-- ============================================

-- 71. Portal Dimensional
SMODS.Joker({
    key = 'j_quantum_dimensional_portal',
    atlas = 'j_quantum_dimensional_portal',
    config = { extra = { mult = 40, odds = 10 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local normal_prob = G.GAME and G.GAME.probabilities and G.GAME.probabilities.normal or 1
        return { vars = { card.ability.extra.mult, '' .. normal_prob, card.ability.extra.odds } }
    end,
    
    calculate = function(self, card, context)
        -- Chance to change suit after playing hand
        if context.after and not context.blueprint then
            if pseudorandom('portal_dimensional') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- Pick a random card from hand (remaining cards)
                if G.hand and G.hand.cards and #G.hand.cards > 0 then
                    local target_card = pseudorandom_element(G.hand.cards, pseudoseed('portal_card'))
                    
                    local suits = {'Hearts', 'Diamonds', 'Clubs', 'Spades'}
                    local current_suit = target_card.base.suit
                    local new_suit = pseudorandom_element(suits, pseudoseed('portal_suit'))
                    
                    -- Ensure suit changed
                    while new_suit == current_suit and #suits > 1 do
                        new_suit = pseudorandom_element(suits, pseudoseed('portal_suit'))
                    end
                    
                    target_card:set_base(G.P_CARDS[new_suit..'_'..target_card.base.value])
                    
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = 'Portal!',
                        colour = G.C.PURPLE
                    })
                end
            end
        end
        
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 72. Espelho
SMODS.Joker({
    key = 'j_quantum_mirror',
    atlas = 'j_quantum_mirror',
    config = { extra = { mult = 50, is_reflection = false } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff and not card.ability.extra.is_reflection and not G.CONTROLLER.loading and #G.jokers.cards < G.jokers.config.card_limit then
            local copy = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_quantum_mirror')
            copy.ability.extra.mult = math.floor(card.ability.extra.mult / 2)
            copy.ability.extra.is_reflection = true
            copy:add_to_deck()
            G.jokers:emplace(copy)
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Refletido!', colour = G.C.MULT })
        end
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 73. Yin Yang
SMODS.Joker({
    key = 'j_quantum_yin_yang',
    atlas = 'j_quantum_yin_yang',
    config = { extra = { mult = 80, chips = 150, is_mult = true } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.is_mult and 'Mult' or 'Fichas', extra.mult, extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.is_mult = not card.ability.extra.is_mult
            card_eval_status_text(card, 'extra', nil, nil, nil, { 
                message = card.ability.extra.is_mult and 'Mult!' or 'Fichas!', 
                colour = card.ability.extra.is_mult and G.C.MULT or G.C.CHIPS 
            })
        end
        
        if context.joker_main then
            if card.ability.extra.is_mult then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
})

-- 74. Dimensão Paralela
SMODS.Joker({
    key = 'j_quantum_parallel_dimension',
    atlas = 'j_quantum_parallel_dimension',
    config = { extra = { x_mult = 2.5 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        -- Condition: Hand must have exactly 2 or 4 cards (Parallel)
        if context.joker_main then
            if context.scoring_hand and (#context.scoring_hand == 2 or #context.scoring_hand == 4) then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 75. Dobra Espacial
SMODS.Joker({
    key = 'j_quantum_spatial_fold',
    atlas = 'j_quantum_spatial_fold',
    config = { extra = { mult = 50 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        -- Libera +1 slot (adjacentes compartilham espaço)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        -- Remove o slot extra
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
})

-- 76. Wormhole
SMODS.Joker({
    key = 'j_quantum_wormhole',
    atlas = 'j_quantum_wormhole',
    config = { extra = { x_mult = 2.5, chance = 4 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local normal_prob = G.GAME and G.GAME.probabilities and G.GAME.probabilities.normal or 1
        return { vars = { card.ability.extra.x_mult, '' .. normal_prob, card.ability.extra.chance } }
    end,
    
    calculate = function(self, card, context)
        -- Behavior: X2.5 Mult and chance to re-trigger hand cards
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
        
        if context.repetition and context.cardarea == G.play then
            if pseudorandom('wormhole') < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    message = 'Tunnel!',
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- 77. Tesseract
SMODS.Joker({
    key = 'j_quantum_tesseract',
    atlas = 'j_quantum_tesseract',
    config = { extra = { mult_per = 20 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult_per } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {}
            local unique_suits = 0
            
            if context.scoring_hand then
                for _, v in ipairs(context.scoring_hand) do
                    if not suits[v.base.suit] then
                        suits[v.base.suit] = true
                        unique_suits = unique_suits + 1
                    end
                end
            end
            
            local mult = unique_suits * card.ability.extra.mult_per
            
            if mult > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { mult } },
                    mult_mod = mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 78. Klein Bottle
SMODS.Joker({
    key = 'j_quantum_klein_bottle',
    atlas = 'j_quantum_klein_bottle',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 12,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult } }

    
    end,
    
    add_to_deck = function(self, card, from_debuff)
        -- Marca que a inversão está ativa
        if not G.GAME.odyssey_klein_bottle_active then
            G.GAME.odyssey_klein_bottle_active = (G.GAME.odyssey_klein_bottle_active or 0) + 1
            -- Inverte a ordem dos Jokers visualmente e logicamente
            if G.jokers and G.jokers.cards then
                local reversed = {}
                for i = #G.jokers.cards, 1, -1 do
                    table.insert(reversed, G.jokers.cards[i])
                end
                G.jokers.cards = reversed
                -- Atualiza visualmente as posições
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i].T.x = G.jokers.T.x + (i-1)*G.CARD_W*1.1
                end
            end
        end
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        -- Remove a inversão quando vendido/removido
        if G.GAME.odyssey_klein_bottle_active then
            G.GAME.odyssey_klein_bottle_active = (G.GAME.odyssey_klein_bottle_active or 0) - 1
            -- Desinverte a ordem dos Jokers (inverte novamente)
            if G.jokers and G.jokers.cards then
                local reversed = {}
                for i = #G.jokers.cards, 1, -1 do
                    table.insert(reversed, G.jokers.cards[i])
                end
                G.jokers.cards = reversed
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i].T.x = G.jokers.T.x + (i-1)*G.CARD_W*1.1
                end
            end
        end
    end,
    
    calculate = function(self, card, context)
        -- Condition: X3 Mult if this Joker is at either end of the Joker lineup
        if context.joker_main then
            local is_at_end = (G.jokers and G.jokers.cards and (G.jokers.cards[1] == card or G.jokers.cards[#G.jokers.cards] == card))
            if is_at_end then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})