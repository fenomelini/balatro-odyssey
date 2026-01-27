----------------------------------------------
-- POSITIONING & ADJACENCY (COMMON) J851-J870
----------------------------------------------

-- J851 Left Neighbor
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_left_neighbor',
    config = {},
    rarity = 1,
    atlas = 'j_pos_left_neighbor',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        local other_joker = get_joker_neighbor(card, 'left')
        if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then return end
            local other_joker_ret = other_joker:calculate_joker(context)
            if other_joker_ret then
                other_joker_ret.card = context.blueprint_card or card
                return other_joker_ret
            end
        end
    end
})

-- J852 Right Neighbor
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_right_neighbor',
    config = {},
    rarity = 1,
    atlas = 'j_pos_right_neighbor',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        local other_joker = get_joker_neighbor(card, 'right')
        if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then return end
            local other_joker_ret = other_joker:calculate_joker(context)
            if other_joker_ret then
                other_joker_ret.card = context.blueprint_card or card
                return other_joker_ret
            end
        end
    end
})

-- J853 Bodyguard
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_bodyguard',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_pos_bodyguard',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
             return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        -- Protection logic is in 03_vanilla_override
    end
})

-- J854 Leader
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_leader',
    config = { extra = { mult_per = 5 } },
    rarity = 1,
    atlas = 'j_pos_leader',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            local found = false
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then found = true
                elseif found then count = count + 1 end
            end
            return {
                mult_mod = count * card.ability.extra.mult_per,
                message = localize { type = 'variable', key = 'a_mult', vars = { count * card.ability.extra.mult_per } }
            }
        end
    end
})

-- J855 Follower
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_follower',
    config = { extra = { mult_per = 5 } },
    rarity = 1,
    atlas = 'j_pos_follower',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then break end
                count = count + 1
            end
            return {
                mult_mod = count * card.ability.extra.mult_per,
                message = localize { type = 'variable', key = 'a_mult', vars = { count * card.ability.extra.mult_per } }
            }
        end
    end
})

-- J856 Center Stage
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_center_stage',
    config = { extra = { mult = 20 } },
    rarity = 1,
    atlas = 'j_pos_center_stage',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            if idx == math.ceil(#G.jokers.cards / 2) then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- J857 Outsider
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_outsider',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_pos_outsider',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            if idx == 1 or idx == #G.jokers.cards then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
    end
})

-- J858 Pair
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_pair',
    config = { extra = { x_mult = 2 } },
    rarity = 1,
    atlas = 'j_pos_pair',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            local is_pair = false
            if idx > 1 and G.jokers.cards[idx-1].config.center.key == card.config.center.key then is_pair = true end
            if idx < #G.jokers.cards and G.jokers.cards[idx+1].config.center.key == card.config.center.key then is_pair = true end
            if is_pair then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J859 Trio
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_trio',
    config = { extra = { x_mult = 3 } },
    rarity = 1,
    atlas = 'j_pos_trio',
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.joker_main then
             local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            local count = 1
            -- Check left
            local l = idx - 1
            while l >= 1 and G.jokers.cards[l].config.center.key == card.config.center.key do
                count = count + 1
                l = l - 1
            end
            -- Check right
            local r = idx + 1
            while r <= #G.jokers.cards and G.jokers.cards[r].config.center.key == card.config.center.key do
                count = count + 1
                r = r + 1
            end
            if count >= 3 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end
})

-- J860 Chain
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_chain',
    config = { extra = { mult_per = 5 } },
    rarity = 1,
    atlas = 'j_pos_chain',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.joker_main then
            local idx = 0
            for i = 1, #G.jokers.cards do if G.jokers.cards[i] == card then idx = i; break end end
            local neighbors = 0
            if idx > 1 and G.jokers.cards[idx-1].config.center.key == card.config.center.key then neighbors = neighbors + 1 end
            if idx < #G.jokers.cards and G.jokers.cards[idx+1].config.center.key == card.config.center.key then neighbors = neighbors + 1 end
            return {
                mult_mod = neighbors * card.ability.extra.mult_per,
                message = localize { type = 'variable', key = 'a_mult', vars = { neighbors * card.ability.extra.mult_per } }
            }
        end
    end
})

-- J861 Magnet
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_magnet',
    config = { extra = { mult = 15 } },
    rarity = 1,
    atlas = 'j_pos_magnet',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i=1, #G.hand.cards do
                if G.hand.cards[i].config.center.key == 'm_odyssey_platinum' then count = count + 1 end
            end
            if count > 0 then
                return {
                    mult_mod = card.ability.extra.mult * count,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult * count } }
                }
            end
        end
    end
})

-- J862 Repulsor
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_repulsor',
    config = { extra = { chips = 100 } },
    rarity = 1,
    atlas = 'j_pos_repulsor',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i break end
            end
            if my_pos == 1 or my_pos == #G.jokers.cards then
                return {
                    chip_mod = card.ability.extra.chips,
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
        end
    end
})

-- J863 Mirror
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_mirror',
    config = {},
    rarity = 1,
    atlas = 'j_pos_mirror',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        local my_pos = nil
        for i=1, #G.jokers.cards do if G.jokers.cards[i] == card then my_pos = i break end end
        if my_pos then
            local target_pos = #G.jokers.cards - my_pos + 1
            if target_pos ~= my_pos and G.jokers.cards[target_pos] then
                local other_joker = G.jokers.cards[target_pos]
                if other_joker.config.center.blueprint_compat then
                    context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                    context.blueprint_card = context.blueprint_card or card
                    if context.blueprint > #G.jokers.cards + 1 then return end
                    local other_joker_ret = other_joker:calculate_joker(context)
                    if other_joker_ret then
                        other_joker_ret.card = context.blueprint_card or card
                        return other_joker_ret
                    end
                end
            end
        end
    end
})

-- J864 Prism
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_prism',
    config = {},
    rarity = 1,
    atlas = 'j_pos_prism',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = false,
    -- This one should probably be handled in vanilla_override or a global context
    -- Let's make it simpler for now: Copies left joker for every joker slot? No.
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J865 Lens
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_lens',
    config = { extra = { mult = 0 } },
    rarity = 1,
    atlas = 'j_pos_lens',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J866 Amplifier
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_amplifier',
    config = { extra = { factor = 1.5 } },
    rarity = 1,
    atlas = 'j_pos_amplifier',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.factor } }

    end,
    calculate = function(self, card, context)
        local other_joker = get_joker_neighbor(card, 'right')
        if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then return end
            local other_joker_ret = other_joker:calculate_joker(context)
            if other_joker_ret then
                if other_joker_ret.mult_mod then other_joker_ret.mult_mod = other_joker_ret.mult_mod * (card.ability.extra.factor - 1) end
                if other_joker_ret.chip_mod then other_joker_ret.chip_mod = other_joker_ret.chip_mod * (card.ability.extra.factor - 1) end
                if other_joker_ret.x_mult then 
                    other_joker_ret.x_mult = card.ability.extra.factor - (card.ability.extra.factor - 1) / other_joker_ret.x_mult
                end
                other_joker_ret.card = card
                return other_joker_ret
            end
        end
    end
})

-- J867 Silencer
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_silencer',
    config = { extra = { x_mult = 3 } },
    rarity = 1,
    atlas = 'j_pos_silencer',
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.x_mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- J868 Battery
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_battery',
    config = {},
    rarity = 1,
    atlas = 'j_pos_battery',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        local other_joker = get_joker_neighbor(card, 'right')
        if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
            context.repetition = (context.repetition or 0) + 1
            if context.repetition > 1 then return end
            local other_joker_ret = other_joker:calculate_joker(context)
            if other_joker_ret then
                 other_joker_ret.message = "RECHARGE!"
                 return other_joker_ret
            end
        end
    end
})

-- J869 Ground Wire
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_ground_wire',
    config = { extra = { chips = 100 } },
    rarity = 1,
    atlas = 'j_pos_ground_wire',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips,
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
            }
        end
    end
})

-- J870 Connector
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_pos_connector',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_pos_connector',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = "BRIDGE",
                colour = G.C.MULT
            }
        end
    end
})
