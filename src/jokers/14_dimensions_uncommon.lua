-- ============================================
-- DIMENSIONS - Uncommon (Jokers 137-150)
-- ============================================

-- 137. Aprendizado
SMODS.Joker({
    key = 'j_dimensions_learning',
    config = { extra = { mult = 0, mult_gain = 5 } },
    rarity = 2,
    atlas = 'j_dimensions_learning',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, extra.mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            local hands_played = G.GAME.current_round.hands_played or 0
            local won = G.GAME.blind and G.GAME.blind.chips_left and G.GAME.blind.chips_left <= 0
            
            if hands_played > 1 and won then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
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

-- 138. Memória
SMODS.Joker({
    key = 'j_dimensions_memory',
    config = { extra = { mult_per_card = 2, discarded_cards = {} } },
    rarity = 2,
    atlas = 'j_dimensions_memory',
    pos = { x = 0, y = 0 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult_per_card } }

    
    end,
    
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            for i = 1, #context.full_hand do
                local id = context.full_hand[i].unique_val
                card.ability.extra.discarded_cards[id] = true
            end
        end
        
        if context.individual and context.cardarea == G.play then
            local id = context.other_card.unique_val
            if card.ability.extra.discarded_cards[id] then
                return {
                    mult = card.ability.extra.mult_per_card,
                    card = card
                }
            end
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.discarded_cards = {}
        end
    end
})

-- 139. Sorte Grande
SMODS.Joker({
    key = 'j_dimensions_big_luck',
    config = { extra = { odds = 4 } },
    rarity = 2,
    atlas = 'j_dimensions_big_luck',
    pos = { x = 0, y = 0 },
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { G.GAME.probabilities.normal or 1, extra.odds } }

    
    end,
    
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
             if pseudorandom('big_luck') < G.GAME.probabilities.normal / card.ability.extra.odds then
                ease_hands_played(1)
                return {
                    message = 'Sorte!',
                    colour = G.C.BLUE
                }
             end
        end
    end
})

-- 140. Sinergia Temporal
SMODS.Joker({
    key = 'j_dimensions_temporal_synergy',
    config = { extra = { mult_per_joker = 3 } },
    rarity = 2,
    atlas = 'j_dimensions_temporal_synergy',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                local key = G.jokers.cards[i].config.center.key
                if (string.find(key, 'temporal') or string.find(key, 'relogio') or 
                   string.find(key, 'tempo') or string.find(key, 'paradoxo') or
                   string.find(key, 'futuro') or string.find(key, 'passado') or
                   string.find(key, 'odyssey_j_temporal')) and G.jokers.cards[i] ~= card then
                    count = count + 1
                end
            end
        end
        return { vars = { card.ability.extra.mult_per_joker, count * card.ability.extra.mult_per_joker } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            if G.jokers and G.jokers.cards then
                for i = 1, #G.jokers.cards do
                    local key = G.jokers.cards[i].config.center.key
                    if (string.find(key, 'temporal') or string.find(key, 'relogio') or 
                       string.find(key, 'tempo') or string.find(key, 'paradoxo') or
                       string.find(key, 'futuro') or string.find(key, 'passado') or
                       string.find(key, 'odyssey_j_temporal')) and G.jokers.cards[i] ~= card then
                        count = count + 1
                    end
                end
            end
            
            local mult = count * card.ability.extra.mult_per_joker
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

-- 141. Estabilidade Suprema
SMODS.Joker({
    key = 'j_dimensions_ultimate_stability',
    config = { extra = { mult = 20, fixed_hands = 0, fixed_discards = 0 } },
    rarity = 3, -- Changed to Rare
    atlas = 'j_dimensions_ultimate_stability',
    pos = { x = 0, y = 0 },
    cost = 10,  -- Increased cost
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
        if context.setting_blind and not context.blueprint then
            card.ability.extra.fixed_hands = G.GAME.round_resets.hands
            card.ability.extra.fixed_discards = G.GAME.round_resets.discards
        end
        
        if context.before and not context.blueprint then
            -- Reset hands and discards to fixed values before playing/discarding
            G.GAME.current_round.hands_left = card.ability.extra.fixed_hands
            G.GAME.current_round.discards_left = card.ability.extra.fixed_discards
            
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = 'Estável!', colour = G.C.FILTER })
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

-- 142. Caótico
SMODS.Joker({
    key = 'j_dimensions_chaotic',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_dimensions_chaotic',
    pos = { x = 0, y = 0 },
    cost = 6,
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
        if context.end_of_round and not context.repetition and not context.other_card then
            if pseudorandom('chaotic') < 0.5 then
                card.ability.extra.mult = card.ability.extra.mult * 2
                return {
                    message = 'Dobrou!',
                    colour = G.C.MULT,
                    card = card
                }
            else
                card.ability.extra.mult = 0
                return {
                    message = 'Zerou!',
                    colour = G.C.RED,
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

-- 143. Primeira Carta
SMODS.Joker({
    key = 'j_dimensions_first_card',
    config = { extra = { chips = 50, first_card = true } },
    rarity = 2,
    atlas = 'j_dimensions_first_card',
    pos = { x = 0, y = 0 },
    cost = 5,
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
        if context.before and not context.blueprint then
            card.ability.extra.first_card = true
        end
        
        if context.individual and context.cardarea == G.play and card.ability.extra.first_card then
            card.ability.extra.first_card = false
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
})

-- 144. Última Carta
SMODS.Joker({
    key = 'j_dimensions_last_card',
    config = { extra = { mult = 20 } },
    rarity = 2,
    atlas = 'j_dimensions_last_card',
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
        if context.individual and context.cardarea == G.play then
            if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end
        end
    end
})

-- 145. Duplo Processamento
SMODS.Joker({
    key = 'j_dimensions_double_processing',
    config = { extra = { money_loss = 2 } },
    rarity = 2,
    atlas = 'j_dimensions_double_processing',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.money_loss } }

    
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            ease_dollars(-card.ability.extra.money_loss)
            return {
                message = '-$' .. card.ability.extra.money_loss,
                colour = G.C.RED
            }
        end
    end
})

-- 146. Começo de Ante
SMODS.Joker({
    key = 'j_dimensions_ante_start',
    config = { extra = { x_mult = 1.5 } },
    rarity = 2,
    atlas = 'j_dimensions_ante_start',
    pos = { x = 0, y = 0 },
    cost = 7,
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
        if context.joker_main then
            if G.GAME.round_resets.blind_states.Small == 'Current' then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 147. Lutador de Chefes
SMODS.Joker({
    key = 'j_dimensions_boss_fighter',
    config = { extra = { x_mult = 2, mult = 15 } },
    rarity = 2,
    atlas = 'j_dimensions_boss_fighter',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult, extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.round_resets.blind_states.Boss == 'Current' then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult,
                    colour = G.C.MULT
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

-- 148. Observador de Blind
SMODS.Joker({
    key = 'j_dimensions_blind_watcher',
    config = { extra = { mult = 0, mult_gain = 10 } },
    rarity = 2,
    atlas = 'j_dimensions_blind_watcher',
    pos = { x = 0, y = 0 },
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.mult, extra.mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                card = card
            }
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

-- 149. Ordem Reversa
SMODS.Joker({
    key = 'j_dimensions_reverse_order',
    config = { extra = { chips = 15 } },
    rarity = 2,
    atlas = 'j_dimensions_reverse_order',
    pos = { x = 0, y = 0 },
    cost = 6,
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
        if context.individual and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
})

-- 150. Sacrifício Final
SMODS.Joker({
    key = 'j_dimensions_final_sacrifice',
    config = { extra = { x_mult = 1, x_mult_gain = 0.1 } },
    rarity = 2,
    atlas = 'j_dimensions_final_sacrifice',
    pos = { x = 0, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.x_mult, extra.x_mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        -- Quando qualquer Joker é vendido (não blueprint)
        if context.selling_card and not context.blueprint then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
            card_eval_status_text(card, 'extra', nil, nil, nil, { 
                message = localize('k_upgrade_ex'), 
                colour = G.C.MULT 
            })
        end
        
        -- Aplica multiplicador
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})
