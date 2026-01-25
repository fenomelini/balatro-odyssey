-- Decks 61-80

-- 61. Baralho Baralho Etéreo
SMODS.Back({
    key = 'ethereal',
    atlas = 'b_ethereal',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        -- Logic handled in 03_vanilla_override (or standard Steamodded config?)
        -- Actually we need to hook into usage rate.
        -- Base game uses G.GAME.modifiers.spectral_rate or similar? No, only tarot/planet usually.
        -- Standard shop generation: G.E_MANAGER adds cards.
        -- We can set a flag G.GAME.modifiers.odyssey_ethereal_shop = true
        G.GAME.modifiers.odyssey_ethereal_shop = true
    end
})

-- 62. Baralho Baralho Radioativo
SMODS.Back({
    key = 'radioactive',
    atlas = 'b_radioactive',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 63. Baralho Baralho Magnético
SMODS.Back({
    key = 'magnetic',
    atlas = 'b_magnetic',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 64. Baralho Baralho Congelado
SMODS.Back({
    key = 'frozen',
    atlas = 'b_frozen',
    pos = { x = 0, y = 0 },
    config = { hands = 2 }
})

-- 65. Baralho Baralho Vulcânico
SMODS.Back({
    key = 'volcanic',
    atlas = 'b_volcanic',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 66. Baralho Baralho Oceânico
SMODS.Back({
    key = 'oceanic',
    atlas = 'b_oceanic',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    if card.base.suit == 'Diamonds' or card.base.suit == 'Hearts' then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 67. Baralho Baralho Solar
SMODS.Back({
    key = 'solar',
    atlas = 'b_solar',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    local card = G.playing_cards[i]
                    if card.base.suit == 'Spades' or card.base.suit == 'Clubs' then
                        card:remove()
                        card = nil
                    end
                end
                return true
            end
        }))
    end
})

-- 68. Baralho Baralho Lunar
SMODS.Back({
    key = 'lunar',
    atlas = 'b_lunar',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 69. Baralho Baralho Estelar
SMODS.Back({
    key = 'stellar',
    atlas = 'b_stellar',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=1, 5 do
                    local card = create_card('Planet', G.consumables, nil, nil, nil, nil, nil, 'stellar_deck')
                    card:add_to_deck()
                    G.consumables:emplace(card)
                end
                return true
            end
        }))
    end
})

-- 70. Baralho Baralho Místico
SMODS.Back({
    key = 'mystic',
    atlas = 'b_mystic',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=1, 5 do
                    local card = create_card('Tarot', G.consumables, nil, nil, nil, nil, nil, 'mystic_deck')
                    card:add_to_deck()
                    G.consumables:emplace(card)
                end
                return true
            end
        }))
    end
})

-- 71. Baralho Baralho Tecnológico
SMODS.Back({
    key = 'tech',
    atlas = 'b_tech',
    pos = { x = 0, y = 0 },
    config = { dollars = 100 },
    apply = function(self)
        G.GAME.modifiers.odyssey_shop_price_mult = 2
    end
})

-- 72. Baralho Baralho Primitivo
SMODS.Back({
    key = 'primitive',
    atlas = 'b_primitive',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 73. Baralho Baralho Arcano
SMODS.Back({
    key = 'arcane',
    atlas = 'b_arcane',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_free_arcana = true
    end
})

-- 74. Baralho Baralho Celestial
SMODS.Back({
    key = 'celestial',
    atlas = 'b_celestial',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_free_planet = true
    end
})

-- 75. Baralho Baralho Espectral
SMODS.Back({
    key = 'spectral',
    atlas = 'b_spectral',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_free_spectral = true
    end
})

-- 76. Baralho Baralho Standard
SMODS.Back({
    key = 'standard',
    atlas = 'b_standard',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_free_standard = true
    end
})

-- 77. Baralho Baralho Buffoon
SMODS.Back({
    key = 'buffoon',
    atlas = 'b_buffoon',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_free_buffoon = true
    end
})

-- 78. Baralho Baralho Mercenário
SMODS.Back({
    key = 'mercenary',
    atlas = 'b_mercenary',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 79. Baralho Baralho Investidor
SMODS.Back({
    key = 'investor',
    atlas = 'b_investor',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.interest_cap = 1000
    end
})

-- 80. Baralho Baralho Minimalista II
SMODS.Back({
    key = 'minimalist_ii',
    atlas = 'b_minimalist_ii',
    pos = { x = 0, y = 0 },
    config = { hand_size = -5 }
})

