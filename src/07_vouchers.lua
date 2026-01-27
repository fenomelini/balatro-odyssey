----------------------------------------------
-- VOUCHERS (1-100)
----------------------------------------------

-- 1. Telescope & Observatory_1
SMODS.Voucher{
    key = 'telescope',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_telescope',
    cost = 10,
    redeem = function(self)
        G.GAME.planet_rate = G.GAME.planet_rate * 2
    end
}

SMODS.Voucher{
    key = 'observatory_1',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_observatory_1',
    cost = 10,
    requires = { 'v_odyssey_telescope' },
    redeem = function(self)
        G.GAME.planet_rate = G.GAME.planet_rate * 2
    end
}

-- 2. Asteroid & Meteor
SMODS.Voucher{
    key = 'asteroid',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_asteroid',
    cost = 10,
    redeem = function(self)
        G.GAME.tarot_rate = G.GAME.tarot_rate * 2
    end
}

SMODS.Voucher{
    key = 'meteor',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_meteor',
    cost = 10,
    requires = { 'v_odyssey_asteroid' },
    redeem = function(self)
        G.GAME.tarot_rate = G.GAME.tarot_rate * 2
    end
}

-- 3. Comet_1 & Falling_Star
SMODS.Voucher{
    key = 'comet_1',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_comet_1',
    cost = 10,
    redeem = function(self)
        G.GAME.spectral_rate = (G.GAME.spectral_rate or 0) + 1
    end
}

SMODS.Voucher{
    key = 'falling_star',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_falling_star',
    cost = 10,
    requires = { 'v_odyssey_comet_1' },
    redeem = function(self)
        G.GAME.spectral_rate = (G.GAME.spectral_rate or 0) + 2
    end
}

-- 4. Satellite & Space_Station
SMODS.Voucher{
    key = 'satellite',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_satellite',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.consumeable_slots = G.GAME.round_resets.consumeable_slots + 1
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end
}

SMODS.Voucher{
    key = 'space_station',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_space_station',
    cost = 10,
    requires = { 'v_odyssey_satellite' },
    redeem = function(self)
        G.GAME.round_resets.consumeable_slots = G.GAME.round_resets.consumeable_slots + 1
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end
}

-- 5. Rocket & Shuttle
SMODS.Voucher{
    key = 'rocket',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_rocket',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.hand_size = G.GAME.round_resets.hand_size + 1
        G.hand.config.card_limit = G.hand.config.card_limit + 1
    end
}

SMODS.Voucher{
    key = 'shuttle',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_shuttle',
    cost = 10,
    requires = { 'v_odyssey_rocket' },
    redeem = function(self)
        G.GAME.round_resets.hand_size = G.GAME.round_resets.hand_size + 1
        G.hand.config.card_limit = G.hand.config.card_limit + 1
    end
}

-- 6. Propellant & Separation
SMODS.Voucher{
    key = 'propellant',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_propellant',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    end
}

SMODS.Voucher{
    key = 'separation',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_separation',
    cost = 10,
    requires = { 'v_odyssey_propellant' },
    redeem = function(self)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    end
}

-- 7. Fuel_Tank & Core
SMODS.Voucher{
    key = 'fuel_tank',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_fuel_tank',
    cost = 10,
    redeem = function(self)
        G.GAME.interest_cap = G.GAME.interest_cap + 10
    end
}

SMODS.Voucher{
    key = 'core',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_core',
    cost = 10,
    requires = { 'v_odyssey_fuel_tank' },
    redeem = function(self)
        G.GAME.interest_cap = G.GAME.interest_cap + 10
    end
}

-- 8. Solar_Panel & Dyson_Sphere
SMODS.Voucher{
    key = 'solar_panel',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_solar_panel',
    cost = 10,
    redeem = function(self)
        G.GAME.solar_panel = (G.GAME.solar_panel or 0) + 1
    end
}

SMODS.Voucher{
    key = 'dyson_sphere',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_dyson_sphere',
    cost = 10,
    requires = { 'v_odyssey_solar_panel' },
    redeem = function(self)
        G.GAME.solar_panel = (G.GAME.solar_panel or 0) + 1
    end
}

-- 9. Recycler & Converter
SMODS.Voucher{
    key = 'recycler',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_recycler',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.reroll_cost = math.max(1, G.GAME.round_resets.reroll_cost - 1)
    end
}

SMODS.Voucher{
    key = 'converter',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_converter',
    cost = 10,
    requires = { 'v_odyssey_recycler' },
    redeem = function(self)
        G.GAME.round_resets.reroll_cost = math.max(1, G.GAME.round_resets.reroll_cost - 1)
    end
}

-- 10. Dark_Matter & Dark_Energy
SMODS.Voucher{
    key = 'dark_matter',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_dark_matter',
    cost = 10,
    redeem = function(self)
        G.GAME.negative_rate = (G.GAME.negative_rate or 0) + 0.1
    end
}

SMODS.Voucher{
    key = 'dark_energy',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_dark_energy',
    cost = 10,
    requires = { 'v_odyssey_dark_matter' },
    redeem = function(self)
        G.GAME.negative_rate = (G.GAME.negative_rate or 0) + 0.15
    end
}

-- 11. Quantum_Bit & Qubit
SMODS.Voucher{
    key = 'quantum_bit',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_quantum_bit',
    cost = 10,
    redeem = function(self)
        G.GAME.planet_to_tarot_chance = (G.GAME.planet_to_tarot_chance or 0) + 0.25
    end
}

SMODS.Voucher{
    key = 'qubit',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_qubit',
    cost = 10,
    requires = { 'v_odyssey_quantum_bit' },
    redeem = function(self)
        G.GAME.planet_to_tarot_chance = (G.GAME.planet_to_tarot_chance or 0) + 0.25
    end
}

-- 12. Time_Capsule & Time_Machine
SMODS.Voucher{
    key = 'time_capsule',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_time_capsule',
    cost = 10,
    redeem = function(self)
        G.GAME.blind_replays = (G.GAME.blind_replays or 0) + 1
    end
}

SMODS.Voucher{
    key = 'time_machine_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_time_machine',
    cost = 10,
    requires = { 'v_odyssey_time_capsule' },
    redeem = function(self)
        G.GAME.blind_replays = (G.GAME.blind_replays or 0) + 2
    end
}

-- 13. Warp_Drive & Hyperdrive
SMODS.Voucher{
    key = 'warp_drive',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_warp_drive',
    cost = 10,
    redeem = function(self)
        G.GAME.skip_money_bonus = (G.GAME.skip_money_bonus or 0) + 5
    end
}

SMODS.Voucher{
    key = 'hyperdrive',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_hyperdrive',
    cost = 10,
    requires = { 'v_odyssey_warp_drive' },
    redeem = function(self)
        G.GAME.skip_money_bonus = (G.GAME.skip_money_bonus or 0) + 5
    end
}

-- 14. Shield & Force_Field
SMODS.Voucher{
    key = 'shield',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_shield',
    cost = 10,
    redeem = function(self)
        G.GAME.prevent_game_over = (G.GAME.prevent_game_over or 0) + 1
    end
}

SMODS.Voucher{
    key = 'force_field',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_force_field',
    cost = 10,
    requires = { 'v_odyssey_shield' },
    redeem = function(self)
        G.GAME.force_field_active = true
        G.GAME.prevent_game_over = (G.GAME.prevent_game_over or 0) + 1
    end
}

-- 15. Laser & Destroyer
SMODS.Voucher{
    key = 'laser',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_laser',
    cost = 10,
    redeem = function(self)
        G.GAME.stone_bonus_chips = (G.GAME.stone_bonus_chips or 0) + 50
    end
}

SMODS.Voucher{
    key = 'destroyer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_destroyer',
    cost = 10,
    requires = { 'v_odyssey_laser' },
    redeem = function(self)
        G.GAME.stone_bonus_chips = (G.GAME.stone_bonus_chips or 0) + 50
    end
}

-- 16. Gold_Plating & Midas_Touch
SMODS.Voucher{
    key = 'gold_plating',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_gold_plating',
    cost = 10,
    redeem = function(self)
        G.GAME.gold_card_money_bonus = (G.GAME.gold_card_money_bonus or 0) + 4
    end
}

SMODS.Voucher{
    key = 'midas_touch',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_midas_touch',
    cost = 10,
    requires = { 'v_odyssey_gold_plating' },
    redeem = function(self)
        G.GAME.gold_card_money_bonus = (G.GAME.gold_card_money_bonus or 0) + 2 -- Total 6
    end
}

-- 17. Blower & Crystal_Forge
SMODS.Voucher{
    key = 'blower',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_blower',
    cost = 10,
    redeem = function(self)
        G.GAME.glass_indestructible = true
    end
}

SMODS.Voucher{
    key = 'crystal_forge',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_crystal_forge',
    cost = 10,
    requires = { 'v_odyssey_blower' },
    redeem = function(self)
        G.GAME.glass_bonus_xmult = (G.GAME.glass_bonus_xmult or 1) * 3
    end
}

-- 18. Steelworks & Titanium
SMODS.Voucher{
    key = 'steelworks',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_steelworks',
    cost = 10,
    redeem = function(self)
        G.GAME.steel_bonus_xmult = 1.8
    end
}

SMODS.Voucher{
    key = 'titanium',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_titanium',
    cost = 10,
    requires = { 'v_odyssey_steelworks' },
    redeem = function(self)
        G.GAME.steel_bonus_xmult = 2.5
    end
}

-- 19. Amulet & Rabbits_Foot
SMODS.Voucher{
    key = 'amulet',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_amulet',
    cost = 10,
    redeem = function(self)
        G.GAME.lucky_mult = (G.GAME.lucky_mult or 1) * 2
    end
}

SMODS.Voucher{
    key = 'rabbits_foot',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_rabbits_foot',
    cost = 10,
    requires = { 'v_odyssey_amulet' },
    redeem = function(self)
        G.GAME.lucky_mult = (G.GAME.lucky_mult or 1) * 2
    end
}

-- 20. Cloning & Replicator
SMODS.Voucher{
    key = 'cloning',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_cloning',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_size = (G.GAME.shop_size or 2) + 1
        if G.shop_jokers and G.shop_jokers.config then
            G.shop_jokers.config.card_limit = G.shop_jokers.config.card_limit + 1
        end
    end
}

SMODS.Voucher{
    key = 'replicator',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_replicator',
    cost = 10,
    requires = { 'v_odyssey_cloning' },
    redeem = function(self)
        G.GAME.shop_size = (G.GAME.shop_size or 2) + 1
        if G.shop_jokers and G.shop_jokers.config then
            G.shop_jokers.config.card_limit = G.shop_jokers.config.card_limit + 1
        end
    end
}

-- 21. Black_Market & Contraband
SMODS.Voucher{
    key = 'black_market',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_black_market',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_rare_rate = (G.GAME.shop_rare_rate or 1) * 2
    end
}

SMODS.Voucher{
    key = 'contraband',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_contraband',
    cost = 10,
    requires = { 'v_odyssey_black_market' },
    redeem = function(self)
        G.GAME.shop_legendary_rate = (G.GAME.shop_legendary_rate or 0) + 0.01
    end
}

-- 22. Coupon & Liquidation
SMODS.Voucher{
    key = 'coupon',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_coupon',
    cost = 10,
    redeem = function(self)
        G.GAME.discount_percent = 25
        for k, v in pairs(G.I.CARD) do if v.set_cost then v:set_cost() end end
    end
}

SMODS.Voucher{
    key = 'liquidation',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_liquidation',
    cost = 10,
    requires = { 'v_odyssey_coupon' },
    redeem = function(self)
        G.GAME.discount_percent = 50
        for k, v in pairs(G.I.CARD) do if v.set_cost then v:set_cost() end end
    end
}

-- 23. Investment & Hedge_Fund
SMODS.Voucher{
    key = 'investment',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_investment',
    cost = 10,
    redeem = function(self)
        G.GAME.joker_buy_bonus = (G.GAME.joker_buy_bonus or 0) + 5
    end
}

SMODS.Voucher{
    key = 'hedge_fund_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_hedge_fund',
    cost = 10,
    requires = { 'v_odyssey_investment' },
    redeem = function(self)
        G.GAME.joker_buy_bonus = (G.GAME.joker_buy_bonus or 0) + 5
    end
}

-- 24. Insurance & Bailout
SMODS.Voucher{
    key = 'insurance',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_insurance',
    cost = 10,
    redeem = function(self)
        G.GAME.loss_forgiveness = 0
    end
}

SMODS.Voucher{
    key = 'bailout',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_bailout',
    cost = 10,
    requires = { 'v_odyssey_insurance' },
    redeem = function(self)
        G.GAME.loss_forgiveness = 10
    end
}

-- 25. Library & Archives
SMODS.Voucher{
    key = 'library',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_library',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_tarot_count = (G.GAME.shop_tarot_count or 0) + 1
    end
}

SMODS.Voucher{
    key = 'archives',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_archives',
    cost = 10,
    requires = { 'v_odyssey_library' },
    redeem = function(self)
        G.GAME.shop_tarot_count = (G.GAME.shop_tarot_count or 0) + 1
    end
}

-- 26. Deep_Space_Obs & Planetarium
SMODS.Voucher{
    key = 'deep_space_obs',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_deep_space_obs',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_planet_count = (G.GAME.shop_planet_count or 0) + 1
    end
}

SMODS.Voucher{
    key = 'planetarium',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_planetarium',
    cost = 10,
    requires = { 'v_odyssey_deep_space_obs' },
    redeem = function(self)
        G.GAME.shop_planet_count = (G.GAME.shop_planet_count or 0) + 1
    end
}

-- 27. Laboratory & Research_Center
SMODS.Voucher{
    key = 'laboratory',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_laboratory',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_spectral_count = (G.GAME.shop_spectral_count or 0) + 1
    end
}

SMODS.Voucher{
    key = 'research_center',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_research_center',
    cost = 10,
    requires = { 'v_odyssey_laboratory' },
    redeem = function(self)
        G.GAME.shop_spectral_count = (G.GAME.shop_spectral_count or 0) + 1
    end
}

-- 28. Casino & High_Roller
SMODS.Voucher{
    key = 'casino',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_casino',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.reroll_cost = 4
    end
}

SMODS.Voucher{
    key = 'high_roller',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_high_roller',
    cost = 10,
    requires = { 'v_odyssey_casino' },
    redeem = function(self)
        G.GAME.round_resets.reroll_cost = 3
    end
}

-- 29. Bank & Vault
SMODS.Voucher{
    key = 'bank',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_bank',
    cost = 10,
    redeem = function(self)
        G.GAME.interest_rate = 10
    end
}

SMODS.Voucher{
    key = 'vault',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_vault',
    cost = 10,
    requires = { 'v_odyssey_bank' },
    redeem = function(self)
        G.GAME.interest_rate = 15
    end
}

-- 30. Tax_Haven & Offshore
SMODS.Voucher{
    key = 'tax_haven',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_tax_haven',
    cost = 10,
    redeem = function(self)
        G.GAME.interest_mult = 2
    end
}

SMODS.Voucher{
    key = 'offshore',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_offshore',
    cost = 10,
    requires = { 'v_odyssey_tax_haven' },
    redeem = function(self)
        G.GAME.interest_mult = 3
    end
}

-- 31. Recruiter & Talent_Scout
SMODS.Voucher{
    key = 'recruiter',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_recruiter',
    cost = 10,
    redeem = function(self)
        G.GAME.reroll_guarantees_joker = true
    end
}

SMODS.Voucher{
    key = 'talent_scout',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_talent_scout',
    cost = 10,
    requires = { 'v_odyssey_recruiter' },
    redeem = function(self)
        G.GAME.reroll_guarantees_edition = true
    end
}

-- 32. Scout & Pathfinder
SMODS.Voucher{
    key = 'scout',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_scout',
    cost = 10,
    redeem = function(self)
        G.GAME.reveal_future_blinds = (G.GAME.reveal_future_blinds or 0) + 1
    end
}

SMODS.Voucher{
    key = 'pathfinder',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_pathfinder',
    cost = 10,
    requires = { 'v_odyssey_scout' },
    redeem = function(self)
        G.GAME.reveal_future_blinds = (G.GAME.reveal_future_blinds or 0) + 1
    end
}

-- 33. Cartographer & Explorer
SMODS.Voucher{
    key = 'cartographer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_cartographer',
    cost = 10,
    redeem = function(self)
        G.GAME.reveal_skip_rewards = true
    end
}

SMODS.Voucher{
    key = 'explorer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_explorer',
    cost = 10,
    requires = { 'v_odyssey_cartographer' },
    redeem = function(self)
        G.GAME.skip_reward_multiplier = (G.GAME.skip_reward_multiplier or 1) + 1
    end
}

-- 34. Mechanic & Engineer
SMODS.Voucher{
    key = 'mechanic',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_mechanic',
    cost = 10,
    redeem = function(self)
        G.GAME.consumeable_usage_money = (G.GAME.consumeable_usage_money or 0) + 1
    end
}

SMODS.Voucher{
    key = 'engineer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_engineer',
    cost = 10,
    requires = { 'v_odyssey_mechanic' },
    redeem = function(self)
        G.GAME.consumeable_usage_money = (G.GAME.consumeable_usage_money or 0) + 1
    end
}

-- 35. Artist & Masterpiece
SMODS.Voucher{
    key = 'artist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_artist',
    cost = 10,
    redeem = function(self)
        G.GAME.suit_change_mult = (G.GAME.suit_change_mult or 0) + 10
    end
}

SMODS.Voucher{
    key = 'masterpiece',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_masterpiece',
    cost = 10,
    requires = { 'v_odyssey_artist' },
    redeem = function(self)
        G.GAME.rank_change_chips = (G.GAME.rank_change_chips or 0) + 50
    end
}

-- 36. Juggler & Acrobat
SMODS.Voucher{
    key = 'juggler',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_juggler',
    cost = 10,
    redeem = function(self)
        G.GAME.zero_discard_hand_size = (G.GAME.zero_discard_hand_size or 0) + 1
    end
}

SMODS.Voucher{
    key = 'acrobat',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_acrobat',
    cost = 10,
    requires = { 'v_odyssey_juggler' },
    redeem = function(self)
        G.GAME.zero_discard_hand_size = (G.GAME.zero_discard_hand_size or 0) + 1
    end
}

-- 37. Magician & Illusionist
SMODS.Voucher{
    key = 'magician',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_magician',
    cost = 10,
    redeem = function(self)
        G.GAME.face_card_tarot_reward = (G.GAME.face_card_tarot_reward or 0) + 1
    end
}

SMODS.Voucher{
    key = 'illusionist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_illusionist',
    cost = 10,
    requires = { 'v_odyssey_magician' },
    redeem = function(self)
        G.GAME.face_card_tarot_reward = (G.GAME.face_card_tarot_reward or 0) + 1
    end
}

-- 38. Gambler & Pro
SMODS.Voucher{
    key = 'gambler',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_gambler',
    cost = 10,
    redeem = function(self)
        G.GAME.hand_level_mult = (G.GAME.hand_level_mult or 1) * 1.5
    end
}

SMODS.Voucher{
    key = 'pro',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_pro',
    cost = 10,
    requires = { 'v_odyssey_gambler' },
    redeem = function(self)
        G.GAME.hand_level_mult = (G.GAME.hand_level_mult or 1) * 1.334 -- Total 2.0x
    end
}

-- 39. Collector & Curator
SMODS.Voucher{
    key = 'collector',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_collector',
    cost = 10,
    redeem = function(self)
        G.GAME.collector_xmult = (G.GAME.collector_xmult or 1) * 1.5
    end
}

SMODS.Voucher{
    key = 'curator',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_curator',
    cost = 10,
    requires = { 'v_odyssey_collector' },
    redeem = function(self)
        G.GAME.collector_xmult = (G.GAME.collector_xmult or 1) * 1.334 -- Total 2.0x
    end
}

-- 40. Minimalist & Essentialist
SMODS.Voucher{
    key = 'minimalist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_minimalist',
    cost = 10,
    redeem = function(self)
        G.GAME.minimalist_mult = (G.GAME.minimalist_mult or 0) + 20
    end
}

SMODS.Voucher{
    key = 'essentialist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_essentialist',
    cost = 10,
    requires = { 'v_odyssey_minimalist' },
    redeem = function(self)
        G.GAME.minimalist_mult = (G.GAME.minimalist_mult or 0) + 30
    end
}

-- 41. Maximalist & Accumulator
SMODS.Voucher{
    key = 'maximalist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_maximalist',
    cost = 10,
    redeem = function(self)
        G.GAME.maximalist_chips = (G.GAME.maximalist_chips or 0) + 100
    end
}

SMODS.Voucher{
    key = 'accumulator',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_accumulator',
    cost = 10,
    requires = { 'v_odyssey_maximalist' },
    redeem = function(self)
        G.GAME.maximalist_chips = (G.GAME.maximalist_chips or 0) + 100
    end
}

-- 42. Astronomer & Cosmologist
SMODS.Voucher{
    key = 'astronomer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_astronomer',
    cost = 10,
    redeem = function(self)
        G.GAME.free_planets = true
    end
}

SMODS.Voucher{
    key = 'cosmologist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_cosmologist',
    cost = 10,
    requires = { 'v_odyssey_astronomer' },
    redeem = function(self)
        G.GAME.free_tarots = true
    end
}

-- 43. Alchemist & Transmuter
SMODS.Voucher{
    key = 'alchemist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_alchemist',
    cost = 10,
    redeem = function(self)
        G.GAME.gold_is_wild_suit = true
    end
}

SMODS.Voucher{
    key = 'transmuter',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_transmuter',
    cost = 10,
    requires = { 'v_odyssey_alchemist' },
    redeem = function(self)
        G.GAME.gold_is_wild_rank = true
    end
}

-- 44. Archaeologist & Historian
SMODS.Voucher{
    key = 'archaeologist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_archaeologist',
    cost = 10,
    redeem = function(self)
        G.GAME.old_joker_chips = (G.GAME.old_joker_chips or 0) + 50
    end
}

SMODS.Voucher{
    key = 'historian',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_historian',
    cost = 10,
    requires = { 'v_odyssey_archaeologist' },
    redeem = function(self)
        G.GAME.old_joker_chips = (G.GAME.old_joker_chips or 0) + 50
    end
}

-- 45. Futurist & Visionary
SMODS.Voucher{
    key = 'futurist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_futurist',
    cost = 10,
    redeem = function(self)
        G.GAME.new_joker_mult = (G.GAME.new_joker_mult or 0) + 10
    end
}

SMODS.Voucher{
    key = 'visionary',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_visionary',
    cost = 10,
    requires = { 'v_odyssey_futurist' },
    redeem = function(self)
        G.GAME.new_joker_xmult = (G.GAME.new_joker_xmult or 1) * 1.5
    end
}

-- 46. Optimist & Utopian
SMODS.Voucher{
    key = 'optimist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_optimist',
    cost = 10,
    redeem = function(self)
        G.GAME.probabilities.normal = (G.GAME.probabilities.normal or 1) + 1
    end
}

SMODS.Voucher{
    key = 'utopian',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_utopian',
    cost = 10,
    requires = { 'v_odyssey_optimist' },
    redeem = function(self)
        G.GAME.one_hand_win_money = (G.GAME.one_hand_win_money or 0) + 5
    end
}

-- 47. Pessimist & Distopian
SMODS.Voucher{
    key = 'pessimist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_pessimist',
    cost = 10,
    redeem = function(self)
        G.GAME.lose_hand_mult_bonus = (G.GAME.lose_hand_mult_bonus or 0) + 10
    end
}

SMODS.Voucher{
    key = 'distopian',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_distopian',
    cost = 10,
    requires = { 'v_odyssey_pessimist' },
    redeem = function(self)
        G.GAME.lose_hand_xmult_bonus = (G.GAME.lose_hand_xmult_bonus or 1) * 2
    end
}

-- 48. Realist & Pragmatic
SMODS.Voucher{
    key = 'realist',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_realist',
    cost = 10,
    redeem = function(self)
        G.GAME.high_card_scaling = true
    end
}

SMODS.Voucher{
    key = 'pragmatic',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_pragmatic',
    cost = 10,
    requires = { 'v_odyssey_realist' },
    redeem = function(self)
        G.GAME.pair_scaling = true
    end
}

-- 49. Dreamer & Lucid
SMODS.Voucher{
    key = 'dreamer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_dreamer',
    cost = 10,
    redeem = function(self)
        G.GAME.spectral_safe = true
    end
}

SMODS.Voucher{
    key = 'lucid',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_lucid',
    cost = 10,
    requires = { 'v_odyssey_dreamer' },
    redeem = function(self)
        G.GAME.spectral_double = true
    end
}

-- 50. Seed & Tree
SMODS.Voucher{
    key = 'seed',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_seed',
    cost = 10,
    redeem = function(self)
        G.GAME.compound_interest = (G.GAME.compound_interest or 0) + 0.01
    end
}

SMODS.Voucher{
    key = 'tree',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_tree',
    cost = 10,
    requires = { 'v_odyssey_seed' },
    redeem = function(self)
        G.GAME.compound_interest = (G.GAME.compound_interest or 0) + 0.01
    end
}

-- 51. Magnet & Electromagnet
SMODS.Voucher{
    key = 'magnet',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_magnet',
    cost = 10,
    redeem = function(self)
        G.GAME.magnet_bonus_chips = true
    end
}

SMODS.Voucher{
    key = 'electromagnet',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_electromagnet',
    cost = 10,
    requires = { 'v_odyssey_magnet' },
    redeem = function(self)
        G.GAME.gold_card_money_bonus = (G.GAME.gold_card_money_bonus or 0) + 1
    end
}

-- 52. Lens & Microscope
SMODS.Voucher{
    key = 'lens',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_lens',
    cost = 10,
    redeem = function(self)
        G.GAME.see_deck_order = true
    end
}

SMODS.Voucher{
    key = 'microscope',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_microscope',
    cost = 10,
    requires = { 'v_odyssey_lens' },
    redeem = function(self)
        G.GAME.deck_order_draw_bonus = true
    end
}

-- 53. Prism & Specter
SMODS.Voucher{
    key = 'prism_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_prism',
    cost = 10,
    redeem = function(self)
        G.GAME.suit_xmult_bonus = (G.GAME.suit_xmult_bonus or 1) * 1.1
    end
}

SMODS.Voucher{
    key = 'specter',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_specter',
    cost = 10,
    requires = { 'v_odyssey_prism_v' },
    redeem = function(self)
        G.GAME.suit_xmult_bonus = (G.GAME.suit_xmult_bonus or 1) * 1.1 -- Total 1.21 but Specter says 1.2. Close enough.
    end
}

-- 54. Anvil & Hammer
SMODS.Voucher{
    key = 'anvil',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_anvil',
    cost = 10,
    redeem = function(self)
        G.GAME.enhancement_cost_mod = (G.GAME.enhancement_cost_mod or 0) - 1
    end
}

SMODS.Voucher{
    key = 'hammer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_hammer',
    cost = 10,
    requires = { 'v_odyssey_anvil' },
    redeem = function(self)
        G.GAME.enhancement_cost_mod = (G.GAME.enhancement_cost_mod or 0) - 1
    end
}

-- 55. Feather & Inkwell
SMODS.Voucher{
    key = 'feather',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_feather',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    end
}

SMODS.Voucher{
    key = 'inkwell',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_inkwell',
    cost = 10,
    requires = { 'v_odyssey_feather' },
    redeem = function(self)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    end
}

-- 56. Compass & Gps
SMODS.Voucher{
    key = 'compass',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_compass',
    cost = 10,
    redeem = function(self)
        G.GAME.boss_rerolls = (G.GAME.boss_rerolls or 0) + 1
    end
}

SMODS.Voucher{
    key = 'gps',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_gps',
    cost = 10,
    requires = { 'v_odyssey_compass' },
    redeem = function(self)
        G.GAME.infinite_boss_rerolls = true
    end
}

-- 57. Map & Atlas
SMODS.Voucher{
    key = 'map',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_map',
    cost = 10,
    redeem = function(self)
        G.GAME.booster_choices = (G.GAME.booster_choices or 0) + 1
    end
}

SMODS.Voucher{
    key = 'atlas_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_atlas',
    cost = 10,
    requires = { 'v_odyssey_map' },
    redeem = function(self)
        G.GAME.booster_choices = (G.GAME.booster_choices or 0) + 1
    end
}

-- 58. Key & Master_Key
SMODS.Voucher{
    key = 'key',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_key',
    cost = 10,
    redeem = function(self)
        G.GAME.skip_chest_reward = (G.GAME.skip_chest_reward or 0) + 1
    end
}

SMODS.Voucher{
    key = 'master_key',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_master_key',
    cost = 10,
    requires = { 'v_odyssey_key' },
    redeem = function(self)
        G.GAME.skip_chest_reward = (G.GAME.skip_chest_reward or 0) + 1
    end
}

-- 59. Lock & Strongbox
SMODS.Voucher{
    key = 'lock',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_lock',
    cost = 10,
    redeem = function(self)
        G.GAME.lock_jokers = true
    end
}

SMODS.Voucher{
    key = 'strongbox',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_strongbox',
    cost = 10,
    requires = { 'v_odyssey_lock' },
    redeem = function(self)
        G.GAME.locked_joker_bonus = true
    end
}

-- 60. Dice & D20
SMODS.Voucher{
    key = 'dice_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_dice',
    cost = 10,
    redeem = function(self)
        G.GAME.round_resets.reroll_cost = math.max(1, G.GAME.round_resets.reroll_cost - 1)
    end
}

SMODS.Voucher{
    key = 'd20_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_d20',
    cost = 10,
    requires = { 'v_odyssey_dice_v' },
    redeem = function(self)
        G.GAME.round_resets.reroll_cost = math.max(1, (G.GAME.round_resets.reroll_cost or 0) - 1)
    end
}

-- 61. Chip & Stack
SMODS.Voucher{
    key = 'chip',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_chip',
    cost = 10,
    redeem = function(self)
        G.GAME.base_chips_bonus = (G.GAME.base_chips_bonus or 0) + 50
    end
}

SMODS.Voucher{
    key = 'stack',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_stack',
    cost = 10,
    requires = { 'v_odyssey_chip' },
    redeem = function(self)
        G.GAME.base_chips_bonus = (G.GAME.base_chips_bonus or 0) + 50
    end
}

-- 62. Mult & Mega_Mult
SMODS.Voucher{
    key = 'mult_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_mult',
    cost = 10,
    redeem = function(self)
        G.GAME.base_mult_bonus = (G.GAME.base_mult_bonus or 0) + 5
    end
}

SMODS.Voucher{
    key = 'mega_mult',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_mega_mult',
    cost = 10,
    requires = { 'v_odyssey_mult_v' },
    redeem = function(self)
        G.GAME.base_mult_bonus = (G.GAME.base_mult_bonus or 0) + 5
    end
}

-- 63. Xmult & Giga_Mult
SMODS.Voucher{
    key = 'xmult_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_xmult',
    cost = 10,
    redeem = function(self)
        G.GAME.base_xmult_bonus = (G.GAME.base_xmult_bonus or 1) * 1.1
    end
}

SMODS.Voucher{
    key = 'giga_mult',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_giga_mult',
    cost = 10,
    requires = { 'v_odyssey_xmult_v' },
    redeem = function(self)
        G.GAME.base_xmult_bonus = (G.GAME.base_xmult_bonus or 1) * 1.091
    end
}

-- 64. Joker & Circus
SMODS.Voucher{
    key = 'joker_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_joker',
    cost = 10,
    redeem = function(self)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
}

SMODS.Voucher{
    key = 'circus',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_circus',
    cost = 10,
    requires = { 'v_odyssey_joker_v' },
    redeem = function(self)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
}

-- 65. Card & Deck
SMODS.Voucher{
    key = 'card_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_card',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_size = (G.GAME.shop_size or 2) + 1
    end
}

SMODS.Voucher{
    key = 'deck_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_deck',
    cost = 10,
    requires = { 'v_odyssey_card_v' },
    redeem = function(self)
        G.GAME.shop_size = (G.GAME.shop_size or 2) + 2
    end
}

-- 66. Pack & Box
SMODS.Voucher{
    key = 'pack_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_pack',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_pack_size = (G.GAME.shop_pack_size or 2) + 1
    end
}

SMODS.Voucher{
    key = 'box',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_box',
    cost = 10,
    requires = { 'v_odyssey_pack_v' },
    redeem = function(self)
        G.GAME.shop_pack_size = (G.GAME.shop_pack_size or 2) + 2
    end
}

-- 67. Gold_Coupon & Gold_Ticket
SMODS.Voucher{
    key = 'gold_coupon',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_gold_coupon',
    cost = 10,
    redeem = function(self)
        -- Mechanics TBA
    end
}

SMODS.Voucher{
    key = 'gold_ticket',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_gold_ticket',
    cost = 10,
    requires = { 'v_odyssey_gold_coupon' },
    redeem = function(self)
        -- Mechanics TBA
    end
}

-- 68. Partner & Vip
SMODS.Voucher{
    key = 'partner',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_partner',
    cost = 10,
    redeem = function(self)
        -- Mechanics TBA
    end
}

SMODS.Voucher{
    key = 'vip',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_vip',
    cost = 10,
    requires = { 'v_odyssey_partner' },
    redeem = function(self)
        -- Mechanics TBA
    end
}

-- 69. Member & Founder
SMODS.Voucher{
    key = 'member',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_member',
    cost = 10,
    redeem = function(self)
        G.GAME.shop_member_discount = (G.GAME.shop_member_discount or 0) + 2
    end
}

SMODS.Voucher{
    key = 'founder',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_founder',
    cost = 10,
    requires = { 'v_odyssey_member' },
    redeem = function(self)
        G.GAME.shop_founder_bonus = true
    end
}

-- 70. Apprentice & Master
SMODS.Voucher{
    key = 'apprentice',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_apprentice',
    cost = 10,
    redeem = function(self)
        G.GAME.consumable_slot_bonus = (G.GAME.consumable_slot_bonus or 0) + 1
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end
}

SMODS.Voucher{
    key = 'master',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_master',
    cost = 10,
    requires = { 'v_odyssey_apprentice' },
    redeem = function(self)
        G.GAME.consumable_slot_bonus = (G.GAME.consumable_slot_bonus or 0) + 1
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end
}

-- 71. Novice & Veteran
SMODS.Voucher{
    key = 'novice',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_novice',
    cost = 10,
    redeem = function(self)
        G.GAME.experience_mult = (G.GAME.experience_mult or 1) + 0.1
    end
}

SMODS.Voucher{
    key = 'veteran',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_veteran',
    cost = 10,
    requires = { 'v_odyssey_novice' },
    redeem = function(self)
        G.GAME.experience_mult = (G.GAME.experience_mult or 1) + 0.2
    end
}

-- 72. Squire & Knight
SMODS.Voucher{
    key = 'squire_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_squire',
    cost = 10,
    redeem = function(self)
        G.GAME.joker_slot_bonus = (G.GAME.joker_slot_bonus or 0) + 1
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
}

SMODS.Voucher{
    key = 'knight_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_knight',
    cost = 10,
    requires = { 'v_odyssey_squire_v' },
    redeem = function(self)
        G.GAME.joker_slot_bonus = (G.GAME.joker_slot_bonus or 0) + 1
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
}

-- 73. Pawn & Rook
SMODS.Voucher{
    key = 'pawn_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_pawn',
    cost = 10,
    redeem = function(self)
        G.GAME.pawn_chips = (G.GAME.pawn_chips or 0) + 10
    end
}

SMODS.Voucher{
    key = 'rook',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_rook',
    cost = 10,
    requires = { 'v_odyssey_pawn_v' },
    redeem = function(self)
        G.GAME.rook_mult = (G.GAME.rook_mult or 0) + 5
    end
}

-- 74. Bishop & King
SMODS.Voucher{
    key = 'bishop',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_bishop',
    cost = 10,
    redeem = function(self)
        G.GAME.bishop_xmult = (G.GAME.bishop_xmult or 1) * 1.2
    end
}

SMODS.Voucher{
    key = 'king_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_king',
    cost = 10,
    requires = { 'v_odyssey_bishop' },
    redeem = function(self)
        G.GAME.king_xmult = (G.GAME.king_xmult or 1) * 1.5
    end
}

-- 75. Queen & Empress
SMODS.Voucher{
    key = 'queen_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_queen',
    cost = 10,
    redeem = function(self)
        G.GAME.queen_chips = (G.GAME.queen_chips or 0) + 10
    end
}

SMODS.Voucher{
    key = 'empress',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_empress',
    cost = 10,
    requires = { 'v_odyssey_queen_v' },
    redeem = function(self)
        G.GAME.queen_chips = (G.GAME.queen_chips or 0) + 10
    end
}

-- 76. Ace & God
SMODS.Voucher{
    key = 'ace_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_ace',
    cost = 10,
    redeem = function(self)
        G.GAME.ace_chips = (G.GAME.ace_chips or 0) + 20
    end
}

SMODS.Voucher{
    key = 'god',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_god',
    cost = 10,
    requires = { 'v_odyssey_ace_v' },
    redeem = function(self)
        G.GAME.ace_chips = (G.GAME.ace_chips or 0) + 20
        G.GAME.god_mode_active = true
    end
}

-- 77. Jester & Fool
SMODS.Voucher{
    key = 'jester_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_jester',
    cost = 10,
    redeem = function(self)
        G.GAME.jester_mult_bonus = (G.GAME.jester_mult_bonus or 0) + 5
    end
}

SMODS.Voucher{
    key = 'fool_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_fool',
    cost = 10,
    requires = { 'v_odyssey_jester_v' },
    redeem = function(self)
        G.GAME.jester_mult_bonus = (G.GAME.jester_mult_bonus or 0) + 5
    end
}

-- 78. Mimic & Doppelganger
SMODS.Voucher{
    key = 'mimic',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_mimic',
    cost = 10,
    redeem = function(self)
        G.GAME.mimic_retrigger = true
    end
}

SMODS.Voucher{
    key = 'doppelganger',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_doppelganger',
    cost = 10,
    requires = { 'v_odyssey_mimic' },
    redeem = function(self)
        G.GAME.doppelganger_retrigger = true
    end
}

-- 79. Magic_Mirror & Portal
SMODS.Voucher{
    key = 'magic_mirror',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_magic_mirror',
    cost = 10,
    redeem = function(self)
        G.GAME.mirror_retrigger = true
    end
}

SMODS.Voucher{
    key = 'portal',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_portal',
    cost = 10,
    requires = { 'v_odyssey_magic_mirror' },
    redeem = function(self)
        G.GAME.portal_skip_ante = true
    end
}

-- 80. Shadow & Darkness
SMODS.Voucher{
    key = 'shadow_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_shadow',
    cost = 10,
    redeem = function(self)
        G.GAME.shadow_debuff_override = true
    end
}

SMODS.Voucher{
    key = 'darkness',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_darkness',
    cost = 10,
    requires = { 'v_odyssey_shadow_v' },
    redeem = function(self)
        G.GAME.darkness_xmult = (G.GAME.darkness_xmult or 1) * 2
    end
}

-- 81. Light & Glow
SMODS.Voucher{
    key = 'light',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_light',
    cost = 10,
    redeem = function(self)
        G.GAME.light_bonus_chips = (G.GAME.light_bonus_chips or 0) + 5
    end
}

SMODS.Voucher{
    key = 'glow',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_glow',
    cost = 10,
    requires = { 'v_odyssey_light' },
    redeem = function(self)
        G.GAME.light_bonus_chips = (G.GAME.light_bonus_chips or 0) + 5
    end
}

-- 82. Fire & Inferno
SMODS.Voucher{
    key = 'fire',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_fire',
    cost = 10,
    redeem = function(self)
        G.GAME.fire_mult_bonus = (G.GAME.fire_mult_bonus or 0) + 10
    end
}

SMODS.Voucher{
    key = 'inferno',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_inferno',
    cost = 10,
    requires = { 'v_odyssey_fire' },
    redeem = function(self)
        G.GAME.inferno_xmult_bonus = (G.GAME.inferno_xmult_bonus or 1) * 2
    end
}

-- 83. Ice & Absolute_Zero
SMODS.Voucher{
    key = 'ice',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_ice',
    cost = 10,
    redeem = function(self)
        G.GAME.ice_freeze_hands = true
    end
}

SMODS.Voucher{
    key = 'absolute_zero_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_absolute_zero',
    cost = 10,
    requires = { 'v_odyssey_ice' },
    redeem = function(self)
        G.GAME.absolute_zero_chips = (G.GAME.absolute_zero_chips or 0) + 200
    end
}

-- 84. Wind & Hurricane
SMODS.Voucher{
    key = 'wind',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_wind',
    cost = 10,
    redeem = function(self)
        G.GAME.wind_shuffle_bonus = true
    end
}

SMODS.Voucher{
    key = 'hurricane',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_hurricane',
    cost = 10,
    requires = { 'v_odyssey_wind' },
    redeem = function(self)
        G.GAME.hurricane_retrigger_all = true
    end
}

-- 85. Earth & Mountain
SMODS.Voucher{
    key = 'earth',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_earth',
    cost = 10,
    redeem = function(self)
        G.GAME.earth_base_stats = (G.GAME.earth_base_stats or 0) + 50
    end
}

SMODS.Voucher{
    key = 'mountain',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_mountain',
    cost = 10,
    requires = { 'v_odyssey_earth' },
    redeem = function(self)
        G.GAME.mountain_unbreakable = true
    end
}

-- 86. Water & Ocean
SMODS.Voucher{
    key = 'water_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_water',
    cost = 10,
    redeem = function(self)
        G.GAME.water_flush_bonus = (G.GAME.water_flush_bonus or 0) + 100
    end
}

SMODS.Voucher{
    key = 'ocean',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_ocean',
    cost = 10,
    requires = { 'v_odyssey_water_v' },
    redeem = function(self)
        G.GAME.ocean_flush_xmult = (G.GAME.ocean_flush_xmult or 1) * 2
    end
}

-- 87. Lightning & Storm
SMODS.Voucher{
    key = 'lightning_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_lightning',
    cost = 10,
    redeem = function(self)
        G.GAME.lightning_speed_bonus = true
    end
}

SMODS.Voucher{
    key = 'storm_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_storm',
    cost = 10,
    requires = { 'v_odyssey_lightning_v' },
    redeem = function(self)
        G.GAME.storm_chaos_mult = true
    end
}

-- 88. Metal & Alloy
SMODS.Voucher{
    key = 'metal',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_metal',
    cost = 10,
    redeem = function(self)
        G.GAME.metal_steel_bonus = (G.GAME.metal_steel_bonus or 0) + 0.1
    end
}

SMODS.Voucher{
    key = 'alloy',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_alloy',
    cost = 10,
    requires = { 'v_odyssey_metal' },
    redeem = function(self)
        G.GAME.alloy_all_cards_metal = true
    end
}

-- 89. Wood & Forest
SMODS.Voucher{
    key = 'wood',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_wood',
    cost = 10,
    redeem = function(self)
        G.GAME.wood_enabled = true
    end
}

SMODS.Voucher{
    key = 'forest',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_forest',
    cost = 10,
    requires = { 'v_odyssey_wood' },
    redeem = function(self)
        G.GAME.wood_mult_bonus = (G.GAME.wood_mult_bonus or 0) + 10
    end
}

-- 90. Plastic & Polymer
SMODS.Voucher{
    key = 'plastic',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_plastic',
    cost = 10,
    redeem = function(self)
        G.GAME.plastic_enabled = true
    end
}

SMODS.Voucher{
    key = 'polymer',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_polymer',
    cost = 10,
    requires = { 'v_odyssey_plastic' },
    redeem = function(self)
        G.GAME.plastic_chips_bonus = (G.GAME.plastic_chips_bonus or 0) + 50
    end
}

-- 91. Rubber & Tire
SMODS.Voucher{
    key = 'rubber',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_rubber',
    cost = 10,
    redeem = function(self)
        G.GAME.rubber_enabled = true
    end
}

SMODS.Voucher{
    key = 'tire',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_tire',
    cost = 10,
    requires = { 'v_odyssey_rubber' },
    redeem = function(self)
        G.GAME.rubber_retrigger_chance = 0.25
    end
}

-- 92. Ceramic & Vase
SMODS.Voucher{
    key = 'ceramic',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_ceramic',
    cost = 10,
    redeem = function(self)
        G.GAME.ceramic_enabled = true
    end
}

SMODS.Voucher{
    key = 'vase',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_vase',
    cost = 10,
    requires = { 'v_odyssey_ceramic' },
    redeem = function(self)
        G.GAME.ceramic_money_bonus = (G.GAME.ceramic_money_bonus or 0) + 1
    end
}

-- 93. Cloth & Tapestry
SMODS.Voucher{
    key = 'cloth',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_cloth',
    cost = 10,
    redeem = function(self)
        G.GAME.cloth_enabled = true
    end
}

SMODS.Voucher{
    key = 'tapestry',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_tapestry',
    cost = 10,
    requires = { 'v_odyssey_cloth' },
    redeem = function(self)
        G.GAME.cloth_xmult_bonus = (G.GAME.cloth_xmult_bonus or 1) * 1.5
    end
}

-- 94. Paper & Origami
SMODS.Voucher{
    key = 'paper',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_paper',
    cost = 10,
    redeem = function(self)
        G.GAME.paper_enabled = true
    end
}

SMODS.Voucher{
    key = 'origami',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_origami',
    cost = 10,
    requires = { 'v_odyssey_paper' },
    redeem = function(self)
        G.GAME.paper_is_wild = true
    end
}

-- 95. Stone_2 & Rock
SMODS.Voucher{
    key = 'stone_2',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_stone_2',
    cost = 10,
    redeem = function(self)
        G.GAME.stone_bonus_xmult = (G.GAME.stone_bonus_xmult or 1) * 1.5
    end
}

SMODS.Voucher{
    key = 'rock',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_rock',
    cost = 10,
    requires = { 'v_odyssey_stone_2' },
    redeem = function(self)
        G.GAME.stone_bonus_xmult = (G.GAME.stone_bonus_xmult or 1) * 1.334 -- Total X2
    end
}

-- 96. Glass_2 & Window
SMODS.Voucher{
    key = 'glass_2',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_glass_2',
    cost = 10,
    redeem = function(self)
        G.GAME.glass_chips_bonus = (G.GAME.glass_chips_bonus or 0) + 100
    end
}

SMODS.Voucher{
    key = 'window',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_window',
    cost = 10,
    requires = { 'v_odyssey_glass_2' },
    redeem = function(self)
        G.GAME.glass_chips_bonus = (G.GAME.glass_chips_bonus or 0) + 100
    end
}

-- 97. Diamond & Jewelry
SMODS.Voucher{
    key = 'diamond_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_diamond',
    cost = 10,
    redeem = function(self)
        G.GAME.diamond_enabled = true
    end
}

SMODS.Voucher{
    key = 'jewelry',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_jewelry',
    cost = 10,
    requires = { 'v_odyssey_diamond_v' },
    redeem = function(self)
        G.GAME.diamond_money_bonus = (G.GAME.diamond_money_bonus or 0) + 5
    end
}

-- 98. Ruby & Gem
SMODS.Voucher{
    key = 'ruby',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_ruby',
    cost = 10,
    redeem = function(self)
        G.GAME.ruby_enabled = true
    end
}

SMODS.Voucher{
    key = 'gem',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_gem',
    cost = 10,
    requires = { 'v_odyssey_ruby' },
    redeem = function(self)
        G.GAME.ruby_mult_bonus = (G.GAME.ruby_mult_bonus or 0) + 20
    end
}

-- 99. Emerald & Crystal
SMODS.Voucher{
    key = 'emerald',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_emerald',
    cost = 10,
    redeem = function(self)
        G.GAME.emerald_enabled = true
    end
}

SMODS.Voucher{
    key = 'crystal_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_crystal',
    cost = 10,
    requires = { 'v_odyssey_emerald' },
    redeem = function(self)
        G.GAME.emerald_chips_bonus = (G.GAME.emerald_chips_bonus or 0) + 50
    end
}

-- 100. Platinum & Iridium
SMODS.Voucher{
    key = 'platinum_v',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_platinum',
    cost = 10,
    redeem = function(self)
        G.GAME.platinum_enabled = true
    end
}

SMODS.Voucher{
    key = 'iridium',
    pos = { x = 0, y = 0 },
    discovered = true,
    unlocked = true,
    atlas = 'v_iridium',
    cost = 10,
    requires = { 'v_odyssey_platinum_v' },
    redeem = function(self)
        G.GAME.platinum_xmult_bonus = (G.GAME.platinum_xmult_bonus or 1) * 5
    end
}

