-- Balatro Odyssey
-- A mod adding 1000 unique Jokers
-- Author: fenomelini
-- Version: 0.1.4-alpha

----------------------------------------------
------------MOD CODE -------------------------
----------------------------------------------

-- Initialize the mod
local mod = SMODS.current_mod
mod.config = mod.config or {}
mod.prefix = 'odyssey'

-- Global Mod Table for access from Lovely/Injector
BalatroOdyssey = {}
BalatroOdyssey.config = mod.config

-- Default config
if mod.config.hide_vanilla == nil then
    mod.config.hide_vanilla = true
end

-- Mod Settings Tab
mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, minw = 8, minh = 6 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.1 },
                nodes = {
                    {
                        n = G.UIT.T,
                        config = { text = localize('odyssey_config_title'), scale = 0.7, colour = G.C.GOLD, shadow = true }
                    }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.2 },
                nodes = {
                    create_toggle({
                        label = localize('odyssey_config_hide_vanilla'),
                        active_colour = G.C.BLUE,
                        w = 0,
                        ref_table = mod.config,
                        ref_value = 'hide_vanilla'
                    })
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.1 },
                nodes = {
                    {
                        n = G.UIT.T,
                        config = { text = localize('odyssey_config_hide_vanilla_desc'), scale = 0.35, colour = G.C.UI.TEXT_LIGHT }
                    }
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.1 },
                nodes = {
                    {
                        n = G.UIT.T,
                        config = { text = localize('odyssey_config_restart_warning'), scale = 0.4, colour = G.C.RED, shadow = true }
                    }
                }
            }
        }
    }
end

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
    
    -- Odyssey Goal: Defeat ALL 100 custom Boss Blinds
    G.GAME.win_ante = 100

    G.GAME.viking_destroyed_count = G.GAME.viking_destroyed_count or 0
    G.GAME.odyssey_king_of_kings_active = G.GAME.odyssey_king_of_kings_active or 0
    G.GAME.booster_choices = G.GAME.booster_choices or 0
    G.GAME.shop_spectral_count = G.GAME.shop_spectral_count or 0
    G.GAME.negative_rate = G.GAME.negative_rate or 0
    G.GAME.skip_reward_multiplier = G.GAME.skip_reward_multiplier or 1
    G.GAME.interest_rate = G.GAME.interest_rate or 0
    G.GAME.interest_mult = G.GAME.interest_mult or 1
    G.GAME.odyssey_pawn_shop_active = G.GAME.odyssey_pawn_shop_active or 0
    G.GAME.odyssey_curie_active = G.GAME.odyssey_curie_active or false
    G.GAME.odyssey_webb_active = G.GAME.odyssey_webb_active or false
    G.GAME.odyssey_hubble_active = G.GAME.odyssey_hubble_active or false
    G.GAME.reveal_future_blinds = G.GAME.reveal_future_blinds or 0
    G.GAME.reveal_skip_rewards = G.GAME.reveal_skip_rewards or false
    G.GAME.odyssey_prev_round_1_hand = G.GAME.odyssey_prev_round_1_hand or false
    
    -- Odyssey Shop Slots
    G.GAME.shop_extra_joker_slots = G.GAME.shop_extra_joker_slots or 0
    G.GAME.shop_extra_booster_slots = G.GAME.shop_extra_booster_slots or 0
    G.GAME.shop_extra_voucher_slots = G.GAME.shop_extra_voucher_slots or 0
    G.GAME.shop_extra_tarot_slots = G.GAME.shop_extra_tarot_slots or 0
    G.GAME.shop_extra_planet_slots = G.GAME.shop_extra_planet_slots or 0
    G.GAME.shop_extra_spectral_slots = G.GAME.shop_extra_spectral_slots or 0

    -- Tarot Temp Buffs
    G.GAME.warrior_chips = G.GAME.warrior_chips or 0
    G.GAME.magician_mult = G.GAME.magician_mult or 0
    G.GAME.rogue_x_mult = G.GAME.rogue_x_mult or 1
    G.GAME.bard_retrigger = G.GAME.bard_retrigger or 0
    
    return ret
end
----------------------------------------------
