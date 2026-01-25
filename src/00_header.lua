-- Balatro Odyssey
-- A mod adding 1000 unique Jokers
-- Author: fenomelini
-- Version: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------
----------------------------------------------

-- Initialize the mod
SMODS.current_mod.config = SMODS.current_mod.config or {}
SMODS.current_mod.prefix = 'odyssey'

-- Global Mod Table
BalatroOdyssey = {}

----------------------------------------------
-- Odyssey Run Initialization
----------------------------------------------
-- Hook into game start run event
local game_start_run_ref = Game.start_run
function Game:start_run(args)
    -- FIX: Ensure global white color is pure white
    if G.C and G.C.WHITE then
        G.C.WHITE = {1, 1, 1, 1}
    end
    -- FIX: Reset love color state just in case
    if love and love.graphics then
        love.graphics.setColor(1, 1, 1, 1)
    end
    
    local ret = game_start_run_ref(self, args)
    
    -- Initialize Odyssey globals
    G.GAME.round_resets.consumeable_slots = G.GAME.round_resets.consumeable_slots or G.consumeables.config.card_limit
    G.GAME.round_resets.joker_slots = G.GAME.round_resets.joker_slots or G.jokers.config.card_limit
    G.GAME.round_resets.hand_size = G.GAME.round_resets.hand_size or G.hand.config.card_limit
    G.GAME.last_hand_time = G.TIMERS.REAL

    G.GAME.viking_destroyed_count = G.GAME.viking_destroyed_count or 0
    G.GAME.odyssey_king_of_kings_active = G.GAME.odyssey_king_of_kings_active or 0
    G.GAME.booster_choices = G.GAME.booster_choices or 0
    G.GAME.shop_spectral_count = G.GAME.shop_spectral_count or 0
    G.GAME.negative_rate = G.GAME.negative_rate or 0
    G.GAME.skip_reward_multiplier = G.GAME.skip_reward_multiplier or 1
    G.GAME.interest_rate = G.GAME.interest_rate or 0
    G.GAME.interest_mult = G.GAME.interest_mult or 1
    G.GAME.reveal_future_blinds = G.GAME.reveal_future_blinds or 0
    G.GAME.reveal_skip_rewards = G.GAME.reveal_skip_rewards or false
    G.GAME.odyssey_prev_round_1_hand = G.GAME.odyssey_prev_round_1_hand or false
    
    -- Tarot Temp Buffs
    G.GAME.warrior_chips = G.GAME.warrior_chips or 0
    G.GAME.magician_mult = G.GAME.magician_mult or 0
    G.GAME.rogue_x_mult = G.GAME.rogue_x_mult or 1
    G.GAME.bard_retrigger = G.GAME.bard_retrigger or 0
    
    return ret
end
----------------------------------------------
