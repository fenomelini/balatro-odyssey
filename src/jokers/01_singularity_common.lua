-- ============================================
-- SINGULARITY - Common (Jokers 1-16)
-- ============================================

-- 1. Solitary
SMODS.Joker({
    key = 'j_singularity_solitary',
    config = { extra = { mult = 12 } },
    rarity = 1,  -- Common
    atlas = 'j_singularity_solitary',  -- Custom sprite
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            -- Count active jokers
            local joker_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] then
                    joker_count = joker_count + 1
                end
            end
            
            -- If only one joker exists
            if joker_count == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 2. Isolated
SMODS.Joker({
    key = 'j_singularity_isolated',
    atlas = 'j_singularity_isolated',
    config = { extra = { chips = 8 } },
    rarity = 1,
    pos = { x = 0, y = 0 }, -- Common
    
    
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local empty_slots = G.jokers.config.card_limit - #G.jokers.cards
            if empty_slots > 0 then
                local bonus = empty_slots * card.ability.extra.chips
                return {
                    message = localize{ type = 'variable', key = 'a_chips', vars = { bonus } },
                    chip_mod = bonus,
                    colour = G.C.CHIPS
                }
            end
        end
        return nil
    end
})

-- 3. Hermit
SMODS.Joker({
    key = 'j_singularity_hermit',
    atlas = 'j_singularity_hermit',
    config = { extra = { mult = 0, mult_gain = 2, bought_this_round = false } },
    rarity = 1,  -- Common
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.mult_gain } }

    
    end,
    
    calculate = function(self, card, context)
        -- Aplica o Mult acumulado
        if context.joker_main then
            if card.ability.extra.mult > 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
        
        -- No final da rodada, aumenta Mult se não comprou nada
        if context.end_of_round and not context.repetition and not context.other_card then
            if not card.ability.extra.bought_this_round then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
            -- Reset tracker para próxima rodada
            card.ability.extra.bought_this_round = false
        end
        
        -- Rastreia compras na loja
        if context.buying_card then
            card.ability.extra.bought_this_round = true
        end
        
        return nil
    end
})

-- 4. Purist
SMODS.Joker({
    key = 'j_singularity_purist',
    atlas = 'j_singularity_purist',
    config = { extra = { mult = 15 } },
    rarity = 1,  -- Common
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local deck_size = #G.playing_cards
            if deck_size == 52 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 5. Minimalist
SMODS.Joker({
    key = 'j_singularity_minimalist',
    atlas = 'j_singularity_minimalist',
    config = { extra = { mult_per_missing = 4 } },
    rarity = 1,
    pos = { x = 0, y = 0 }, -- Common
    
    
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult_per_missing } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local deck_size = #G.playing_cards
            local missing = math.max(0, 52 - deck_size)
            if missing > 0 then
                local bonus = missing * card.ability.extra.mult_per_missing
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { bonus } },
                    mult_mod = bonus,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 6. Unique
SMODS.Joker({
    key = 'j_singularity_unique',
    atlas = 'j_singularity_unique',
    config = { extra = { mult = 10 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local duplicates = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] and G.jokers.cards[i] ~= card and G.jokers.cards[i].ability.name == card.ability.name then
                    duplicates = duplicates + 1
                end
            end
            
            if duplicates == 0 then
                return {
                    message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                    mult_mod = card.ability.extra.mult,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 7. Singular
SMODS.Joker({
    key = 'j_singularity_singular',
    atlas = 'j_singularity_singular',
    config = { extra = { bought_rarities = {} } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    
    calculate = function(self, card, context)
        if context.buying_card and context.card and context.card.ability.set == 'Joker' then
            local rarity = context.card.config.center.rarity
            if rarity and not card.ability.extra.bought_rarities[rarity] then
                card.ability.extra.bought_rarities[rarity] = true
                ease_dollars(context.card.cost)
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
        end
        return nil
    end
})

-- 8. Monopolist
SMODS.Joker({
    key = 'j_singularity_monopolist',
    atlas = 'j_singularity_monopolist',
    config = { extra = { xmult = 1.5, min_expensive = 3, cost_threshold = 8 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult .. '', extra.min_expensive, extra.cost_threshold } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local expensive_count = 0
            
            -- Conta quantos Jokers têm custo de compra de $8 ou mais
            for i = 1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                if joker and joker.cost >= card.ability.extra.cost_threshold then
                    expensive_count = expensive_count + 1
                end
            end
            
            -- Ativa se tiver pelo menos 3 Jokers caros
            if expensive_count >= card.ability.extra.min_expensive then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 9. Exclusivo
SMODS.Joker({
    key = 'j_singularity_exclusive',
    atlas = 'j_singularity_exclusive',
    config = { extra = { xmult = 1.5, limit = 3 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult .. '' } }

    
    end,
    
    can_use = function(self, card)
        -- Impede compra se já tem 3 ou mais jokers
        if G.jokers and #G.jokers.cards >= 3 then
            return false
        end
        return true
    end,
    
    add_to_deck = function(self, card, from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 2
        end
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 2
        end
    end,
    
    calculate = function(self, card, context)
        -- Aplica X1.5 Mult em TODOS os jokers
        if context.other_joker then
            -- Multiplica o resultado de outro joker por 1.5
            if context.other_joker ~= card then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end
})

-- 10. Solitário Cósmico
SMODS.Joker({
    key = 'j_singularity_cosmic_solitary',
    atlas = 'j_singularity_cosmic_solitary',
    config = { extra = { xmult = 2 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult .. '' } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.jokers.cards == 1 then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    Xmult_mod = card.ability.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
        return nil
    end
})

-- 11. Asceta
SMODS.Joker({
    key = 'j_singularity_ascetic',
    atlas = 'j_singularity_ascetic',
    config = { extra = { mult = 10, money = 2, bought_something = false } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.mult, extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.buying_card then
            card.ability.extra.bought_something = true
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            if not card.ability.extra.bought_something then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
            card.ability.extra.bought_something = false
        end
        
        if context.joker_main and not card.ability.extra.bought_something then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
        return nil
    end
})

-- 12. One Man Army
SMODS.Joker({
    key = 'j_singularity_one_man_army',
    atlas = 'j_singularity_one_man_army',
    config = { extra = { xmult = 2 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult .. '' } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and #G.jokers.cards == 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
        return nil
    end
})

-- 13. Isolamento Total
SMODS.Joker({
    key = 'j_singularity_total_isolation',
    atlas = 'j_singularity_total_isolation',
    config = { extra = { xmult = 3 } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult .. '' } }

    
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
    end
})

-- 14. Sozinho no Espaço
SMODS.Joker({
    key = 'j_singularity_alone_in_space',
    atlas = 'j_singularity_alone_in_space',
    config = { extra = { money = 2 } },
    rarity = 1,        pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.money } }

    
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.other_card then
            -- Calcula APENAS slots vazios de joker, NÃO cartas na mão
            local empty_slots = G.jokers.config.card_limit - #G.jokers.cards
            if empty_slots > 0 then
                local earnings = empty_slots * card.ability.extra.money
                ease_dollars(earnings)
                return {
                    message = localize('$') .. earnings,
                    colour = G.C.MONEY
                }
            end
        end
        return nil
    end
})

-- 15. Ermitão Estelar
SMODS.Joker({
    key = 'j_singularity_stellar_hermit',
    atlas = 'j_singularity_stellar_hermit',
    config = { extra = { chips = 50, used_consumable = false } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.chips } }

    
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable then
            card.ability.extra.used_consumable = true
        end
        
        if context.joker_main and not card.ability.extra.used_consumable then
            return {
                message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            card.ability.extra.used_consumable = false
        end
        return nil
    end
})

-- 16. Solidão Cósmica
SMODS.Joker({
    key = 'j_singularity_cosmic_solitude',
    atlas = 'j_singularity_cosmic_solitude',
    config = { extra = { xmult = 1, xmult_gain = 0.2, bought_joker = false } },
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)

    
        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

    
        return { vars = { extra.xmult .. '', extra.xmult_gain .. '' } }

    
    end,
    
    calculate = function(self, card, context)
        if context.buying_card and context.card.ability.set == 'Joker' then
            card.ability.extra.bought_joker = true
        end
        
        if context.end_of_round and not context.repetition and not context.other_card then
            -- Só ativa no final do Boss Blind de cada Ante
            if G.GAME.blind and G.GAME.blind.boss then
                if not card.ability.extra.bought_joker then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.MULT })
                end
                card.ability.extra.bought_joker = false -- Reset para o próximo Ante
            end
        end
        
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult,
                colour = G.C.MULT
            }
        end
        return nil
    end
})
