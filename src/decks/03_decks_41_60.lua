-- Decks 41-60

-- 41. Baralho Baralho Ira
SMODS.Back({
    key = 'wrath',
    atlas = 'b_wrath',
    pos = { x = 0, y = 0 },
    config = { discards = 1 },
    apply = function(self)
        G.GAME.modifiers.discard_cost = 1
    end
})

-- 42. Baralho Baralho Preguiça
SMODS.Back({
    key = 'sloth',
    atlas = 'b_sloth',
    pos = { x = 0, y = 0 },
    config = { discards = -100, hands = -3 }
})

-- 43. Baralho Baralho Luxúria
SMODS.Back({
    key = 'lust',
    atlas = 'b_lust',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 44. Baralho Baralho Orgulho
SMODS.Back({
    key = 'pride',
    atlas = 'b_pride',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 45. Baralho Baralho Alfa
SMODS.Back({
    key = 'alpha',
    atlas = 'b_alpha',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    local id = card.base.id
                    -- Keep A(14), 2, 3, 4, 5. Remove others.
                    if id > 5 and id < 14 then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 46. Baralho Baralho Ômega
SMODS.Back({
    key = 'omega',
    atlas = 'b_omega',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    local id = card.base.id
                    -- Keep 10, J, Q, K, A. Remove id < 10.
                    if id < 10 then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 47. Baralho Baralho Zero
SMODS.Back({
    key = 'zero',
    atlas = 'b_zero',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    local id = card.base.id
                    -- Keep 2-9. Remove id >= 10.
                    if id >= 10 then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 48. Baralho Baralho Fibonacci
SMODS.Back({
    key = 'fibonacci',
    atlas = 'b_fibonacci',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local allowed = { [14] = true, [2] = true, [3] = true, [5] = true, [8] = true }
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    if not allowed[card.base.id] then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 49. Baralho Baralho Primo
SMODS.Back({
    key = 'prime',
    atlas = 'b_prime',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local allowed = { [2] = true, [3] = true, [5] = true, [7] = true, [11] = true, [13] = true }
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    if not allowed[card.base.id] then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 50. Baralho Baralho Odisseia
SMODS.Back({
    key = 'odyssey',
    atlas = 'b_odyssey',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, true, 4, nil, nil, 'j_final_odyssey', 'odyssey_deck')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

-- 51. Baralho Baralho Fractal
SMODS.Back({
    key = 'fractal',
    atlas = 'b_fractal',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 52. Baralho Baralho Espelho
SMODS.Back({
    key = 'mirror',
    atlas = 'b_mirror',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 53. Baralho Baralho Fantasma
SMODS.Back({
    key = 'ghost',
    atlas = 'b_ghost',
    pos = { x = 0, y = 0 },
    config = { hands = -2 }
})

-- 54. Baralho Baralho Vampiro
SMODS.Back({
    key = 'vampire',
    atlas = 'b_vampire',
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 0, gain = 1 } }
})

-- 55. Baralho Baralho Zumbi
SMODS.Back({
    key = 'zombie',
    atlas = 'b_zombie',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_zombie = true
    end
})

-- 56. Baralho Baralho Ciborgue
SMODS.Back({
    key = 'cyborg',
    atlas = 'b_cyborg',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=1, 2 do
                    local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'cyborg_deck')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
                return true
            end
        }))
    end
})

-- 57. Baralho Baralho Alien
SMODS.Back({
    key = 'alien',
    atlas = 'b_alien',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 58. Baralho Baralho Mutante
SMODS.Back({
    key = 'mutant',
    atlas = 'b_mutant',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 59. Baralho Baralho Clone
SMODS.Back({
    key = 'clone',
    atlas = 'b_clone',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(G.playing_cards) do
                    v:set_base(G.P_CARDS.S_A)
                end
                return true
            end
        }))
    end
})

-- 60. Baralho Baralho Invisível
SMODS.Back({
    key = 'invisible',
    atlas = 'b_invisible',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(G.playing_cards) do
                    v.facing = 'back'
                end
                return true
            end
        }))
    end
})

