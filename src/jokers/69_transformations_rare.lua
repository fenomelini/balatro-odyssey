----------------------------------------------
-- TRANSFORMATIONS (RARE) J789-J798
----------------------------------------------

-- J789 Metamorphosis
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_metamorphosis',
    config = {},
    rarity = 3,
    atlas = 'j_transformations_metamorphosis',
    pos = { x = 0, y = 0 },
    cost = 8,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.blueprint and not context.other_card then
            local area = card.area
            local rarity = card.config.center.rarity
            local key = nil
            while not key or key == 'j_transformations_metamorphosis' do
                key = SMODS.poll_joker({rarity = rarity}).key
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:remove()
                    local new_card = create_card('Joker', area, nil, nil, nil, nil, key)
                    new_card:add_to_deck()
                    area:emplace(new_card)
                    return true
                end
            }))
            return {
                message = "Metamorphosis!",
                colour = G.C.BLUE
            }
        end
    end
})

-- J790 Transcendence
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_transcendence',
    config = {},
    rarity = 3,
    atlas = 'j_transformations_transcendence',
    pos = { x = 0, y = 0 },
    cost = 8,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J791 Ascension
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_ascension',
    config = {},
    rarity = 3,
    atlas = 'j_transformations_ascension',
    pos = { x = 0, y = 0 },
    cost = 8,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J792 Apotheosis
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_apotheosis',
    config = {},
    rarity = 3,
    atlas = 'j_transformations_apotheosis',
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J793 Singularity
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_singularity',
    config = {},
    rarity = 3,
    atlas = 'j_transformations_singularity',
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J794 Big Bang
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_big_bang',
    config = {},
    rarity = 3,
    atlas = 'j_transformations_big_bang',
    pos = { x = 0, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J795 Reincarnation
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_reincarnation',
    config = { extra = { x_mult = 1.2 } },
    rarity = 3,
    atlas = 'j_transformations_reincarnation',
    pos = { x = 0, y = 0 },
    cost = 8,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J796 Evolution Final
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_final_evolution',
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    atlas = 'j_transformations_final_evolution',
    pos = { x = 0, y = 0 },
    cost = 9,
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    calculate = function(self, card, context)
        -- Auto-generated functional stub
    end
})

-- J797 Perfect Form
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_perfect_form',
    config = { extra = { x_mult = 4, odyssey_immune = true } },
    rarity = 3,
    atlas = 'j_transformations_perfect_form',
    pos = { x = 0, y = 0 },
    cost = 10,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- J798 Primal Chaos
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_transformations_primal_chaos',
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    atlas = 'j_transformations_primal_chaos',
    pos = { x = 0, y = 0 },
    cost = 10,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})
