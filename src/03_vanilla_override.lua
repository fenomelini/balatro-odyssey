-- Balatro Odyssey: Standard Vanilla Overrides & Hooks
-- Consolidates critical game logic and patches known injector bugs.

-- 1. Game Setup & Pool Management
local old_get_blind_amount = get_blind_amount
function get_blind_amount(ante)
    local amount = old_get_blind_amount(ante)
    -- Odyssey Scale: Base points grow 3x faster to compensate for 1000 Jokers power creep.
    return amount * 3
end

-- 2. Currency & Stat Easing
local old_ease_dollars = ease_dollars
function ease_dollars(amount, instant)
    if G.GAME.bankrupt_at and (G.GAME.dollars + amount < G.GAME.bankrupt_at) then return end
    old_ease_dollars(amount, instant)
end

-- 3. Card & Hand Logic Consolidation
local old_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if G.GAME and G.GAME.modifiers.odyssey_chameleon and not bypass_debuff then return true end
    return old_is_suit(self, suit, bypass_debuff, flush_calc)
end

local old_get_cost = Card.get_cost
function Card:get_cost()
    local cost = old_get_cost(self)
    if G.GAME.odyssey_astronomer_planets_free and self.ability.set == 'Planet' then return 0 end
    
    -- Odyssey Coupon Joker (j_economy_coupon)
    if G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
            if j.config.center.key == 'j_odyssey_j_economy_coupon' and j.ability.extra and j.ability.extra.active then
                return 0
            end
        end
    end
    
    return cost
end

-- 4. Safety Fixes (Lovely/Injector Stability)
local old_ebcb = ease_background_colour_blind
function ease_background_colour_blind(state, blindname)
    local b_name = blindname or (G.GAME.blind and G.GAME.blind.name) or ''
    -- Safety check: Avoid "attempt to index field 'boss' (a nil value)" in common_events.lua
    for _, v in pairs(G.P_BLINDS) do
        if v.name == b_name and not v.boss then
            ease_background_colour{new_colour = G.C.BLIND['Small'], contrast = 1}
            return
        end
    end
    old_ebcb(state, b_name)
end

local old_reroll_boss = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e)
    if not G.blind_select_opts or not G.blind_select_opts.boss then return end
    old_reroll_boss(e)
end

-- 5. Round Timer Initializer
local old_set_blind = Blind.set_blind
function Blind:set_blind(blind, reset, silent)
    old_set_blind(self, blind, reset, silent)
    G.GAME.last_hand_time = G.TIMERS.REAL
end

-- 6. Blind Mechanics Overrides
-- A Espaguetificação: Jokers don't give Mult (Only Chips/XMult)
local old_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
    local ret = old_calculate_joker(self, context)
    if ret and G.GAME.blind and G.GAME.blind.key == 'blind_odyssey_blind_64' then
        if ret.mult_mod then ret.mult_mod = nil end
        if ret.mult then ret.mult = nil end
    end
    return ret
end

-- 7. Perma-Mult & Perma-Bonus Logic for Playing Cards
local old_get_chip_mult = Card.get_chip_mult
function Card:get_chip_mult()
    local mult = old_get_chip_mult(self)
    if self.debuff then return 0 end
    if self.ability.set == 'Joker' then return 0 end
    return mult + (self.ability.perma_mult or 0)
end

local old_generate_UIBox_ability_table = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    local res = old_generate_UIBox_ability_table(self)
    if (self.ability.set == 'Default' or self.ability.set == 'Enhanced') and self.ability.perma_mult and self.ability.perma_mult ~= 0 then
        -- Find the loc_vars in the res table and inject perma_mult
        -- This is a bit complex depending on how SMODS handles it, but let's try a simple inject
        if res.name == 'Default' or res.name == 'Enhanced' then
            -- Actually, SMODS might have already returned the table.
        end
    end
    return res
end

