-- 1. Baralho Nebulosa
SMODS.Back({
    name = "Nebulosa",
    key = "nebula_deck",
    atlas = "b_nebula",
    pos = { x = 0, y = 0 },
    config = { vouchers = {'v_telescope'} },
})

-- 2. Baralho de Prótons
SMODS.Back({
    name = "Prótons",
    key = "protons",
    atlas = "b_protons",
    pos = { x = 0, y = 0 },
    config = { hand_size = 1 },
})

-- 3. Baralho de Elétrons
SMODS.Back({
    name = "Elétrons",
    key = "electrons",
    atlas = "b_electrons",
    pos = { x = 0, y = 0 },
    config = { discards = 1 },
})

-- 4. Baralho de Nêutrons
SMODS.Back({
    name = "Nêutrons",
    key = "neutrons",
    atlas = "b_neutrons",
    pos = { x = 0, y = 0 },
    config = { joker_slot = 2 },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v:is_face() then
                        v:start_dissolve(nil, true)
                    end
                end
                return true
            end
        }))
    end
})

-- 5. Baralho de Fótons
SMODS.Back({
    name = "Fótons",
    key = "photons",
    atlas = "b_photons",
    pos = { x = 0, y = 0 },
    config = {},
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

-- 6. Baralho Gravitacional
SMODS.Back({
    name = "Gravitacional",
    key = "gravitational",
    atlas = "b_gravitational",
    pos = { x = 0, y = 0 },
    config = { odyssey_gravitational = true },
})

-- 7. Baralho Horizonte de Eventos
SMODS.Back({
    name = "Horizonte de Eventos",
    key = "event_horizon",
    atlas = "b_event_horizon",
    pos = { x = 0, y = 0 },
    config = { odyssey_event_horizon = true },
})

-- 8. Baralho Buraco de Minhoca
SMODS.Back({
    name = "Buraco de Minhoca",
    key = "wormhole",
    atlas = "b_wormhole",
    pos = { x = 0, y = 0 },
    config = { odyssey_wormhole = true },
})

-- 9. Baralho Supernova
SMODS.Back({
    name = "Supernova Deck",
    key = "supernova_deck",
    atlas = "b_supernova",
    pos = { x = 0, y = 0 },
    config = { odyssey_supernova = true },
})

-- 10. Baralho Quasar
SMODS.Back({
    name = "Quasar",
    key = "quasar",
    atlas = "b_quasar",
    pos = { x = 0, y = 0 },
    config = { odyssey_quasar = true, no_interest = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.blind_states.Small = 'Skipped' -- Example logic, actually handled in game hooks
                return true
            end
        }))
    end
})

-- 11. Baralho Energia Escura
SMODS.Back({
    name = "Energia Escura",
    key = "dark_energy",
    atlas = "b_dark_energy",
    pos = { x = 0, y = 0 },
    config = { odyssey_dark_energy = true },
})

-- 12. Baralho Antimatéria
SMODS.Back({
    name = "Antimatéria",
    key = "antimatter",
    atlas = "b_antimatter",
    pos = { x = 0, y = 0 },
    config = { odyssey_antimatter = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_negative'))
                return true
            end
        }))
    end
})

-- 13. Baralho Vácuo
SMODS.Back({
    name = "Vácuo",
    key = "vacuum",
    atlas = "b_vacuum",
    pos = { x = 0, y = 0 },
    config = { odyssey_vacuum = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.shop_jokers then
                    G.shop_jokers.card_limit = 6
                end
                return true
            end
        }))
    end
})

-- 14. Baralho Teoria das Cordas
SMODS.Back({
    name = "Teoria das Cordas",
    key = "string_theory",
    atlas = "b_string_theory",
    pos = { x = 0, y = 0 },
    config = { odyssey_string_theory = true },
})

-- 15. Baralho do Caos
SMODS.Back({
    name = "Caos",
    key = "chaos",
    atlas = "b_chaos",
    pos = { x = 0, y = 0 },
    config = { odyssey_chaos = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    local suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('chaos_suit'))
                    local rank = pseudorandom_element({'2','3','4','5','6','7','8','9','T','J','Q','K','A'}, pseudoseed('chaos_rank'))
                    v:set_base(G.P_CARDS[suit..'_'..rank])
                end
                return true
            end
        }))
    end
})

-- 16. Baralho da Ordem
SMODS.Back({
    name = "Ordem",
    key = "order",
    atlas = "b_order",
    pos = { x = 0, y = 0 },
    config = { odyssey_order = true },
})

-- 17. Baralho do Paradoxo
SMODS.Back({
    name = "Paradoxo",
    key = "paradox",
    atlas = "b_paradox",
    pos = { x = 0, y = 0 },
    config = { odyssey_paradox = true, ante_scaling = 2 },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.ante = 0
                return true
            end
        }))
    end
})

-- 18. Baralho da Linha do Tempo
SMODS.Back({
    name = "Linha do Tempo",
    key = "timeline",
    atlas = "b_timeline",
    pos = { x = 0, y = 0 },
    config = { odyssey_timeline = true },
})

-- 19. Baralho Paralelo
SMODS.Back({
    name = "Paralelo",
    key = "parallel",
    atlas = "b_parallel",
    pos = { x = 0, y = 0 },
    config = { hands = 2, discards = -2 },
})

-- 20. Baralho Dimensional
SMODS.Back({
    name = "Dimensional",
    key = "dimensional",
    atlas = "b_dimensional",
    pos = { x = 0, y = 0 },
    config = { odyssey_dimensional = true },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, 26 do
                    local card = create_card('Base', G.deck, nil, nil, nil, nil, nil, 'dim')
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
