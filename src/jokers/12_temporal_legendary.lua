-- ============================================
-- TEMPORAL - Legendary (Jokers 119-120)
-- ============================================

-- 119. Mão Dupla
SMODS.Joker({
    key = 'j_temporal_double_hand',
    config = { extra = { first_hand = true, triggered = false } },
    rarity = 4,
    atlas = 'j_temporal_double_hand',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    
    calculate = function(self, card, context)
        -- Reset flag at start of blind
        if context.setting_blind and not context.blueprint then
            card.ability.extra.first_hand = true
            card.ability.extra.triggered = false
        end
        
        -- Before playing hand: check if it's first hand
        if context.before and not context.blueprint and card.ability.extra.first_hand and not card.ability.extra.triggered then
            card.ability.extra.triggered = true
            card_eval_status_text(card, 'extra', nil, nil, nil, { 
                message = localize('k_again_ex'), 
                colour = G.C.PURPLE 
            })
        end
        
        -- During play: retrigger all played cards if first hand
        if context.repetition and context.cardarea == G.play then
            if card.ability.extra.first_hand and card.ability.extra.triggered then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card
                }
            end
        end
        
        -- After hand: disable first_hand flag
        if context.after and not context.blueprint and card.ability.extra.first_hand then
            card.ability.extra.first_hand = false
        end
    end
})

-- 120. Loop Eterno
SMODS.Joker({
    key = 'j_temporal_eternal_loop',
    config = { extra = { x_mult = 3, count = 0, last_hand = '' } },
    rarity = 4,
    atlas = 'j_temporal_eternal_loop',
    pos = { x = 0, y = 0 },
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = card and card.ability.extra or self.config.extra

    
        return { vars = { extra.played, extra.x_mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.before and context.scoring_name then
            local hand_type = context.scoring_name
            if hand_type == card.ability.extra.last_hand then
                card.ability.extra.played = card.ability.extra.played + 1
            else
                card.ability.extra.played = 1
                card.ability.extra.last_hand = hand_type
            end
        end
        
        if context.joker_main and card.ability.extra.played >= 3 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.MULT
            }
        end
    end
})
