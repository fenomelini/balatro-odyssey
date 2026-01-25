-- 05_deck_mechanics.lua
-- Handles custom logic for Balatro Odyssey Decks

local deck_mechanics = {}

-- Helper to get current deck key
local function get_deck_key()
    if G.GAME and G.GAME.selected_back then
        local key = G.GAME.selected_back.effect.center.key
        if not key then return nil end
        -- Handle Steamodded b_odyssey_ format and odyssey_ format
        key = key:gsub("^b_odyssey_", "")
        key = key:gsub("^odyssey_", "")
        return key
    end
    return nil
end

-- Helper to get deck config
local function get_deck_config()
    if G.GAME.selected_back and G.GAME.selected_back.effect.config then
        return G.GAME.selected_back.effect.config
    end
    return {}
end

------------------------------------------------------------------------
-- HOOKS
------------------------------------------------------------------------

-- 1. Card:calculate_joker (For scoring effects)
local old_calculate_joker = Card.calculate_joker or function() return nil end
Card.calculate_joker = function(self, context)
    local ret = old_calculate_joker(self, context)
    
    local deck_key = get_deck_key()
    if not deck_key then return ret end

    local function merge_effect(base, new)
        if not base then return new end
        if new.mult_mod then base.mult_mod = (base.mult_mod or 0) + new.mult_mod end
        if new.chip_mod then base.chip_mod = (base.chip_mod or 0) + new.chip_mod end
        if new.Xmult_mod then base.Xmult_mod = (base.Xmult_mod or 1) * new.Xmult_mod end
        if not base.message then
            base.message = new.message
            base.colour = new.colour
        end
        return base
    end

    -- Deck 6: Gravitational (Moved to Card:calculate_seal)
    -- Logic removed from here to avoid multiple triggers and dependency on jokers

    -- Deck 10: Quasar (+20 Mult Base)
    if deck_key == 'quasar' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_mult', vars={20}},
            mult_mod = 20,
            colour = G.C.MULT
        })
    end

    -- Deck 35: Ascensao (Ascension) - Hands X2
    if deck_key == 'ascensao' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={2}},
            Xmult_mod = 2,
            colour = G.C.MULT
        })
    end

    -- Deck 36: Queda (Fall) - Hands X0.5
    if deck_key == 'queda' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={0.5}},
            Xmult_mod = 0.5,
            colour = G.C.MULT
        })
    end

    -- Deck 16: Order (Bonus for playing in order)
    if deck_key == 'order' and context.joker_main then
        -- Check if played cards are in rank order (ascending or descending)
        local ordered = true
        if #context.scoring_hand > 1 then
            local ascending = true
            local descending = true
            for i = 1, #context.scoring_hand - 1 do
                if context.scoring_hand[i].base.id >= context.scoring_hand[i+1].base.id then
                    ascending = false
                end
                if context.scoring_hand[i].base.id <= context.scoring_hand[i+1].base.id then
                    descending = false
                end
            end
            ordered = ascending or descending
        else
            ordered = false
        end

        if ordered then
             return merge_effect(ret, {
                message = localize{type='variable', key='a_xmult', vars={2}},
                Xmult_mod = 2,
                colour = G.C.MULT
            })
        end
    end

    -- Deck 18: Timeline (Add % of previous score)
    if deck_key == 'timeline' and context.joker_main then
        local stored = 0
        if G.GAME.selected_back.effect.config.extra and G.GAME.selected_back.effect.config.extra.stored_score then
            stored = G.GAME.selected_back.effect.config.extra.stored_score
        end
        if stored > 0 then
             return merge_effect(ret, {
                message = localize{type='variable', key='a_chips', vars={stored}},
                chip_mod = stored,
                colour = G.C.CHIPS
            })
        end
    end

    ------------------------------------------------------------------------
    -- NEW BARALHOS (41-100) IMPLEMENTATION (Merges)
    ------------------------------------------------------------------------

    -- 43. Lust (Luxuria) - Copas X1.2 Mult
    if deck_key == 'lust' and context.joker_main then
        local count = 0
        if context.scoring_hand then
            for _, c in ipairs(context.scoring_hand) do
                if c:is_suit('Hearts') then count = count + 1 end
            end
        end
        if count > 0 then
            return merge_effect(ret, {
                message = localize{type='variable', key='a_xmult', vars={count}},
                Xmult_mod = 1.2 ^ count,
                colour = G.C.MULT
            })
        end
    end

    -- 44. Pride (Orgulho) - Figuras +30 Fichas
    if deck_key == 'pride' and context.joker_main then
       local count = 0
       if context.scoring_hand then
           for _, c in ipairs(context.scoring_hand) do
               if c:is_face() then count = count + 1 end
           end
       end
       if count > 0 then
           return merge_effect(ret, {
               message = localize{type='variable', key='a_chips', vars={count * 30}},
               chip_mod = count * 30,
               colour = G.C.CHIPS
           })
       end
    end

    -- 67. Solar: Red suits only. Flush 2x.
    if deck_key == 'solar' and context.joker_main and context.scoring_name == 'Flush' then
        return merge_effect(ret, {
             message = localize{type='variable', key='a_xmult', vars={2}},
             Xmult_mod = 2,
             colour = G.C.MULT
        })
    end
    
    -- 66. Oceanic: Black suits only. Flush 2x.
    if deck_key == 'oceanic' and context.joker_main and context.scoring_name == 'Flush' then
        return merge_effect(ret, {
             message = localize{type='variable', key='a_xmult', vars={2}},
             Xmult_mod = 2,
             colour = G.C.MULT
        })
    end

    -- 80. Minimalist II: Hand size 3. X5 Mult.
    if deck_key == 'minimalist_ii' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={5}},
            Xmult_mod = 5,
            colour = G.C.MULT
        })
    end
    
    -- 82. Chaotic II: X2 Score (Boss effect doubled is harder).
    if deck_key == 'chaotic_ii' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={2}},
            Xmult_mod = 2,
            colour = G.C.MULT
        })
    end
    
    -- 83. Ordered II: 0.5x Score.
    if deck_key == 'ordered_ii' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={0.5}},
            Xmult_mod = 0.5,
            colour = G.C.MULT
        })
    end

    -- 89. Dragon: X10 Mult
    if deck_key == 'dragon' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={10}},
            Xmult_mod = 10,
            colour = G.C.MULT
        })
    end

    -- 96. Leviathan: Hand size 5 -> +1000 Chips
    if deck_key == 'leviathan' and context.joker_main and context.scoring_hand and #context.scoring_hand == 5 then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_chips', vars={1000}},
            chip_mod = 1000,
            colour = G.C.CHIPS
        })
    end

    -- 97. Behemoth: Hand size 1 -> X5 Mult
    if deck_key == 'behemoth' and context.joker_main and context.scoring_hand and #context.scoring_hand == 1 then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={5}},
            Xmult_mod = 5,
            colour = G.C.MULT
        })
    end

    -- 42. Sloth (Preguiça): X3 Mult
    if deck_key == 'sloth' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={3}},
            Xmult_mod = 3,
            colour = G.C.MULT
        })
    end

    -- 52. Mirror (Espelho): Right to Left (Descending) -> 2x
    if deck_key == 'mirror' and context.joker_main and context.scoring_hand and #context.scoring_hand >= 2 then
        local descending = true
        for i = 1, #context.scoring_hand - 1 do
            if context.scoring_hand[i].base.id <= context.scoring_hand[i+1].base.id then
                descending = false
                break
            end
        end
        if descending then
             return merge_effect(ret, {
                message = localize{type='variable', key='a_xmult', vars={2}},
                Xmult_mod = 2,
                colour = G.C.MULT
            })
        end
    end

    -- 54. Vampire: Apply accumulated Mult
    if deck_key == 'vampire' and context.joker_main then
        local mult = 0
        if G.GAME.selected_back.effect.config.extra then
            mult = G.GAME.selected_back.effect.config.extra.mult or 0
        end
        if mult > 0 then
            return merge_effect(ret, {
                message = localize{type='variable', key='a_mult', vars={mult}},
                mult_mod = mult,
                colour = G.C.MULT
            })
        end
    end

    -- 60. Invisible: X4 Mult if blind (checked elsewhere, technically always blind here)
    if deck_key == 'invisible' and context.joker_main then
        return merge_effect(ret, {
            message = localize{type='variable', key='a_xmult', vars={4}},
            Xmult_mod = 4,
            colour = G.C.MULT
        })
    end

    -- 65. Volcanic: +$5 per hand
    if deck_key == 'volcanic' and context.joker_main then
         -- Actually money should be applied on scoring? Or end of hand?
         -- joker_main calculates text.
         -- Use ease_dollars triggers in play_cards hook better.
         -- But user wants seeing it?
    end

    return ret
end

-- 2. Card:start_dissolve (For Event Horizon)
local old_start_dissolve = Card.start_dissolve
Card.start_dissolve = function(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    local deck_key = get_deck_key()
    
    -- Deck 7: Event Horizon (Destroy cards -> +0.5 Mult)
    if deck_key == 'event_horizon' then
        G.GAME.selected_back.effect.config.extra = G.GAME.selected_back.effect.config.extra or {}
        G.GAME.selected_back.effect.config.extra.mult = (G.GAME.selected_back.effect.config.extra.mult or 0) + 0.5
        -- Visual feedback?
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize{type='variable', key='a_mult', vars={0.5}}})
    end

    old_start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

-- 2.1 Hook play_cards to capture score before hand (For Timeline Deck)
local old_play_cards = G.FUNCS.play_cards
G.FUNCS.play_cards = function(e)
    local deck_key = get_deck_key()
    if deck_key == 'timeline' then
        G.GAME.odyssey_temp_chips = G.GAME.chips
    end
    
    -- 41. Wrath (Ira): Hand gives $1
    if deck_key == 'wrath' then
        ease_dollars(1)
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('$')..'1', colour = G.C.MONEY})
    end

    -- 65. Volcanic: +$5 per hand
    if deck_key == 'volcanic' then
        ease_dollars(5)
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('$')..'5', colour = G.C.MONEY})
    end
    
    -- 64. Frozen: Debuff first hand
    if deck_key == 'frozen' and G.GAME.current_round.hands_played == 0 then
        -- This hook runs on play_cards. Cards are in G.play.cards or passed in event?
        -- G.play.cards should be populated.
        -- We debuff them.
        for k, v in ipairs(G.play.cards) do
            v:set_debuff(true)
        end
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('k_frozen_ex')})
    end

    old_play_cards(e)
end

-- 2.2 Hook draw_from_play_to_discard to capture score after hand (For Timeline Deck)
local old_draw_from_play_to_discard = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    local deck_key = get_deck_key()
    
    if deck_key == 'timeline' then
        local current_chips = G.GAME.chips
        local previous_chips = G.GAME.odyssey_temp_chips or 0
        local hand_score = current_chips - previous_chips
        
        if hand_score > 0 then
            local to_store = math.floor(hand_score * 0.1)
            G.GAME.selected_back.effect.config.extra = G.GAME.selected_back.effect.config.extra or {}
            G.GAME.selected_back.effect.config.extra.stored_score = to_store
            
            -- Visual feedback
            card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {
                message = localize{type='variable', key='a_chips', vars={to_store}},
                colour = G.C.CHIPS
            })
        end
    end
    
    -- 51. Fractal: 5-of-a-Kind -> Clone card to deck
    -- We do this before cards are moved/destroyed
    if deck_key == 'fractal' then
         -- Identify if it was 5oak. Localizing text might be tricky, rely on internal name if possible?
         -- G.GAME.last_hand_played contains the text key?
         -- "Five of a Kind"
         -- We can check the cards count in scoring hand? context is not available here easily.
         -- But G.play.cards contains played cards.
         if #G.play.cards >= 5 then
            -- Rudimentary check: Are there 5 ranks same?
            -- Or just trust user? No.
            -- Check G.GAME.last_hand_played string (English key).
            -- This relies on game logic setting last_hand_played correctly before this function.
            -- Let's check G.GAME.hands[...].visible?
            
            -- Simplest: If 5 cards played, assume 5oak if they score?
            -- Actually, Flush House is 5 cards. Flush Five is 5 cards. 5oaK is 5 cards.
            -- If we just copy a card when 5 cards are played and they are all the same rank?
            local first_rank = G.play.cards[1].base.id
            local all_match = true
            for i=2, #G.play.cards do
                if G.play.cards[i].base.id ~= first_rank then all_match = false break end
            end
            
            if all_match and #G.play.cards >= 5 then
                 G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = copy_card(G.play.cards[1], nil, nil, G.playing_card)
                        card:add_to_deck()
                        G.deck:emplace(card)
                        card:start_materialize()
                        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                        return true
                    end
                }))
            end
         end
    end

    -- 53. Ghost: Return played cards to hand
    if deck_key == 'ghost' then
        local cards_to_return = {}
        for k, v in ipairs(G.play.cards) do
            cards_to_return[#cards_to_return+1] = v
        end
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                for i=1, #cards_to_return do
                    if cards_to_return[i]:is_face_down() then cards_to_return[i]:flip() end
                    draw_card(G.play, G.hand, 90, 'up', nil, cards_to_return[i])
                end
                return true
            end
        }))
        return -- Skip default discard
    end
    
    -- 54. Vampire: Destroy played cards, gain Mult
    if deck_key == 'vampire' then
        local played_count = #G.play.cards
        if played_count > 0 then
            G.GAME.selected_back.effect.config.extra = G.GAME.selected_back.effect.config.extra or {}
            local gain_per_card = G.GAME.selected_back.effect.config.extra.gain or 1
            local total_gain = played_count * gain_per_card
            
            G.GAME.selected_back.effect.config.extra.mult = (G.GAME.selected_back.effect.config.extra.mult or 0) + total_gain
            
            card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {
                message = localize{type='variable', key='a_mult', vars={total_gain}},
                colour = G.C.MULT
            })

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    for k, v in ipairs(G.play.cards) do
                        v:start_dissolve()
                    end
                    return true
                end
            }))
        end
        return -- Skip default discard behavior
    end
    
    -- 65. Volcanic: Discard entire hand (destroy or discard?) logic says "Descarta" (Discard).
    if deck_key == 'volcanic' then
        -- Trigger default discard for played cards
        
        -- And then trigger discard for HAND cards
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                -- Discard all cards in hand
                for i = #G.hand.cards, 1, -1 do
                    local card = G.hand.cards[i]
                    if not card.highlighted then -- if not highlighted (should be none highlighted after play)
                         draw_card(G.hand, G.discard, i*10, 'down', false, card)
                    end
                end
                return true
            end
        }))
        -- Default behavior for played cards continues
    end

    old_draw_from_play_to_discard(e)
end

-- 3. Game:update (For Supernova check? Or end_of_round)
local old_end_round = G.FUNCS.end_round
G.FUNCS.end_round = function()
    local deck_key = get_deck_key()

    -- Deck 9: Supernova (Money > 50 -> Reset to 0, X3 Mult)
    if deck_key == 'supernova_deck' then
        if G.GAME.dollars > 50 then
            G.GAME.dollars = 0
            G.GAME.selected_back.effect.config.extra = G.GAME.selected_back.effect.config.extra or {}
            G.GAME.selected_back.effect.config.extra.xmult = (G.GAME.selected_back.effect.config.extra.xmult or 1) + 3
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = "SUPERNOVA!", colour = G.C.RED})
                    return true
                end
            }))
        end
    end

    -- Deck 37: Avareza (Greed) - Gain $10 fixed
    if deck_key == 'avareza' then
        ease_dollars(10)
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('$')..'10', colour = G.C.MONEY})
    end

    -- 58. Mutant: Suits change every round
    if deck_key == 'mutant' then
         G.E_MANAGER:add_event(Event({
            func = function()
                local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
                for k, v in ipairs(G.playing_cards) do
                    local new_suit = suits[pseudorandom(pseudoseed('mutant')..v.base.id, 1, 4)]
                    v:change_suit(new_suit)
                end
                return true
            end
        }))
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('k_mutant_ex')})
    end

    -- 62. Radioactive: Rank Decay
    if deck_key == 'radioactive' and G.hand and G.hand.cards then
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(G.hand.cards) do
                    -- Check if not Ace (or 2 depending on logic). Let's say 2 is lowest.
                    if v.base.id > 2 then
                        local new_id = v.base.id - 1
                        -- Update card visual/value
                        local new_code = G.P_CARDS[string.sub(v.base.suit, 1, 1) .. '_' .. (G.id_def[new_id] or new_id)]
                        -- This P_CARDS lookup is tricky without utility.
                        -- Use internal helper if available or manually change base.
                        -- SMODS usually provides easy ways?
                        -- Trying manual base update approach
                         v.base.id = new_id
                         v.base.value = G.id_def[new_id] -- This might be a string like '2', 'K'
                         v:set_sprites(nil, v.config.card)
                    end
                end
                play_sound('timpani')
                card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('k_decay_ex')})
                return true
            end
        }))
    end

    old_end_round()
end

-- 4. Blind Skip (For Wormhole)
local old_skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    local deck_key = get_deck_key()
    
    if deck_key == 'wormhole' then
        -- Add Double Tag
        add_tag(Tag('tag_double'))
        card_eval_status_text(G.GAME.selected_back, 'extra', nil, nil, nil, {message = localize('k_double_tag'), colour = G.C.ATTENTION})
    end

    old_skip_blind(e)
end

-- 5. Interest (For Quasar)
-- Note: G.FUNCS.get_interest might not be global. It is usually local in Game.lua.
-- We might need to hook where it is used or check if it is exposed.
-- Actually, G.FUNCS are usually UI callbacks.
-- Interest is calculated in G.FUNCS.end_round usually.
-- Let's check if we can modify interest cap.
-- G.GAME.interest_cap is set in Game:start_run.
-- We can set it to 0 in apply() for Quasar.

-- 6. Poll Edition (For Dark Energy)
local old_poll_edition = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed)
    local deck_key = get_deck_key()
    if deck_key == 'dark_energy' and not _no_neg and not _guaranteed then
        -- 4x chance (approx 1.2%)
        if pseudorandom('dark_energy') < 0.012 then
            return {negative = true}
        end
    end
    return old_poll_edition(_key, _mod, _no_neg, _guaranteed)
end

-- 7. Reroll Shop (For Vacuum)
local old_reroll_shop = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(e)
    if get_deck_key() == 'vacuum' then
        play_sound('cancel')
        return
    end
    old_reroll_shop(e)
end

-- 8. Find Joker (For String Theory)
-- Fakes having a Shortcut joker to enable gap-of-1 straights
local old_find_joker = find_joker
function find_joker(key)
    local ret = old_find_joker(key)
    if key == 'Shortcut' and get_deck_key() == 'string_theory' then
        if not next(ret) then
            table.insert(ret, { ability = {} }) -- Dummy card object
        end
    end
    return ret
end


-- 9. Blind Scaling (For Paradox, Ascensao, Queda, Lucky II, Unlucky)
local old_get_blind_amount = get_blind_amount
function get_blind_amount(ante)
    local amount = old_get_blind_amount(ante)
    local deck_key = get_deck_key()
    
    if deck_key == 'paradox' then
        if ante > 0 then
             amount = amount * (1.5 ^ ante)
        end
    end

    if deck_key == 'ascensao' then
        amount = amount * 2
    end

    if deck_key == 'queda' then
        amount = amount * 0.5
    end

    if deck_key == 'lucky_ii' then
        amount = amount * 4
    end

    if deck_key == 'unlucky' then
        amount = amount * 0.25
    end
    
    return amount
end

-- 10. Card:calculate_seal (For Gravitational Deck repetition)
local old_calculate_seal = Card.calculate_seal
Card.calculate_seal = function(self, context)
    local ret = old_calculate_seal(self, context)
    
    local deck_key = get_deck_key()
    
    -- Deck 6: Gravitational (Retrigger first played card)
    if deck_key == 'gravitational' and context.repetition and context.cardarea == G.play then
        if self == G.play.cards[1] then
            if type(ret) ~= 'table' then ret = {} end
            ret.repetitions = (ret.repetitions or 0) + 1
            ret.message = localize('k_again_ex')
            ret.card = self
        end
    end
    
    return ret
end

-- =========================================================================
-- ADDITIONAL HOOKS FOR NEW Decks (41-100)
-- NOTE: These were previously dangling outside logic!
-- We need to move them INSIDE Card.calculate_joker or create a new hook.
-- Let's merge them into Card.calculate_joker above.
-- But wait, the file structure suggests they were pasted at the end of the file
-- OUTSIDE of any function.
-- They start with "if deck_key == 'lust' ...". 
-- 'deck_key' is local to function scopes above, so this would crash if run.
-- Unless... they were meant to be inside hook 1?

-- REFACTORED: Moving the stranded logic into the main calculate_joker hook.

-- (See below for actual insertion)
-- =========================================================================
                colour = G.C.MULT

-- (Ended dangling code removal)


-- 12. Card:can_sell_card (For Kraken)
local old_can_sell_card = Card.can_sell_card
Card.can_sell_card = function(self, context)
    -- First check if deck blocks it
    if get_deck_key() == 'kraken' and self.ability.set == 'Joker' then
         return false
    end
    
    -- Then check standard logic
    if old_can_sell_card then 
        return old_can_sell_card(self, context) 
    end
    return true
end

-- 13. Blind:debuff_card (For Ordered II)
local old_debuff_card = Blind.debuff_card
Blind.debuff_card = function(self, card, from_blind)
    if get_deck_key() == 'ordered_ii' then
        return false 
    end
    return old_debuff_card(self, card, from_blind)
end


-- 14. Card:set_cost (For Tech Deck)
local old_set_cost = Card.set_cost
Card.set_cost = function(self)
    old_set_cost(self)
    if G.GAME.modifiers and G.GAME.modifiers.odyssey_shop_price_mult and self.area and 
       (self.area == G.shop_jokers or self.area == G.shop_vouchers or self.area == G.shop_booster) then
        self.cost = math.floor(self.cost * G.GAME.modifiers.odyssey_shop_price_mult)
    end
end

-- 15. Card:set_ability (For Midas Deck)
local old_set_ability = Card.set_ability
Card.set_ability = function(self, center, initial, delay_sprites)
    old_set_ability(self, center, initial, delay_sprites)
    if G.GAME.modifiers and G.GAME.modifiers.odyssey_midas then
        if self.ability.set == 'Joker' then
            if not self.edition then
                self:set_edition({polychrome = true})
            end
        elseif self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
            if self.config.center ~= G.P_CENTERS.m_odyssey_plastic then
                self:set_ability(G.P_CENTERS.m_odyssey_plastic)
            end
        end
    end
end
