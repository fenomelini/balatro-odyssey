-- local commons = require('src/jokers/33_paradox_common')

-- 351. Bootstrap Paradox
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_bootstrap_paradox',
    discovered = true,
    atlas = 'j_paradox_bootstrap_paradox',
    config = { extra = { x_mult = 1.5 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
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
                Xmult_mod = card.ability.extra.x_mult
            }
        end
        
        -- Respawn logic: If end of round and we only have one, create another.
        if context.end_of_round and not context.repetition and not context.other_card and not context.blueprint then
            local count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == 'odyssey_j_paradox_bootstrap_paradox' then
                    count = count + 1
                end
            end
            
            if count < 2 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card_copy = create_card('Joker', G.jokers, nil, nil, nil, nil, 'odyssey_j_paradox_bootstrap_paradox')
                        card_copy:add_to_deck()
                        G.jokers:emplace(card_copy)
                        card_copy:start_materialize()
                        play_sound('timpani')
                        return true
                    end
                }))
                return {
                    message = "Paradox!",
                    colour = G.C.RED
                }
            end
        end
    end
})

-- 352. Chicken and Egg
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_chicken_egg',
    discovered = true,
    atlas = 'j_paradox_chicken_egg',
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
             if context.other_card == context.scoring_hand[1] then
                 return {
                     message = localize('k_again_ex'),
                     repetitions = 1,
                     card = card
                 }
             end
        end
    end
})

-- 353. Ship of Theseus
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_ship_of_theseus',
    discovered = true,
    atlas = 'j_paradox_ship_of_theseus',
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local clean_deck = true
            for k, v in pairs(G.playing_cards) do
                if v.config and v.config.center == G.P_CENTERS.c_base and not v.edition and not v.seal then
                    clean_deck = false
                    break
                end
            end
            
            if clean_deck then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end
    end
})

-- 354. Fermi's Paradox
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_fermi_paradox',
    discovered = true,
    atlas = 'j_paradox_fermi_paradox',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.hands then
            local planets_used = false
            for k, v in pairs(G.GAME.hands) do
                if v.level > 1 then
                    planets_used = true
                    break
                end
            end
            
            if not planets_used then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end
    end
})

-- 355. Evil Twin
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_evil_twin',
    discovered = true,
    atlas = 'j_paradox_evil_twin',
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    other_joker = G.jokers.cards[i+1]
                    break
                end
            end
            
            if other_joker and other_joker ~= card then
                -- Protection against copying another Evil Twin or self
                if other_joker.config.center.key == 'odyssey_j_paradox_evil_twin' then return end

                context.blueprint = (context.blueprint or 0) + 1
                local ret = other_joker:calculate_joker(context)
                context.blueprint = (context.blueprint or 0) - 1
                
                if ret then
                    if ret.mult_mod then ret.mult_mod = -ret.mult_mod end
                    if ret.chip_mod then ret.chip_mod = -ret.chip_mod end
                    if ret.Xmult_mod then ret.Xmult_mod = 1 / ret.Xmult_mod end
                    ret.message = "Evil!"
                    ret.colour = G.C.BLACK
                    ret.card = card
                    return ret
                end
            end
        end
    end
})

-- 356. Anti-Joker
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_anti_joker',
    discovered = true,
    atlas = 'j_paradox_anti_joker',
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local t_chips = hand_chips
            local t_mult = mult
            
            -- Swap global values
            hand_chips = t_mult
            mult = t_chips
            
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
            
            return {
                message = "Swap!",
                colour = G.C.PURPLE,
                card = card
            }
        end
    end
})

-- 357. Reverse Logic
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_reverse_logic',
    discovered = true,
    atlas = 'j_paradox_reverse_logic',
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local current_hand = context.scoring_name
            local max_level = 0
            for k, v in pairs(G.GAME.hands) do
                if v.level > max_level then max_level = v.level end
            end
            
            local current_level = G.GAME.hands[current_hand].level
            if max_level > current_level then
                local diff = max_level - current_level
                local bonus_chips = G.GAME.hands[current_hand].l_chips * diff
                local bonus_mult = G.GAME.hands[current_hand].l_mult * diff
                
                return {
                     message = "Reverse!",
                     chip_mod = bonus_chips,
                     mult_mod = bonus_mult,
                     card = card
                }
            end
        end
    end
})

-- 358. Impossible
SMODS.Joker({
    unlocked = true,
    key = 'j_paradox_impossible',
    discovered = true,
    atlas = 'j_paradox_impossible',
    config = { extra = { x_mult = 100 } },
    rarity = 3,
    pos = { x = 0, y = 0 },
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             local hand = context.scoring_hand
             if #hand == 5 then
                 local first_rank = hand[1].base.id
                 local same_rank = true
                 for i=2, 5 do
                     if hand[i].base.id ~= first_rank then
                         same_rank = false
                         break
                     end
                 end
                 
                 if same_rank then
                     local suits = {}
                     for i=1, 5 do
                         suits[hand[i].base.suit] = true
                     end
                     
                     local suit_count = 0
                     for k,v in pairs(suits) do suit_count = suit_count + 1 end
                     
                     if suit_count >= 5 then
                         return {
                             message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                             Xmult_mod = card.ability.extra.x_mult
                         }
                     end
                 end
             end
        end
    end
})