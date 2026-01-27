-- 21. Baralho Holográfico
SMODS.Back({
    name = "Holográfico",
    key = "holografico",
    atlas = "b_holographic",
    pos = { x = 0, y = 0 },
    config = { odyssey_holographic = true },
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'holographic_deck')
                card:set_edition({holo = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

-- 22. Baralho Policromático
SMODS.Back({
    name = "Policromático",
    key = "policromatico",
    atlas = "b_polychrome",
    pos = { x = 0, y = 0 },
    config = { odyssey_polychrome = true },
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'polychrome_deck')
                card:set_edition({polychrome = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

-- 23. Baralho Laminado
SMODS.Back({
    name = "Laminado",
    key = "laminado",
    atlas = "b_foil",
    pos = { x = 0, y = 0 },
    config = { odyssey_laminado = true },
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'foil_deck')
                card:set_edition({foil = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

-- 24. Baralho Negativo
SMODS.Back({
    name = "Negativo",
    key = "negativo",
    atlas = "b_negative",
    pos = { x = 0, y = 0 },
    config = { odyssey_negative = true },
    loc_vars = function(self, info_queue, card) return { vars = {} } end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'negative_deck')
                card:set_edition({negative = true}, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})

-- 25. Baralho Cerâmica
SMODS.Back({
    name = "Cerâmica",
    key = "ceramic",
    atlas = "b_glass",
    pos = { x = 0, y = 0 },
    config = { odyssey_ceramic = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_ceramic)
                end
                return true
            end
        }))
    end
})

-- 26. Baralho Borracha
SMODS.Back({
    name = "Borracha",
    key = "rubber",
    atlas = "b_steel",
    pos = { x = 0, y = 0 },
    config = { odyssey_rubber = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_rubber)
                end
                return true
            end
        }))
    end
})

-- 27. Baralho Platina
SMODS.Back({
    name = "Platina",
    key = "platinum",
    atlas = "b_stone",
    pos = { x = 0, y = 0 },
    config = { odyssey_platinum = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_platinum)
                end
                return true
            end
        }))
    end
})

-- 28. Baralho Diamante
SMODS.Back({
    name = "Diamante",
    key = "diamond",
    atlas = "b_gold",
    pos = { x = 0, y = 0 },
    config = { odyssey_diamond = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_diamond)
                end
                return true
            end
        }))
    end
})

-- 29. Baralho Mágico
SMODS.Back({
    name = "Baralho Mágico",
    key = "sorte",
    atlas = "b_lucky",
    pos = { x = 0, y = 0 },
    config = { odyssey_magic_deck = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_magic)
                end
                return true
            end
        }))
    end
})

-- 30. Baralho Sagrado
SMODS.Back({
    name = "Baralho Sagrado",
    key = "selvagem",
    atlas = "b_wild",
    pos = { x = 0, y = 0 },
    config = { odyssey_holy_deck = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_holy)
                end
                return true
            end
        }))
    end
})

-- 31. Baralho de Rubi
SMODS.Back({
    name = "Baralho de Rubi",
    key = "multiplicador",
    atlas = "b_mult",
    pos = { x = 0, y = 0 },
    config = { odyssey_ruby_deck = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_ruby)
                end
                return true
            end
        }))
    end
})

-- 32. Baralho de Esmeralda
SMODS.Back({
    name = "Baralho de Esmeralda",
    key = "bonus",
    atlas = "b_bonus",
    pos = { x = 0, y = 0 },
    config = { odyssey_emerald_deck = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_odyssey_emerald)
                end
                return true
            end
        }))
    end
})

-- 33. Baralho Duplo
SMODS.Back({
    name = "Duplo",
    key = "duplo",
    atlas = "b_double",
    pos = { x = 0, y = 0 },
    config = { odyssey_double = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, 52 do
                    local card = create_card('Base', G.deck, nil, nil, nil, nil, nil, 'double')
                    card:add_to_deck()
                    G.deck:emplace(card)
                    table.insert(G.playing_cards, card)
                end
                G.deck:shuffle()
                return true
            end
        }))
    end
})

-- 34. Baralho Minúsculo
SMODS.Back({
    name = "Minúsculo",
    key = "minusculo",
    atlas = "b_tiny",
    pos = { x = 0, y = 0 },
    config = { odyssey_tiny = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Spades' or v.base.suit == 'Clubs' then
                        v:start_dissolve(nil, true)
                    end
                end
                return true
            end
        }))
    end
})

-- 35. Baralho Ascensão
SMODS.Back({
    name = "Ascensão",
    key = "ascensao",
    atlas = "b_ascension",
    pos = { x = 0, y = 0 },
    config = { odyssey_ascension = true },
})

-- 36. Baralho Queda
SMODS.Back({
    name = "Queda",
    key = "queda",
    atlas = "b_fall",
    pos = { x = 0, y = 0 },
    config = { odyssey_fall = true },
})

-- 37. Baralho Avareza
SMODS.Back({
    name = "Avareza",
    key = "avareza",
    atlas = "b_avarice",
    pos = { x = 0, y = 0 },
    config = { odyssey_avarice = true, no_interest = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.modifiers.no_interest = true
                return true
            end
        }))
    end
})

-- 38. Baralho Pobreza
SMODS.Back({
    name = "Pobreza",
    key = "pobreza",
    atlas = "b_poverty",
    pos = { x = 0, y = 0 },
    config = { odyssey_poverty = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.dollars = 0
                G.GAME.interest_cap = 10
                return true
            end
        }))
    end
})

-- 39. Baralho Gula
SMODS.Back({
    name = "Gula",
    key = "gula",
    atlas = "b_gluttony",
    pos = { x = 0, y = 0 },
    config = { joker_slot = 2, consumable_slot = -2 },
})

-- 40. Baralho Inveja
SMODS.Back({
    name = "Inveja",
    key = "inveja",
    atlas = "b_envy",
    pos = { x = 0, y = 0 },
    config = { odyssey_envy = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_mime', 'envy_deck')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
})
