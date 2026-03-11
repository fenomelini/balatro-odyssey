local spectrals = {
    { id = 1, key = "spectral_1", name = "Supernova" },
    { id = 2, key = "spectral_2", name = "Buraco Negro" },
    { id = 3, key = "spectral_3", name = "Quasar" },
    { id = 4, key = "spectral_4", name = "Pulsar" },
    { id = 5, key = "spectral_5", name = "Nebulosa" },
    { id = 6, key = "spectral_6", name = "Raio Gama" },
    { id = 7, key = "spectral_7", name = "Raio X" },
    { id = 8, key = "spectral_8", name = "Raio Cósmico" },
    { id = 9, key = "spectral_9", name = "Raio Vazio" },
    { id = 10, key = "spectral_10", name = "Antimatéria" },
    { id = 11, key = "spectral_11", name = "Matéria Escura" },
    { id = 12, key = "spectral_12", name = "Entropia" },
    { id = 13, key = "spectral_13", name = "Entalpia" },
    { id = 14, key = "spectral_14", name = "Zero Absoluto" },
    { id = 15, key = "spectral_15", name = "Planck" },
    { id = 16, key = "spectral_16", name = "Luz" },
    { id = 17, key = "spectral_17", name = "Dobra" },
    { id = 18, key = "spectral_18", name = "Minhoca" },
    { id = 19, key = "spectral_19", name = "Multiverso" },
    { id = 20, key = "spectral_20", name = "Paradoxo" },
    { id = 21, key = "spectral_21", name = "Singularidade" },
    { id = 22, key = "spectral_22", name = "Big Bang" },
    { id = 23, key = "spectral_23", name = "Salto" },
    { id = 24, key = "spectral_24", name = "Horizonte" },
    { id = 25, key = "spectral_25", name = "Poço" },
    { id = 26, key = "spectral_26", name = "Energia" },
    { id = 27, key = "spectral_27", name = "Vácuo" },
    { id = 28, key = "spectral_28", name = "Cordas" },
    { id = 29, key = "spectral_29", name = "Caos" },
    { id = 30, key = "spectral_30", name = "Borboleta" },
    { id = 31, key = "spectral_31", name = "Schrodinger" },
    { id = 32, key = "spectral_32", name = "Heisenberg" },
    { id = 33, key = "spectral_33", name = "Pauli" },
    { id = 34, key = "spectral_34", name = "Fermi" },
    { id = 35, key = "spectral_35", name = "Drake" },
    { id = 36, key = "spectral_36", name = "Hubble" },
    { id = 37, key = "spectral_37", name = "Webb" },
    { id = 38, key = "spectral_38", name = "Kepler" },
    { id = 39, key = "spectral_39", name = "Galileu" },
    { id = 40, key = "spectral_40", name = "Newton" },
    { id = 41, key = "spectral_41", name = "Einstein" },
    { id = 42, key = "spectral_42", name = "Hawking" },
    { id = 43, key = "spectral_43", name = "Sagan" },
    { id = 44, key = "spectral_44", name = "Tyson" },
    { id = 45, key = "spectral_45", name = "Kaku" },
    { id = 46, key = "spectral_46", name = "Greene" },
    { id = 47, key = "spectral_47", name = "Penrose" },
    { id = 48, key = "spectral_48", name = "Godel" },
    { id = 49, key = "spectral_49", name = "Turing" },
    { id = 50, key = "spectral_50", name = "Oppenheimer" },
    { id = 51, key = "spectral_51", name = "Feynman" },
    { id = 52, key = "spectral_52", name = "Bohr" },
    { id = 53, key = "spectral_53", name = "Curie" },
    { id = 54, key = "spectral_54", name = "Darwin" },
    { id = 55, key = "spectral_55", name = "Mendel" },
    { id = 56, key = "spectral_56", name = "Pasteur" },
    { id = 57, key = "spectral_57", name = "Fleming" },
    { id = 58, key = "spectral_58", name = "Tesla" },
    { id = 59, key = "spectral_59", name = "Edison" },
    { id = 60, key = "spectral_60", name = "Bell" },
    { id = 61, key = "spectral_61", name = "Marconi" },
    { id = 62, key = "spectral_62", name = "Wright" },
    { id = 63, key = "spectral_63", name = "Ford" },
    { id = 64, key = "spectral_64", name = "Babbage" },
    { id = 65, key = "spectral_65", name = "Lovelace" },
    { id = 66, key = "spectral_66", name = "Hopper" },
    { id = 67, key = "spectral_67", name = "Berners-Lee" },
    { id = 68, key = "spectral_68", name = "Jobs" },
    { id = 69, key = "spectral_69", name = "Gates" },
    { id = 70, key = "spectral_70", name = "Musk" },
    { id = 71, key = "spectral_71", name = "Bezos" },
    { id = 72, key = "spectral_72", name = "Zuckerberg" },
    { id = 73, key = "spectral_73", name = "Nakamoto" },
    { id = 74, key = "spectral_74", name = "Vitalik" },
    { id = 75, key = "spectral_75", name = "Armstrong" },
    { id = 76, key = "spectral_76", name = "Aldrin" },
    { id = 77, key = "spectral_77", name = "Collins" },
    { id = 78, key = "spectral_78", name = "Gagarin" },
    { id = 79, key = "spectral_79", name = "Tereshkova" },
    { id = 80, key = "spectral_80", name = "Laika" },
    { id = 81, key = "spectral_81", name = "Ham" },
    { id = 82, key = "spectral_82", name = "Shepard" },
    { id = 83, key = "spectral_83", name = "Glenn" },
    { id = 84, key = "spectral_84", name = "Leonov" },
    { id = 85, key = "spectral_85", name = "Ride" },
    { id = 86, key = "spectral_86", name = "Hadfield" },
    { id = 87, key = "spectral_87", name = "Kelly" },
    { id = 88, key = "spectral_88", name = "Pesquet" },
    { id = 89, key = "spectral_89", name = "Cristoforetti" },
    { id = 90, key = "spectral_90", name = "Gerst" },
    { id = 91, key = "spectral_91", name = "Peake" },
    { id = 92, key = "spectral_92", name = "Hoshide" },
    { id = 93, key = "spectral_93", name = "Yi" },
    { id = 94, key = "spectral_94", name = "Yang" },
    { id = 95, key = "spectral_95", name = "Sharma" },
    { id = 96, key = "spectral_96", name = "Al Mansoori" },
    { id = 97, key = "spectral_97", name = "Pontes" },
    { id = 98, key = "spectral_98", name = "Vostok" },
    { id = 99, key = "spectral_99", name = "Mercury" },
    { id = 100, key = "spectral_100", name = "Gemini" },
}

local spectral_logic = {
    [1] = function(card, area, copier) -- Supernova
        local cards = {}
        for i=1, #G.hand.cards do cards[#cards+1] = G.hand.cards[i] end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i=1, #cards do cards[i]:start_dissolve() end 
            G.GAME.odyssey_spectral_1_xmult = (G.GAME.odyssey_spectral_1_xmult or 1) * 3
            return true end }))
    end,
    [2] = function(card, area, copier) -- Buraco Negro
        local cards = {}
        for i=1, #G.hand.cards do cards[#cards+1] = G.hand.cards[i] end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            for i=1, #cards do cards[i]:start_dissolve() end 
            G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 1
            G.hand:change_size(1)
            return true end }))
    end,
    [3] = function(card, area, copier) -- Quasar
        if #G.jokers.cards > 0 then
            local target = pseudorandom_element(G.jokers.cards, pseudoseed('quasar'))
            for i=#G.jokers.cards, 1, -1 do
                if G.jokers.cards[i] ~= target then
                    G.jokers.cards[i]:start_dissolve()
                end
            end
            target:set_edition({polychrome = true}, true)
        end
    end,
    [4] = function(card, area, copier) -- Pulsar
        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_edition({foil = true}, true)
        end
        G.GAME.starting_params.hand_size = (G.GAME.starting_params.hand_size or 8) - 1
        G.hand:change_size(-1)
    end,
    [5] = function(card, area, copier) -- Nebulosa
        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_edition({holo = true}, true)
        end
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
        ease_discard(-1)
    end,
    [6] = function(card, area, copier) -- Raio Gama
        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_ability(G.P_CENTERS.m_odyssey_diamond, nil)
        end
        ease_dollars(-G.GAME.dollars, true)
    end,
    [7] = function(card, area, copier) -- Raio X
        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_ability(G.P_CENTERS.m_odyssey_ceramic, nil)
        end
        ease_discard(-G.GAME.current_round.discards_left)
    end,
    [8] = function(card, area, copier) -- Raio Cósmico
         for i=1, #G.hand.cards do
            G.hand.cards[i]:set_ability(G.P_CENTERS.m_odyssey_rubber, nil)
        end
        ease_hands_played(-(G.GAME.current_round.hands_left - 1))
    end,
    [9] = function(card, area, copier) -- Raio Vazio
        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_ability(G.P_CENTERS.m_odyssey_platinum, nil)
        end
        for i=#G.jokers.cards, 1, -1 do
            G.jokers.cards[i]:start_dissolve()
        end
    end,
    [10] = function(card, area, copier) -- Antimatéria
        if #G.jokers.cards > 0 then
            local target = pseudorandom_element(G.jokers.cards, pseudoseed('antimatter'))
            target:set_edition({negative = true}, true)
            ease_dollars(-G.GAME.dollars, true)
        end
    end,
    [11] = function(card, area, copier) -- Matéria Escura
        if #G.consumeables.cards > 0 then
            local target = pseudorandom_element(G.consumeables.cards, pseudoseed('darkmatter'))
            target:set_edition({negative = true}, true)
            for i=#G.jokers.cards, 1, -1 do
                G.jokers.cards[i]:start_dissolve()
            end
        end
    end,
    [12] = function(card, area, copier) -- Entropia
        local ranks = {'2','3','4','5','6','7','8','9','T','J','Q','K','A'}
        for i=1, #G.playing_cards do
            local new_rank = pseudorandom_element(ranks, pseudoseed('entropy'..i))
            local suit_prefix = G.playing_cards[i].base.suit:sub(1,1)
            G.playing_cards[i]:set_base(G.P_CARDS[suit_prefix..'_'..new_rank])
        end
        ease_dollars(20)
    end,
    [13] = function(card, area, copier) -- Entalpia
        local suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
        for i=1, #G.playing_cards do
            local new_suit = pseudorandom_element(suits, pseudoseed('enthalpy'..i))
            local rank = G.playing_cards[i].base.value
            local suit_prefix = new_suit:sub(1,1)
            G.playing_cards[i]:set_base(G.P_CARDS[suit_prefix..'_'..rank])
        end
        ease_dollars(20)
    end,
    [14] = function(card, area, copier) -- Zero Absoluto
        G.GAME.odyssey_zero_absolute = true
        G.GAME.odyssey_spectral_14_xmult = (G.GAME.odyssey_spectral_14_xmult or 1) * 5
    end,
    [15] = function(card, area, copier) -- Planck
        G.GAME.starting_params.hand_size = 1
        G.hand:change_size(1 - G.hand.config.card_limit)
        G.GAME.odyssey_spectral_15_xmult = (G.GAME.odyssey_spectral_15_xmult or 1) * 10
    end,
    [16] = function(card, area, copier) -- Luz
        G.GAME.round_resets.discards = 0
        ease_discard(-G.GAME.current_round.discards_left)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + 5
        ease_hands_played(5)
    end,
    [17] = function(card, area, copier) -- Dobra
        G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
            G.STATE = G.STATES.BLIND_SELECT
            G.STATE_COMPLETE = true
            return true
        end }))
    end,
    [18] = function(card, area, copier) -- Minhoca
        ease_ante(1)
        ease_dollars(-G.GAME.dollars, true)
    end,
    [19] = function(card, area, copier) -- Multiverso
         for i=1, math.min(2, #G.jokers.cards) do
             local joker = G.jokers.cards[i]
             local copy = copy_card(joker, nil, nil, nil, joker.edition)
             copy:set_perishable(true)
             copy:add_to_deck()
             G.jokers:emplace(copy)
         end
    end,
    [20] = function(card, area, copier) -- Paradoxo
        local score = G.GAME.last_round_score or 0
        local amount = math.min(100, score)
        ease_dollars(amount - G.GAME.dollars, true)
    end,
    [21] = function(card, area, copier) -- Singularidade
        if #G.jokers.cards >= 2 then
            G.jokers.cards[1]:start_dissolve()
            G.jokers.cards[2]:start_dissolve()
            local new_joker = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'sing')
            new_joker:set_edition({negative = true}, true)
            new_joker:add_to_deck()
            G.jokers:emplace(new_joker)
        end
    end,
    [23] = function(card, area, copier) -- Salto
        ease_ante(8 - G.GAME.round_resets.ante)
        ease_dollars(-G.GAME.dollars, true)
    end,
    [24] = function(card, area, copier) -- Horizonte
        for i=#G.playing_cards, 1, -1 do
            if G.playing_cards[i]:is_face() then
                G.playing_cards[i]:start_dissolve()
            end
        end
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end,
    [25] = function(card, area, copier) -- Poço
        for i=#G.playing_cards, 1, -1 do
            if not G.playing_cards[i]:is_face() then
                G.playing_cards[i]:start_dissolve()
            end
        end
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end,
    [26] = function(card, area, copier) -- Energia
        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_edition({negative = true}, true)
        end
    end,
    [27] = function(card, area, copier) -- Vácuo
        for i=1, #G.playing_cards do
            G.playing_cards[i]:set_ability(G.P_CENTERS.c_base)
            G.playing_cards[i]:set_edition(nil, true)
        end
        ease_dollars(50)
    end,
    [29] = function(card, area, copier) -- Caos
        local editions = {nil, {foil = true}, {holo = true}, {polychrome = true}, {negative = true}}
        for i=1, #G.jokers.cards do
            local ed = pseudorandom_element(editions, pseudoseed('chaos'..i))
            G.jokers.cards[i]:set_edition(ed, true)
        end
    end,
    [30] = function(card, area, copier) -- Borboleta
        if G.hand.highlighted[1] then
            local c = G.hand.highlighted[1]
            local ranks = {'2','3','4','5','6','7','8','9','T','J','Q','K','A'}
            local suits = {'S','H','C','D'}
            local r = pseudorandom_element(ranks, pseudoseed('butt_r'))
            local s = pseudorandom_element(suits, pseudoseed('butt_s'))
            c:set_base(G.P_CARDS[s..'_'..r])
        end
    end,
    [31] = function(card, area, copier) -- Schrodinger
        if pseudorandom('schro') > 0.5 then
            ease_dollars(G.GAME.dollars)
        else
            ease_dollars(-G.GAME.dollars)
        end
    end,
    [22] = function(card, area, copier) -- Big Bang
        -- Reset hands/discards to starting values for this round + permanent X2 Mult
        local hands_reset = G.GAME.round_resets.hands
        local discards_reset = G.GAME.round_resets.discards
        ease_hands_played(hands_reset - G.GAME.current_round.hands_left)
        ease_discard(discards_reset - G.GAME.current_round.discards_left)
        G.GAME.odyssey_spectral_1_xmult = (G.GAME.odyssey_spectral_1_xmult or 1) * 2
    end,
    [28] = function(card, area, copier) -- Cordas
        -- -2 hand size + level up all hands by 1
        G.GAME.starting_params.hand_size = (G.GAME.starting_params.hand_size or 8) - 2
        G.hand:change_size(-2)
        for k, v in pairs(G.GAME.hands) do
            update_hand_stats(k, {level = 1})
        end
    end,
    [32] = function(card, area, copier) -- Heisenberg
        -- Hide blind score this round + gain $30
        G.GAME.odyssey_heisenberg_active = true
        ease_dollars(30)
    end,
        local ranks = {}
        local has_pair = false
        for i=1, #G.hand.cards do
            local r = G.hand.cards[i].base.value
            if ranks[r] then has_pair = true; break end
            ranks[r] = true
        end
        if not has_pair then ease_dollars(20) end
    end,
    [34] = function(card, area, copier) -- Fermi
        local card = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'fermi')
        card:set_edition({negative = true}, true)
        card:add_to_deck()
        G.jokers:emplace(card)
    end,
    [35] = function(card, area, copier) -- Drake
        -- X2 Mult if hand played beats the blind (consumed per-hand by hook)
        G.GAME.odyssey_drake_active = true
    end,
    [36] = function(card, area, copier) -- Hubble
        G.GAME.odyssey_hubble_active = true
    end,
    [37] = function(card, area, copier) -- Webb
        G.GAME.odyssey_webb_active = true
    end,
    [38] = function(card, area, copier) -- Kepler
        for k, v in pairs(G.GAME.hands) do
            if v.level > 1 then
                update_hand_stats(k, {level = v.level})
            end
        end
    end,
    [39] = function(card, area, copier) -- Galileu
        -- Create 2 random Tarots immediately
        for i=1, 2 do
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'galileu'..i)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
        end
    end,
    [40] = function(card, area, copier) -- Newton
        -- +1 hand counter when unscored cards are played (hook in 02_utils.lua)
        G.GAME.odyssey_newton_active = true
    end,
    [41] = function(card, area, copier) -- Einstein
        G.GAME.odyssey_einstein_active = true
    end,
    [42] = function(card, area, copier) -- Hawking
        -- Create 2 random Spectrals in consumable area
        for i=1, 2 do
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local new_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'hawking'..i)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
        end
    end,
    [43] = function(card, area, copier) -- Sagan
        local count = 0
        for i=1, #G.playing_cards do
            if G.playing_cards[i].seal or G.playing_cards[i].edition then
                count = count + 1
            end
        end
        ease_dollars(count)
    end,
    [44] = function(card, area, copier) -- Tyson
        -- Level up all hands by 1
        for k, v in pairs(G.GAME.hands) do
            update_hand_stats(k, {level = 1})
        end
    end,
    [45] = function(card, area, copier) -- Kaku
        -- Level up all hands by 2 + +2 hand size
        for k, v in pairs(G.GAME.hands) do
            update_hand_stats(k, {level = 2})
        end
        G.GAME.starting_params.hand_size = (G.GAME.starting_params.hand_size or 8) + 2
        G.hand:change_size(2)
    end,
    [46] = function(card, area, copier) -- Greene
        local card = create_card('Joker', G.jokers, nil, 0.9, nil, nil, nil, 'greene')
        card:add_to_deck()
        G.jokers:emplace(card)
    end,
    [47] = function(card, area, copier) -- Penrose
        -- 25% chance played cards retrigger once (hook in 02_utils.lua)
        G.GAME.odyssey_penrose_active = true
    end,
    [48] = function(card, area, copier) -- Godel
        -- Double blind req this round + X3 Mult as reward
        G.GAME.chips_target = G.GAME.chips_target * 2
        G.GAME.odyssey_spectral_1_xmult = (G.GAME.odyssey_spectral_1_xmult or 1) * 3
    end,
    [49] = function(card, area, copier) -- Turing
        -- Create random Joker + gain $20
        if #G.jokers.cards < G.jokers.config.card_limit then
            local new_joker = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'turing')
            new_joker:add_to_deck()
            G.jokers:emplace(new_joker)
        end
        ease_dollars(20)
    end,
    [50] = function(card, area, copier) -- Oppenheimer
        for i=1, 5 do
            if #G.playing_cards > 0 then
                pseudorandom_element(G.playing_cards, pseudoseed('oppen')):start_dissolve()
            end
        end
        G.GAME.odyssey_spectral_50_next_xmult = 10
    end,
    [51] = function(card, area, copier) -- Feynman
        -- All current Jokers gain +10 base Mult permanently
        for i=1, #G.jokers.cards do
            local j = G.jokers.cards[i]
            if j.ability and j.ability.mult ~= nil then
                j.ability.mult = j.ability.mult + 10
            elseif j.ability then
                j.ability.extra_mult = (j.ability.extra_mult or 0) + 10
            end
        end
        G.GAME.odyssey_feynman_bonus = (G.GAME.odyssey_feynman_bonus or 0) + 10
    end,
    [52] = function(card, area, copier) -- Bohr
        -- Shuffle hand card order
        if G.hand and G.hand.cards and #G.hand.cards > 1 then
            local cards = {}
            for i=1, #G.hand.cards do cards[#cards+1] = G.hand.cards[i] end
            -- Fisher-Yates shuffle
            for i = #cards, 2, -1 do
                local j = math.floor(pseudorandom('bohr_'..i) * i) + 1
                cards[i], cards[j] = cards[j], cards[i]
            end
            -- Reorder cards in the area
            for i = 1, #cards do
                G.hand.cards[i] = cards[i]
            end
            G.hand:reorder()
        end
    end,
    [53] = function(card, area, copier) -- Curie
        -- Randomize all deck card ranks at end of each round
        G.GAME.odyssey_curie_active = true
    end,
    [54] = function(card, area, copier) -- Darwin
        -- Each scored card gains +1 permanent chip (hook in 02_utils.lua)
        G.GAME.odyssey_darwin_active = true
    end,
    [55] = function(card, area, copier) -- Mendel
        -- All deck cards gain a random edition
        local editions = {'foil', 'holo', 'polychrome'}
        for i=1, #G.playing_cards do
            local ed_key = editions[math.floor(pseudorandom('mendel_'..i) * #editions) + 1]
            G.playing_cards[i]:set_edition({[ed_key] = true}, true)
        end
    end,
    [56] = function(card, area, copier) -- Pasteur
        for i=1, #G.playing_cards do
            G.playing_cards[i].ability.perma_debuff_immune = true
        end
    end,
    [57] = function(card, area, copier) -- Fleming
        for i=1, #G.playing_cards do
            G.playing_cards[i].debuff = false
        end
    end,
    [58] = function(card, area, copier) -- Tesla
        -- +2 consumable slots permanently
        if G.consumeables and G.consumeables.config then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 2
        end
    end,
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'edison')
        card:add_to_deck()
        G.jokers:emplace(card)
    end,
    [60] = function(card, area, copier) -- Bell
        local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'bell')
        card:add_to_deck()
        G.consumeables:emplace(card)
    end,
    [61] = function(card, area, copier) -- Marconi
        -- Cards of same rank retrigger once (hook in 02_utils.lua)
        G.GAME.odyssey_marconi_active = true
    end,
    [62] = function(card, area, copier) -- Wright
        -- All playing cards become immune to Boss Blind debuffs
        for i=1, #G.playing_cards do
            G.playing_cards[i].ability.perma_debuff_immune = true
        end
    end,
    [63] = function(card, area, copier) -- Ford
         G.SETTINGS.GAMESPEED = 10
    end,
    [64] = function(card, area, copier) -- Babbage
        -- Next hand played gains X5 Mult
        G.GAME.odyssey_babbage_xmult = 5
    end,
    [65] = function(card, area, copier) -- Lovelace
        -- Sort deck by rank permanently
        if G.playing_cards and #G.playing_cards > 1 then
            local rank_order = {['2']=2,['3']=3,['4']=4,['5']=5,['6']=6,['7']=7,['8']=8,['9']=9,['T']=10,['J']=11,['Q']=12,['K']=13,['A']=14}
            table.sort(G.playing_cards, function(a, b)
                local ra = rank_order[a.base.value] or 0
                local rb = rank_order[b.base.value] or 0
                return ra < rb
            end)
        end
    end,
    [66] = function(card, area, copier) -- Hopper
        -- 10% chance any hand scores X100 (persistent flag, hook in 02_utils.lua)
        G.GAME.odyssey_hopper_active = true
    end,
    [67] = function(card, area, copier) -- Berners-Lee
        -- All current Jokers gain +5 base Mult permanently
        for i=1, #G.jokers.cards do
            local j = G.jokers.cards[i]
            if j.ability and j.ability.mult ~= nil then
                j.ability.mult = j.ability.mult + 5
            end
        end
        G.GAME.odyssey_berners_bonus = (G.GAME.odyssey_berners_bonus or 0) + 5
    end,
    [68] = function(card, area, copier) -- Jobs
        if G.hand.highlighted[1] then
            local c = G.hand.highlighted[1]
            local new_card = create_card('Base', G.deck, nil, nil, nil, nil, nil, 'jobs')
            c:set_base(new_card.config.center)
            new_card:remove()
        end
    end,
    [69] = function(card, area, copier) -- Gates
        -- Flip top 5 deck cards face-up
        if G.deck and G.deck.cards then
            local total = #G.deck.cards
            for i = total, math.max(1, total - 4), -1 do
                if G.deck.cards[i] then
                    G.deck.cards[i].facing = 'front'
                    G.deck.cards[i].sprite_facing = 'front'
                    G.deck.cards[i]:juice_up(0.3, 0.3)
                end
            end
        end
    end,
    [70] = function(card, area, copier) -- Musk
        -- Level up all Flush variants by 5
        local flush_hands = {'Flush', 'Flush House', 'Flush Five', 'Straight Flush', 'Royal Flush'}
        for _, hand_name in ipairs(flush_hands) do
            if G.GAME.hands[hand_name] then
                update_hand_stats(hand_name, {level = 5})
            end
        end
    end,
    [71] = function(card, area, copier) -- Bezos
        for i=1, 3 do
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'bezos')
            card:add_to_deck()
            G.jokers:emplace(card)
        end
    end,
    [72] = function(card, area, copier) -- Zuckerberg
        G.GAME.odyssey_zuckerberg_active = true
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Rede Social!", colour = G.C.FILTER})
    end,
    [73] = function(card, area, copier) -- Nakamoto
        -- Money fluctuates ±50% each hand played (hook in 02_utils.lua)
        G.GAME.odyssey_nakamoto_active = true
    end,
    [74] = function(card, area, copier) -- Vitalik
        G.GAME.odyssey_vitalik_active = true
    end,
    [75] = function(card, area, copier) -- Armstrong
        ease_ante(2)
    end,
    [76] = function(card, area, copier) -- Aldrin
        if #G.jokers.cards > 0 then
            local joker = G.jokers.cards[1]
            for i=2, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity > joker.config.center.rarity then
                    joker = G.jokers.cards[i]
                end
            end
            local copy = copy_card(joker, nil, nil, nil, joker.edition)
            copy:add_to_deck()
            G.jokers:emplace(copy)
        end
    end,
    [77] = function(card, area, copier) -- Collins
        -- Duplicate all current consumables in hand
        local to_dupe = {}
        for i=1, #G.consumeables.cards do
            to_dupe[#to_dupe+1] = G.consumeables.cards[i]
        end
        for i=1, #to_dupe do
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local copy = copy_card(to_dupe[i])
                copy:add_to_deck()
                G.consumeables:emplace(copy)
            end
        end
    end,
    [78] = function(card, area, copier) -- Gagarin
        local card = create_card('Voucher', G.shop_vouchers, nil, nil, nil, nil, nil, 'gagarin')
        card:apply_to_run()
    end,
    [79] = function(card, area, copier) -- Tereshkova
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.value == 'Queen' then
                G.playing_cards[i]:set_edition({polychrome = true}, true)
            end
        end
    end,
    [80] = function(card, area, copier) -- Laika
        -- All current Jokers become Eternal
        for i=1, #G.jokers.cards do
            G.jokers.cards[i]:set_eternal(true)
        end
    end,
    [81] = function(card, area, copier) -- Ham
        -- All current Jokers gain +100 Chips permanently
        for i=1, #G.jokers.cards do
            local j = G.jokers.cards[i]
            if j.ability then
                j.ability.extra_chips = (j.ability.extra_chips or 0) + 100
            end
        end
        G.GAME.odyssey_ham_bonus = (G.GAME.odyssey_ham_bonus or 0) + 100
    end,
    [82] = function(card, area, copier) -- Shepard
        if #G.playing_cards > 0 then
            local weak = G.playing_cards[1]
            for i=2, #G.playing_cards do
                if G.playing_cards[i].base.nominal < weak.base.nominal then
                    weak = G.playing_cards[i]
                end
            end
            weak:start_dissolve()
            ease_dollars(10)
        end
    end,
    [83] = function(card, area, copier) -- Glenn
        for k, v in pairs(G.GAME.hands) do
            v.level = 1
        end
        ease_dollars(100)
    end,
    [84] = function(card, area, copier) -- Leonov
        -- Keep 2 highlighted cards in hand next round
        local kept = 0
        for i=1, #G.hand.highlighted do
            if kept < 2 then
                G.hand.highlighted[i].odyssey_keep_next_round = true
                kept = kept + 1
            end
        end
        G.GAME.odyssey_leonov_keep_count = kept
    end,
    [85] = function(card, area, copier) -- Ride
        add_tag(Tag('tag_coupon'))
        add_tag(Tag('tag_investment'))
    end,
    [86] = function(card, area, copier) -- Hadfield
        -- All Jokers gain X2 Mult for next hand played
        G.GAME.odyssey_hadfield_xmult = 2
    end,
    [87] = function(card, area, copier) -- Kelly
        -- Add a random Seal to all deck cards
        local seals = {'Gold', 'Red', 'Blue', 'Purple'}
        for i=1, #G.playing_cards do
            local seal = seals[math.floor(pseudorandom('kelly_'..i) * #seals) + 1]
            G.playing_cards[i]:set_seal(seal)
        end
    end,
    [88] = function(card, area, copier) -- Pesquet
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.suit == 'Hearts' then
                G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_ceramic, nil)
            end
        end
    end,
    [89] = function(card, area, copier) -- Cristoforetti
        -- +5 Mult stacking per hand played this round (hook in 02_utils.lua)
        G.GAME.odyssey_cristoforetti_active = true
        G.GAME.odyssey_cristoforetti_stacks = 0
    end,
    [90] = function(card, area, copier) -- Gerst
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.suit == 'Clubs' then
                G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_rubber, nil)
            end
        end
    end,
    [91] = function(card, area, copier) -- Peake
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.suit == 'Spades' then
                G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_ruby, nil)
            end
        end
    end,
    [92] = function(card, area, copier) -- Hoshide
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.suit == 'Diamonds' then
                G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_diamond, nil)
            end
        end
    end,
    [93] = function(card, area, copier) -- Yi
        local top_hands = {}
        for k, v in pairs(G.GAME.hands) do
            table.insert(top_hands, {key = k, level = v.level})
        end
        table.sort(top_hands, function(a, b) return a.level > b.level end)
        for i=1, math.min(3, #top_hands) do
            update_hand_stats(top_hands[i].key, {level = 2})
        end
    end,
    [94] = function(card, area, copier) -- Yang
        G.GAME.odyssey_yang_active = true
    end,
    [95] = function(card, area, copier) -- Sharma
        G.GAME.odyssey_sharma_active = true
    end,
    [96] = function(card, area, copier) -- Al Mansoori
        ease_dollars(100 - G.GAME.dollars, true)
        G.GAME.used_vouchers = {}
    end,
    [97] = function(card, area, copier) -- Pontes
        for i=1, #G.playing_cards do
            G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_cloth, nil)
        end
        ease_dollars(15)
    end,
    [98] = function(card, area, copier) -- Vostok
        update_hand_stats('Flush', {level = 3})
        if G.GAME.hands['Flush Five'] then update_hand_stats('Flush Five', {level = 3}) end
    end,
    [99] = function(card, area, copier) -- Mercury
        update_hand_stats('Straight', {level = 3})
        if G.GAME.hands['Straight Flush'] then update_hand_stats('Straight Flush', {level = 3}) end
    end,
    [100] = function(card, area, copier) -- Gemini
        update_hand_stats('Two Pair', {level = 3})
        update_hand_stats('Pair', {level = 3})
    end,
}

for _, s in ipairs(spectrals) do
    SMODS.Consumable({
        key = s.key,
        set = "Spectral",
        atlas = s.id <= 100 and ("spectral_" .. s.id) or nil,
        pos = { x = 0, y = 0 },
        cost = 4,
        discovered = false,
        can_use = function(self, card)
            return true
        end,
        use = function(self, card, area, copier)
            local id = tonumber(self.key:match("spectral_(%d+)"))
            if spectral_logic[id] then
                spectral_logic[id](card, area, copier)
            end
        end,
        loc_vars = function(self, info_queue, card)
            local id = tonumber(self.key:match("spectral_(%d+)"))
            local mapping = {
                [6] = "m_odyssey_diamond",
                [7] = "m_odyssey_ceramic",
                [8] = "m_odyssey_rubber",
                [9] = "m_odyssey_platinum",
                [88] = "m_odyssey_ceramic",
                [90] = "m_odyssey_rubber",
                [92] = "m_odyssey_diamond",
                [97] = "m_odyssey_cloth"
            }
            if mapping[id] then
                info_queue[#info_queue+1] = G.P_CENTERS[mapping[id]]
            end
            if id == 19 then
                info_queue[#info_queue+1] = {set = 'Other', key = 'perishable', vars = {G.GAME.perishable_rounds}}
            end
            if id == 10 or id == 11 or id == 26 then
                info_queue[#info_queue+1] = G.P_CENTERS.e_negative
            end
            if id == 3 then
                info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
            end
            if id == 4 then
                info_queue[#info_queue+1] = G.P_CENTERS.e_foil
            end
            if id == 5 then
                info_queue[#info_queue+1] = G.P_CENTERS.e_holo
            end
            return { vars = {} }
        end
    })
end
