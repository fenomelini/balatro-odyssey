local planets = {
    { id = 1, key = "planet_1", name = "Mercúrio", hand = "Pair" },
    { id = 2, key = "planet_2", name = "Vênus", hand = "Three of a Kind" },
    { id = 3, key = "planet_3", name = "Terra", hand = "Full House" },
    { id = 4, key = "planet_4", name = "Marte", hand = "Four of a Kind" },
    { id = 5, key = "planet_5", name = "Júpiter", hand = "Flush" },
    { id = 6, key = "planet_6", name = "Saturno", hand = "Straight" },
    { id = 7, key = "planet_7", name = "Urano", hand = "Two Pair" },
    { id = 8, key = "planet_8", name = "Netuno", hand = "Straight Flush" },
    { id = 9, key = "planet_9", name = "Plutão", hand = "High Card" },
    { id = 10, key = "planet_10", name = "Planeta X", hand = "Five of a Kind" },
    { id = 11, key = "planet_11", name = "Ceres", hand = "Flush House" },
    { id = 12, key = "planet_12", name = "Eris", hand = "Flush Five" },
    { id = 13, key = "planet_13", name = "Titã", hand = "Two Pair" },
    { id = 14, key = "planet_14", name = "Europa", hand = "Three of a Kind" },
    { id = 15, key = "planet_15", name = "Io", hand = "Straight" },
    { id = 16, key = "planet_16", name = "Ganimedes", hand = "Flush" },
    { id = 17, key = "planet_17", name = "Calisto", hand = "Full House" },
    { id = 18, key = "planet_18", name = "Fobos", hand = "Four of a Kind" },
    { id = 19, key = "planet_19", name = "Deimos", hand = "Straight Flush" },
    { id = 20, key = "planet_20", name = "Caronte", hand = "odyssey_royal_flush" },
    { id = 21, key = "planet_21", name = "Makemake", hand = "odyssey_wrap_around_straight" },
    { id = 22, key = "planet_22", name = "Haumea", hand = "odyssey_jump_straight" },
    { id = 23, key = "planet_23", name = "Sedna", hand = "odyssey_alternating_straight" },
    { id = 24, key = "planet_24", name = "Quaoar", hand = "odyssey_spectrum" },
    { id = 25, key = "planet_25", name = "Orcus", hand = "odyssey_corner_hand" },
    { id = 26, key = "planet_26", name = "Salacia", hand = "odyssey_middle_hand" },
    { id = 27, key = "planet_27", name = "Varda", hand = "odyssey_prime_hand" },
    { id = 28, key = "planet_28", name = "Ixion", hand = "odyssey_fibonacci_hand" },
    { id = 29, key = "planet_29", name = "Varuna", hand = "odyssey_even_hand" },
    { id = 30, key = "planet_30", name = "Caos", hand = "odyssey_odd_hand" },
    { id = 31, key = "planet_31", name = "Proxima", hand = "odyssey_red_hand" },
    { id = 32, key = "planet_32", name = "Alpha", hand = "odyssey_black_hand" },
    { id = 33, key = "planet_33", name = "Sirius", hand = "odyssey_face_hand" },
    { id = 34, key = "planet_34", name = "Vega", hand = "odyssey_number_hand" },
    { id = 35, key = "planet_35", name = "Betelgeuse", hand = "odyssey_low_hand" },
    { id = 36, key = "planet_36", name = "Rigel", hand = "odyssey_high_hand" },
    { id = 37, key = "planet_37", name = "Antares", hand = "odyssey_mega_straight" },
    { id = 38, key = "planet_38", name = "Aldebaran", hand = "odyssey_mega_flush" },
    { id = 39, key = "planet_39", name = "Spica", hand = "odyssey_mega_full_house" },
    { id = 40, key = "planet_40", name = "Pollux", hand = "odyssey_double_three_of_a_kind" },
    { id = 41, key = "planet_41", name = "Castor", hand = "odyssey_triple_pair" },
    { id = 42, key = "planet_42", name = "Deneb", hand = "odyssey_quadruple_pair" },
    { id = 43, key = "planet_43", name = "Altair", hand = "odyssey_quintuple_pair" },
    { id = 44, key = "planet_44", name = "Fomalhaut", hand = "odyssey_six_of_a_kind" },
    { id = 45, key = "planet_45", name = "Regulus", hand = "odyssey_seven_of_a_kind" },
    { id = 46, key = "planet_46", name = "Canopus", hand = "odyssey_eight_of_a_kind" },
    { id = 47, key = "planet_47", name = "Arcturus", hand = "odyssey_nine_of_a_kind" },
    { id = 48, key = "planet_48", name = "Capella", hand = "odyssey_ten_of_a_kind" },
    { id = 49, key = "planet_49", name = "Achernar", hand = "odyssey_flush_pair" },
    { id = 50, key = "planet_50", name = "Hadar", hand = "odyssey_flush_two_pair" },
    { id = 51, key = "planet_51", name = "Acrux", hand = "odyssey_flush_three_of_a_kind" },
    { id = 52, key = "planet_52", name = "Mimosa", hand = "odyssey_flush_four_of_a_kind" },
    { id = 53, key = "planet_53", name = "Gacrux", hand = "odyssey_flush_six_of_a_kind" },
    { id = 54, key = "planet_54", name = "Bellatrix", hand = "odyssey_flush_seven_of_a_kind" },
    { id = 55, key = "planet_55", name = "Elnath", hand = "odyssey_flush_eight_of_a_kind" },
    { id = 56, key = "planet_56", name = "Alnilam", hand = "odyssey_flush_nine_of_a_kind" },
    { id = 57, key = "planet_57", name = "Alnitak", hand = "odyssey_flush_ten_of_a_kind" },
    { id = 58, key = "planet_58", name = "Mintaka", hand = "odyssey_super_royal_flush" },
    { id = 59, key = "planet_59", name = "Saiph", hand = "odyssey_ultimate_flush" },
    { id = 60, key = "planet_60", name = "Kepler", hand = "odyssey_all_hands" },
    { id = 61, key = "planet_61", name = "Kepler-22b", hand = "Pair" },
    { id = 62, key = "planet_62", name = "Kepler-186f", hand = "Three of a Kind" },
    { id = 63, key = "planet_63", name = "Kepler-452b", hand = "Full House" },
    { id = 64, key = "planet_64", name = "Kepler-62f", hand = "Four of a Kind" },
    { id = 65, key = "planet_65", name = "TRAPPIST-1d", hand = "Flush" },
    { id = 66, key = "planet_66", name = "TRAPPIST-1e", hand = "Straight" },
    { id = 67, key = "planet_67", name = "TRAPPIST-1f", hand = "Two Pair" },
    { id = 68, key = "planet_68", name = "TRAPPIST-1g", hand = "Straight Flush" },
    { id = 69, key = "planet_69", name = "Gliese 581g", hand = "High Card" },
    { id = 70, key = "planet_70", name = "Gliese 667Cc", hand = "Five of a Kind" },
    { id = 71, key = "planet_71", name = "HD 40307g", hand = "Flush House" },
    { id = 72, key = "planet_72", name = "HD 85512b", hand = "Flush Five" },
    { id = 73, key = "planet_73", name = "Tau Ceti e", hand = "odyssey_royal_flush" },
    { id = 74, key = "planet_74", name = "Kapteyn b", hand = "odyssey_secret_hand_1" },
    { id = 75, key = "planet_75", name = "Wolf 1061c", hand = "odyssey_secret_hand_2" },
    { id = 76, key = "planet_76", name = "GJ 357 d", hand = "odyssey_secret_hand_3" },
    { id = 77, key = "planet_77", name = "LHS 1140 b", hand = "odyssey_secret_hand_4" },
    { id = 78, key = "planet_78", name = "Teegarden b", hand = "odyssey_secret_hand_5" },
    { id = 79, key = "planet_79", name = "Ross 128 b", hand = "odyssey_secret_hand_6" },
    { id = 80, key = "planet_80", name = "Luyten b", hand = "odyssey_secret_hand_7" },
    { id = 81, key = "planet_81", name = "K2-18b", hand = "odyssey_secret_hand_8" },
    { id = 82, key = "planet_82", name = "TOI-700 d", hand = "odyssey_secret_hand_9" },
    { id = 83, key = "planet_83", name = "Kepler-1649c", hand = "odyssey_secret_hand_10" },
    { id = 84, key = "planet_84", name = "Kepler-442b", hand = "odyssey_secret_hand_11" },
    { id = 85, key = "planet_85", name = "Kepler-1638b", hand = "odyssey_secret_hand_12" },
    { id = 86, key = "planet_86", name = "Kepler-296f", hand = "odyssey_secret_hand_13" },
    { id = 87, key = "planet_87", name = "Kepler-174d", hand = "odyssey_secret_hand_14" },
    { id = 88, key = "planet_88", name = "Kepler-62e", hand = "odyssey_secret_hand_15" },
    { id = 89, key = "planet_89", name = "Kepler-1229b", hand = "odyssey_secret_hand_16" },
    { id = 90, key = "planet_90", name = "Kepler-1544b", hand = "odyssey_secret_hand_17" },
    { id = 91, key = "planet_91", name = "Kepler-1652b", hand = "odyssey_secret_hand_18" },
    { id = 92, key = "planet_92", name = "Kepler-1410b", hand = "odyssey_secret_hand_19" },
    { id = 93, key = "planet_93", name = "Kepler-155c", hand = "odyssey_secret_hand_20" },
    { id = 94, key = "planet_94", name = "Kepler-283c", hand = "odyssey_secret_hand_21" },
    { id = 95, key = "planet_95", name = "Kepler-438b", hand = "odyssey_secret_hand_22" },
    { id = 96, key = "planet_96", name = "Kepler-440b", hand = "odyssey_secret_hand_23" },
    { id = 97, key = "planet_97", name = "Kepler-443b", hand = "odyssey_secret_hand_24" },
    { id = 98, key = "planet_98", name = "Kepler-296e", hand = "odyssey_secret_hand_25" },
    { id = 99, key = "planet_99", name = "Kepler-1653b", hand = "odyssey_secret_hand_26" },
    { id = 100, key = "planet_100", name = "Kepler-1512b", hand = "odyssey_secret_hand_27" },
}

for _, p in ipairs(planets) do
    local planet_def = {
        key = p.key,
        atlas = "planet_" .. p.id,
        pos = { x = 0, y = 0 },
        config = { hand_type = p.hand },
        discovered = false,
        set = "Planet",
        cost = 3,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { localize(p.hand, 'poker_hands') } }

        end
    }

    if p.id == 60 then
        planet_def.use = function(self, card, area, copier)
            local used_tarot = copier or card
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                for k, v in pairs(G.GAME.hands) do
                    level_up_hand(used_tarot, k, nil, 1)
                end
                return true
            end }))
        end
    end

    SMODS.Planet(planet_def)
end

