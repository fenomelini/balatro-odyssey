-- J949-950: Conditions & Logic (Legendary)

-- Turing Complete (J949)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_cond_turing_complete',
    rarity = 4,
    atlas = 'j_cond_turing_complete',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            -- True simulation: Copy a random Joker from the entire pool
            if not card.ability.simulated_key or context.before then
                local keys = {}
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Joker' and k ~= card.config.center.key then
                        table.insert(keys, k)
                    end
                end
                card.ability.simulated_key = keys[math.random(#keys)]
            end
            
            local target = G.P_CENTERS[card.ability.simulated_key]
            if target and target.calculate then
                local res = target:calculate(card, context)
                if res then 
                    res.message = "SIMULATING: " .. target.name
                    return res
                end
            end
            
            return {
                x_mult = 5,
                message = "SIMULATED",
                colour = G.C.GOLD
            }
        end
    end
})

-- Tech Singularity (J950)
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_cond_tech_singularity',
    rarity = 4,
    atlas = 'j_cond_tech_singularity',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            -- Automatic victory simulation
            -- In real game, this might be too much, but for 1000 jokers, let's make it epic
            G.GAME.chips = G.GAME.blind.chips + 1
            if G.GAME.current_round.current_hand then
                G.GAME.current_round.current_hand.chips = 0
            end
            
            return {
                message = "SINGULARITY!",
                colour = G.C.BLACK
            }
        end
    end
})
