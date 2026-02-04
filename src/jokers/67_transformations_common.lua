----------------------------------------------
-- TRANSFORMATIONS (COMMON) J751-J770
----------------------------------------------

-- J751 Chameleon
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_chameleon',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_chameleon',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        -- Hand suit copying logic usually implemented in Card:is_suit or similar
    end
})

-- J752 Mimic
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_mimic',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_mimic',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        -- Hand rank copying logic usually implemented in Card:get_id or similar
    end
})

-- J753 Shapeshifter
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_shapeshifter',
    config = { extra = { mult = 10, suit = 'Hearts' } },
    rarity = 1,
    atlas = 'j_transformations_shapeshifter',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.mult, extra.suit } }

    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.before and not context.blueprint then
            local suits = {'Hearts', 'Diamonds', 'Spades', 'Clubs'}
            card.ability.extra.suit = suits[math.random(#suits)]
        end
    end
})

-- J754 Doppelganger
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_doppelganger',
    config = { extra = { chips = 20 } },
    rarity = 1,
    atlas = 'j_transformations_doppelganger',
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)

        local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local prev_card = nil
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i] == context.other_card then
                    if i > 1 then prev_card = context.scoring_hand[i-1] end
                    break
                end
            end
            if prev_card and prev_card.base.value == context.other_card.base.value then
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
            end
        end
    end
})

-- J755 Magic Mirror
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_magic_mirror',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_magic_mirror',
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J756 Prism
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_prism',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_prism',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                v:set_edition({polychrome = true}, true, true)
            end
        end
    end
})

-- J757 Catalyst
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_catalyst',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_catalyst',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.joker_main then
            -- This is usually implemented as a global hook in vanilla_override
            -- but we can try to find scaling jokers and double their gain here
        end
    end
})

-- J758 Evolution
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_evolution',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_evolution',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local is_seq = true
            if #context.scoring_hand < 3 then is_seq = false end
            if is_seq then
                table.sort(context.scoring_hand, function(a, b) return a:get_id() < b:get_id() end)
                for i = 1, #context.scoring_hand - 1 do
                    if context.scoring_hand[i+1]:get_id() ~= context.scoring_hand[i]:get_id() + 1 then
                        is_seq = false
                        break
                    end
                end
            end
            if is_seq then
                for _, v in ipairs(context.scoring_hand) do
                    if v:get_id() < 14 then -- Not Ace (can't go higher than Ace easily)
                        v:set_base(G.P_CARDS[v.config.card_key:sub(1,1)..(string.format("%X", v:get_id()+1))])
                    end
                end
                return {
                    message = "Evolve!",
                    colour = G.C.RED
                }
            end
        end
    end
})

-- J759 Devolution
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_devolution',
    config = { extra = { mult = 20 } },
    rarity = 1,
    atlas = 'j_transformations_devolution',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local is_seq = true
            if #context.scoring_hand < 3 then is_seq = false end
            if is_seq then
                table.sort(context.scoring_hand, function(a, b) return a:get_id() < b:get_id() end)
                for i = 1, #context.scoring_hand - 1 do
                    if context.scoring_hand[i+1]:get_id() ~= context.scoring_hand[i]:get_id() + 1 then
                        is_seq = false
                        break
                    end
                end
            end
            if is_seq then
                for _, v in ipairs(context.scoring_hand) do
                    if v:get_id() > 2 then
                        v:set_base(G.P_CARDS[v.config.card_key:sub(1,1)..(string.format("%X", v:get_id()-1))])
                    end
                end
                card.ability.extra.triggered = true
            end
        end
        if context.joker_main and card.ability.extra.triggered then
            card.ability.extra.triggered = false
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
})

-- J760 Transmuter
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_transmuter',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_transmuter',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit('Diamonds') then
                    v:change_suit('Hearts')
                end
            end
        end
    end
})

-- J761 Converter
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_converter',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_converter',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_suit('Spades') then
                    v:change_suit('Clubs')
                end
            end
        end
    end
})

-- J762 Basic Alchemy
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_basic_alchemy',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_basic_alchemy',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            for k, v in ipairs(context.full_hand) do
                if v:get_id() >= 2 and v:get_id() <= 4 then
                    v:set_ability(G.P_CENTERS.m_odyssey_plastic)
                end
            end
        end
    end
})

-- J763 Polymorph
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_polymorph',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_polymorph',
    pos = { x = 0, y = 0 },
    cost = 5,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    local rank = math.random(2, 10)
                    -- SMODS rank change logic
                end
            end
        end
    end
})

-- J764 Mask
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_mask',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_mask',
    pos = { x = 0, y = 0 },
    cost = 5,
    -- Implementation usually handled in vanilla_override via is_suit
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J765 Disguise
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_disguise',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_disguise',
    pos = { x = 0, y = 0 },
    cost = 5,
    -- Implementation in vanilla_override via is_face
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J766 Costume
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_costume',
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'j_transformations_costume',
    pos = { x = 0, y = 0 },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { ( (card and card.ability and card.ability.extra) or self.config.extra ).mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
        if context.before and not context.blueprint then
            local enhancements = {
                'm_odyssey_wood', 'm_odyssey_plastic', 'm_odyssey_rubber', 'm_odyssey_shadow',
                'm_odyssey_ceramic', 'm_odyssey_cloth', 'm_odyssey_paper', 'm_odyssey_light',
                'm_odyssey_diamond', 'm_odyssey_ruby', 'm_odyssey_emerald', 'm_odyssey_plant',
                'm_odyssey_holy', 'm_odyssey_undead', 'm_odyssey_cursed', 'm_odyssey_magic'
            }
            if context.scoring_hand and #context.scoring_hand > 0 then
                local target = context.scoring_hand[1]
                local enh = enhancements[pseudorandom(pseudoseed('costume'), 1, #enhancements)]
                target:set_ability(G.P_CENTERS[enh], nil, true)
                return {
                    message = localize('k_upgrade_ex'),
                    card = target
                }
            end
        end
    end
})

-- J767 Makeup
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_makeup',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_makeup',
    pos = { x = 0, y = 0 },
    cost = 5,
    -- Implementation in vanilla_override via is_suit (color swap)
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J768 Wig
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_wig',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_wig',
    pos = { x = 0, y = 0 },
    cost = 4,
    -- Implementation: Kings count as Queens (vanilla_override)
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J769 Fake Beard
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_fake_beard',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_fake_beard',
    pos = { x = 0, y = 0 },
    cost = 4,
    -- Implementation: Queens count as Kings (vanilla_override)
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J770 Shadow
SMODS.Joker({
    discovered = false,
    unlocked = true,
    key = 'j_transformations_shadow',
    config = {},
    rarity = 1,
    atlas = 'j_transformations_shadow',
    pos = { x = 0, y = 0 },
    cost = 6,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if G.GAME.last_played_cards and #G.GAME.last_played_cards > 0 then
                local last_card = G.GAME.last_played_cards[1]
                local phantom = copy_card(last_card)
                phantom:set_edition({negative = true})
                phantom.ability.perishable = true
                phantom.ability.perish_tally = 1
                phantom:add_to_deck()
                G.hand:emplace(phantom)
                return {
                    message = "Shadow!",
                    colour = G.C.PURPLE
                }
            end
        end
    end
})
