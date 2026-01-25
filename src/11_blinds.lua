local blind_multipliers = {
    [3] = 4.0, [4] = 4.0, [5] = 4.0, [6] = 10.0, [7] = 4.0, [8] = 4.0, [9] = 4.0, [10] = 4.0,
    [11] = 4.0, [12] = 4.0, [13] = 4.0, [14] = 4.0, [15] = 4.0, [16] = 4.0, [17] = 4.0, [18] = 4.0, [19] = 4.0, [20] = 4.0,
    [21] = 20.0, [22] = 4.0, [23] = 4.0, [24] = 4.0, [25] = 4.0, [26] = 4.0, [27] = 4.0, [28] = 4.0, [29] = 4.0, [30] = 4.0,
    [31] = 4.0, [32] = 4.0, [33] = 4.0, [34] = 4.0, [35] = 4.0, [36] = 4.0, [37] = 4.0, [38] = 4.0, [39] = 4.0, [40] = 4.0,
    [41] = 40.0, [42] = 4.0, [43] = 4.0, [44] = 4.0, [45] = 4.0, [46] = 4.0, [47] = 4.0, [48] = 4.0, [49] = 4.0, [50] = 4.0,
    [51] = 4.0, [52] = 4.0, [53] = 4.0, [54] = 4.0, [55] = 4.0, [56] = 4.0, [57] = 4.0, [58] = 8.0, [59] = 4.0, [60] = 4.0,
    [61] = 4.0, [62] = 4.0, [63] = 4.0, [64] = 4.0, [65] = 4.0, [66] = 12.0, [67] = 15.0, [68] = 4.0, [69] = 4.0, [70] = 4.0,
    [71] = 12.0, [72] = 4.0, [73] = 4.0, [74] = 4.0, [75] = 4.0, [76] = 4.0, [77] = 4.0, [78] = 4.0, [79] = 4.0, [80] = 4.0,
    [81] = 4.0, [82] = 4.0, [83] = 4.0, [84] = 8.0, [85] = 4.0, [86] = 4.0, [87] = 4.0, [88] = 15.0, [89] = 15.0, [90] = 4.0,
    [91] = 4.0, [92] = 4.0, [93] = 4.0, [94] = 4.0, [95] = 4.0, [96] = 4.0, [97] = 4.0, [98] = 4.0, [99] = 4.0, [100] = 100.0,
}

local blinds = {
    { id = 3, key = "blind_3", name = "The Hook" },
    { id = 4, key = "blind_4", name = "The Ox" },
    { id = 5, key = "blind_5", name = "The House" },
    { id = 6, key = "blind_6", name = "The Wall" },
    { id = 7, key = "blind_7", name = "The Wheel" },
    { id = 8, key = "blind_8", name = "The Arm" },
    { id = 9, key = "blind_9", name = "The Club" },
    { id = 10, key = "blind_10", name = "The Fish" },
    { id = 11, key = "blind_11", name = "The Psychic" },
    { id = 12, key = "blind_12", name = "The Goad" },
    { id = 13, key = "blind_13", name = "The Water" },
    { id = 14, key = "blind_14", name = "The Window" },
    { id = 15, key = "blind_15", name = "The Manacle" },
    { id = 16, key = "blind_16", name = "The Eye" },
    { id = 17, key = "blind_17", name = "The Mouth" },
    { id = 18, key = "blind_18", name = "The Plant" },
    { id = 19, key = "blind_19", name = "The Serpent" },
    { id = 20, key = "blind_20", name = "The Pillar" },
    { id = 21, key = "blind_21", name = "A Muralha de Aço" },
    { id = 22, key = "blind_22", name = "O Vampiro" },
    { id = 23, key = "blind_23", name = "A Guilhotina" },
    { id = 24, key = "blind_24", name = "O Labirinto" },
    { id = 25, key = "blind_25", name = "A Névoa" },
    { id = 26, key = "blind_26", name = "O Espelho Quebrado" },
    { id = 27, key = "blind_27", name = "A Areia Movediça" },
    { id = 28, key = "blind_28", name = "O Buraco Negro" },
    { id = 29, key = "blind_29", name = "A Supernova" },
    { id = 30, key = "blind_30", name = "O Quasar" },
    { id = 31, key = "blind_31", name = "O Pulsar" },
    { id = 32, key = "blind_32", name = "O Ímã" },
    { id = 33, key = "blind_33", name = "O Prisma" },
    { id = 34, key = "blind_34", name = "O Vazio" },
    { id = 35, key = "blind_35", name = "O Tempo" },
    { id = 36, key = "blind_36", name = "O Espaço" },
    { id = 37, key = "blind_37", name = "A Matéria" },
    { id = 38, key = "blind_38", name = "A Energia" },
    { id = 39, key = "blind_39", name = "A Entropia" },
    { id = 40, key = "blind_40", name = "O Caos" },
    { id = 41, key = "blind_41", name = "A Fortaleza" },
    { id = 42, key = "blind_42", name = "O Titã" },
    { id = 43, key = "blind_43", name = "O Colosso" },
    { id = 44, key = "blind_44", name = "A Hidra" },
    { id = 45, key = "blind_45", name = "O Basilisco" },
    { id = 46, key = "blind_46", name = "A Quimera" },
    { id = 47, key = "blind_47", name = "O Grifo" },
    { id = 48, key = "blind_48", name = "O Kraken" },
    { id = 49, key = "blind_49", name = "O Leviatã" },
    { id = 50, key = "blind_50", name = "O Behemoth" },
    { id = 51, key = "blind_51", name = "A Esfinge" },
    { id = 52, key = "blind_52", name = "O Faraó" },
    { id = 53, key = "blind_53", name = "A Múmia" },
    { id = 54, key = "blind_54", name = "O Escaravelho" },
    { id = 55, key = "blind_55", name = "O Oásis" },
    { id = 56, key = "blind_56", name = "A Tempestade de Areia" },
    { id = 57, key = "blind_57", name = "A Miragem" },
    { id = 58, key = "blind_58", name = "O Djinn" },
    { id = 59, key = "blind_59", name = "O Sultão" },
    { id = 60, key = "blind_60", name = "O Nômade" },
    { id = 61, key = "blind_61", name = "O Grande Atrator" },
    { id = 62, key = "blind_62", name = "A Singularidade" },
    { id = 63, key = "blind_63", name = "O Horizonte de Eventos" },
    { id = 64, key = "blind_64", name = "A Espaguetificação" },
    { id = 65, key = "blind_65", name = "A Radiação Hawking" },
    { id = 66, key = "blind_66", name = "O Big Bang" },
    { id = 67, key = "blind_67", name = "A Inflação Cósmica" },
    { id = 68, key = "blind_68", name = "A Matéria Escura" },
    { id = 69, key = "blind_69", name = "A Energia Escura" },
    { id = 70, key = "blind_70", name = "O Vácuo Quântico" },
    { id = 71, key = "blind_71", name = "O Multiverso" },
    { id = 72, key = "blind_72", name = "A Linha do Tempo Sagrada" },
    { id = 73, key = "blind_73", name = "O Paradoxo de Fermi" },
    { id = 74, key = "blind_74", name = "O Gato de Schrodinger" },
    { id = 75, key = "blind_75", name = "O Demônio de Maxwell" },
    { id = 76, key = "blind_76", name = "A Entropia Máxima" },
    { id = 77, key = "blind_77", name = "A Morte Térmica" },
    { id = 78, key = "blind_78", name = "O Big Crunch" },
    { id = 79, key = "blind_79", name = "O Big Rip" },
    { id = 80, key = "blind_80", name = "O Falso Vácuo" },
    { id = 81, key = "blind_81", name = "O Criador" },
    { id = 82, key = "blind_82", name = "O Destruidor" },
    { id = 83, key = "blind_83", name = "O Observador" },
    { id = 84, key = "blind_84", name = "O Arquiteto" },
    { id = 85, key = "blind_85", name = "O Guardião" },
    { id = 86, key = "blind_86", name = "A Verdade" },
    { id = 87, key = "blind_87", name = "A Mentira" },
    { id = 88, key = "blind_88", name = "O Infinito" },
    { id = 89, key = "blind_89", name = "O Zero" },
    { id = 90, key = "blind_90", name = "Alpha & Omega" },
    { id = 91, key = "blind_91", name = "O Código" },
    { id = 92, key = "blind_92", name = "A Matriz" },
    { id = 93, key = "blind_93", name = "O Erro" },
    { id = 94, key = "blind_94", name = "O Crash" },
    { id = 95, key = "blind_95", name = "A Tela Azul" },
    { id = 96, key = "blind_96", name = "O Vírus" },
    { id = 97, key = "blind_97", name = "O Antivírus" },
    { id = 98, key = "blind_98", name = "O Firewall" },
    { id = 99, key = "blind_99", name = "O Hacker" },
    { id = 100, key = "blind_100", name = "A Odisseia Final" },
}

for _, b in ipairs(blinds) do
    local config = {
        key = b.key,
        atlas = "blind_" .. b.id,
        pos = { x = 0, y = 0 },
        dollars = 5,
        mult = blind_multipliers[b.id] or 4,
        vars = {},
        discovered = true
    }
    
    config.boss = { min = 1, max = 10 }
    if b.id == 100 then -- Showdown
        config.boss.showdown = true
        config.boss.min = 8
    end

    -- Lógica específica para cada Blind
    if b.id == 43 then -- O Colosso: 2-9 não pontuam
        config.debuff_card = function(self, card, from_blind)
            if not self.disabled and card.area ~= G.jokers then
                local rank = card:get_id()
                if rank >= 2 and rank <= 9 then
                    card:set_debuff(true)
                    return true
                end
            end
            card:set_debuff(false)
        end
    elseif b.id == 24 then -- O Labirinto: Exatamente 3 cartas
        config.debuff_hand = function(self, cards, hand, handname, check)
            if not self.disabled and #cards ~= 3 then
                self.triggered = true
                return true
            end
            self.triggered = false
        end
    elseif b.id == 49 then -- O Leviatã: Mãos de 5 cartas proibidas
        config.debuff_hand = function(self, cards, hand, handname, check)
            if not self.disabled and #cards == 5 then
                self.triggered = true
                return true
            end
            self.triggered = false
        end
    elseif b.id == 50 then -- O Behemoth: Menos de 5 cartas proibidas
        config.debuff_hand = function(self, cards, hand, handname, check)
            if not self.disabled and #cards < 5 then
                self.triggered = true
                return true
            end
            self.triggered = false
        end
    elseif b.id == 18 then -- A Planta: Figuras debuffed
        config.debuff_card = function(self, card, from_blind)
            if not self.disabled and card.area ~= G.jokers and card:is_face() then
                card:set_debuff(true)
                return true
            end
            card:set_debuff(false)
        end
    elseif b.id == 47 then -- O Grifo: Não pode jogar o mesmo tipo de mão duas vezes seguidas
        config.debuff_hand = function(self, cards, hand, handname, check)
            if not self.disabled and G.GAME.last_hand_type == handname then
                self.triggered = true
                return true
            end
            self.triggered = false
        end
    elseif b.id == 75 then -- O Demônio de Maxwell: Deve ordenar as cartas para pontuar
        config.debuff_hand = function(self, cards, hand, handname, check)
            if not self.disabled then
                local sorted = true
                -- Verificar se está em ordem crescente
                for i = 1, #cards - 1 do
                    if cards[i].base.id > cards[i+1].base.id then
                        sorted = false
                        break
                    end
                end
                -- Se não estiver em crescente, verificar decrescente
                if not sorted then
                    sorted = true
                    for i = 1, #cards - 1 do
                        if cards[i].base.id < cards[i+1].base.id then
                            sorted = false
                            break
                        end
                    end
                end
                
                if not sorted then
                    self.triggered = true
                    return true
                end
            end
            self.triggered = false
        end
    elseif b.id == 32 then -- O Ímã: Apenas um naipe permitido
        config.debuff_hand = function(self, cards, hand, handname, check)
            if not self.disabled then
                local suit = nil
                for i = 1, #cards do
                    if not suit then suit = cards[i].base.suit
                    elseif cards[i].base.suit ~= suit then
                        self.triggered = true
                        return true
                    end
                end
            end
            self.triggered = false
        end
    end
    
    SMODS.Blind(config)
end
