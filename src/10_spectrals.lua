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
            for i=1, 2 do G.jokers.cards[1]:start_dissolve() end
            local card = create_card('Joker', G.jokers, nil, 3, nil, nil, nil, 'sing')
            card:set_edition({negative = true}, true)
            card:add_to_deck()
            G.jokers:emplace(card)
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
    [33] = function(card, area, copier) -- Pauli
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
        G.GAME.odyssey_drake_active = true
    end,
    [38] = function(card, area, copier) -- Kepler
        for k, v in pairs(G.GAME.hands) do
            if v.level > 1 then
                update_hand_stats(k, {level = v.level})
            end
        end
    end,
    [39] = function(card, area, copier) -- Galileu
        G.GAME.odyssey_galileo_active = true
    end,
    [40] = function(card, area, copier) -- Newton
        G.GAME.odyssey_newton_active = true
    end,
    [41] = function(card, area, copier) -- Einstein
        G.GAME.odyssey_einstein_active = true
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
    [46] = function(card, area, copier) -- Greene
        local card = create_card('Joker', G.jokers, nil, 0.9, nil, nil, nil, 'greene')
        card:add_to_deck()
        G.jokers:emplace(card)
    end,
    [50] = function(card, area, copier) -- Oppenheimer
        for i=1, 5 do
            if #G.playing_cards > 0 then
                pseudorandom_element(G.playing_cards, pseudoseed('oppen')):start_dissolve()
            end
        end
        G.GAME.odyssey_spectral_50_next_xmult = 10
    end,
    [53] = function(card, area, copier) -- Curie
        G.GAME.odyssey_curie_active = true
    end,
    [54] = function(card, area, copier) -- Darwin
        G.GAME.odyssey_darwin_active = true
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
    [59] = function(card, area, copier) -- Edison
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'edison')
        card:add_to_deck()
        G.jokers:emplace(card)
    end,
    [60] = function(card, area, copier) -- Bell
        local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'bell')
        card:add_to_deck()
        G.consumeables:emplace(card)
    end,
    [63] = function(card, area, copier) -- Ford
         G.SETTINGS.GAMESPEED = 10
    end,
    [68] = function(card, area, copier) -- Jobs
        if G.hand.highlighted[1] then
            local c = G.hand.highlighted[1]
            local new_card = create_card('Default', G.deck, nil, nil, nil, nil, nil, 'jobs')
            c:set_base(new_card.config.center)
            new_card:remove()
        end
    end,
    [71] = function(card, area, copier) -- Bezos
        for i=1, 3 do
            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'bezos')
            card:add_to_deck()
            G.jokers:emplace(card)
        end
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
    [85] = function(card, area, copier) -- Ride
        add_tag(Tag('tag_coupon'))
        add_tag(Tag('tag_investment'))
    end,
    [88] = function(card, area, copier) -- Pesquet
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.suit == 'Hearts' then
                G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_ceramic, nil)
            end
        end
    end,
    [90] = function(card, area, copier) -- Gerst
        for i=1, #G.playing_cards do
            if G.playing_cards[i].base.suit == 'Clubs' then
                G.playing_cards[i]:set_ability(G.P_CENTERS.m_odyssey_rubber, nil)
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
        G.GAME.odyssey_vostok_active = true
    end,
    [99] = function(card, area, copier) -- Mercury
        G.GAME.odyssey_mercury_vessel_active = true
    end,
    [100] = function(card, area, copier) -- Gemini
        G.GAME.odyssey_gemini_active = true
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
