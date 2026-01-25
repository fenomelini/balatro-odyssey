-- Decks 81-100

-- 81. Baralho Baralho Maximalista II
SMODS.Back({
    key = 'maximalist_ii',
    atlas = 'b_maximalist_ii',
    pos = { x = 0, y = 0 },
    config = { hand_size = 2, discards = -100 }
})

-- 82. Baralho Baralho Caótico II
SMODS.Back({
    key = 'chaotic_ii',
    atlas = 'b_chaotic_ii',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 83. Baralho Baralho Ordenado II
SMODS.Back({
    key = 'ordered_ii',
    atlas = 'b_ordered_ii',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        -- Disable boss blinds (handled in game logic usually by simply not triggering ability)
        -- But for global effect, we might need a hook.
        -- Setting a custom modifier flag.
        G.GAME.modifiers.odyssey_no_boss_effect = true
    end
})

-- 84. Baralho Baralho Sortudo II
SMODS.Back({
    key = 'lucky_ii',
    atlas = 'b_lucky_ii',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.probabilities.normal = 1
    end
})

-- 85. Baralho Baralho Azarado
SMODS.Back({
    key = 'unlucky',
    atlas = 'b_unlucky',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.probabilities.normal = 1000
    end
})

-- 86. Baralho Baralho Rei Midas
SMODS.Back({
    key = 'midas',
    atlas = 'b_midas',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.GAME.modifiers.odyssey_midas = true
    end
})

-- 87. Baralho Baralho Rei Arthur
SMODS.Back({
    key = 'arthur',
    atlas = 'b_arthur',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, true, 4, nil, nil, 'j_final_odyssey', 'arthur_deck')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

-- 88. Baralho Baralho Merlin
SMODS.Back({
    key = 'merlin',
    atlas = 'b_merlin',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=1, 3 do
                    local card = create_card('Tarot', G.consumables, nil, nil, nil, nil, nil, 'merlin_deck')
                    card:add_to_deck()
                    G.consumables:emplace(card)
                end
                return true
            end
        }))
    end
})

-- 89. Baralho Baralho Dragão
SMODS.Back({
    key = 'dragon',
    atlas = 'b_dragon',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 90. Baralho Baralho Fênix
SMODS.Back({
    key = 'phoenix',
    atlas = 'b_phoenix',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 91. Baralho Baralho Hidra
SMODS.Back({
    key = 'hydra',
    atlas = 'b_hydra',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 92. Baralho Baralho Quimera
SMODS.Back({
    key = 'chimera',
    atlas = 'b_chimera',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 93. Baralho Baralho Grifo
SMODS.Back({
    key = 'griffin',
    atlas = 'b_griffin',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 94. Baralho Baralho Unicórnio
SMODS.Back({
    key = 'unicorn',
    atlas = 'b_unicorn',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 95. Baralho Baralho Kraken
SMODS.Back({
    key = 'kraken',
    atlas = 'b_kraken',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 96. Baralho Baralho Leviatã
SMODS.Back({
    key = 'leviathan',
    atlas = 'b_leviathan',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 97. Baralho Baralho Behemoth
SMODS.Back({
    key = 'behemoth',
    atlas = 'b_behemoth',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 98. Baralho Baralho Titã
SMODS.Back({
    key = 'titan',
    atlas = 'b_titan',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 99. Baralho Baralho Gnomo
SMODS.Back({
    key = 'gnome',
    atlas = 'b_gnome',
    pos = { x = 0, y = 0 },
    config = {}
})

-- 100. Baralho Baralho O Criador
SMODS.Back({
    key = 'the_creator',
    atlas = 'b_the_creator',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, true, 4, nil, nil, 'j_final_the_creator', 'creator_deck')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

