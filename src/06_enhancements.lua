local enhancements = {}

-- Atlas for Enhancements (User needs to provide odyssey_enhancements.png)
-- Grid 4x4 for the 16 enhancements
-- Row 1: Wood, Plastic, Rubber, Shadow
-- Row 2: Ceramic, Cloth, Paper, Light
-- Row 3: Diamond, Ruby, Emerald, Plant
-- Row 4: Holy, Undead, Cursed, Magic

-- 1. Madeira (Wood)
-- Effect: +10 Chips, 1 in 8 chance to break
SMODS.Enhancement({
    key = 'wood',
    atlas = 'enhancements',
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 10, chance = 8 } },
    loc_txt = {
        name = 'Carta de Madeira',
        text = {
            "{C:chips}+#1#{} Fichas",
            "{C:green}#2# em #3#{} chance de",
            "quebrar ao pontuar"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.destroy_card and context.cardarea == G.play then
            if pseudorandom('wood_break') < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    remove = true
                }
            end
        end
    end
})

-- 2. Plástico (Plastic)
-- Effect: $3 when in hand at end of round
SMODS.Enhancement({
    key = 'plastic',
    atlas = 'enhancements',
    pos = { x = 1, y = 0 },
    config = { extra = { dollars = 3 } },
    loc_txt = {
        name = 'Carta de Plástico',
        text = {
            "Ganha {C:money}$#1#{} se esta",
            "carta estiver na mão",
            "ao final da rodada"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context, effect)
        if context.individual and context.cardarea == G.hand and context.end_of_round then
            if G.GAME.odyssey_money_laundering_active and G.GAME.odyssey_money_laundering_active > 0 then
                return nil
            end
            return {
                dollars = card.ability.extra.dollars,
                card = card
            }
        end
    end
})

-- 3. Borracha (Rubber)
-- Effect: Retrigger (Bouncy)
SMODS.Enhancement({
    key = 'rubber',
    atlas = 'enhancements',
    pos = { x = 2, y = 0 },
    config = {},
    loc_txt = {
        name = 'Carta de Borracha',
        text = {
            "Reativa esta carta",
            "{C:attention}1{} vez adicional"
        }
    },
    calculate = function(self, card, context, effect)
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
})

-- 4. Cerâmica (Ceramic)
-- Effect: X1.5 Mult, 1 in 4 chance to break
SMODS.Enhancement({
    key = 'ceramic',
    atlas = 'enhancements',
    pos = { x = 0, y = 1 },
    config = { extra = { xmult = 1.5, chance = 4 } },
    loc_txt = {
        name = 'Carta de Cerâmica',
        text = {
            "{X:mult,C:white} X#1# {} Mult",
            "{C:green}#2# em #3#{} chance de",
            "quebrar ao pontuar"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult, G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.xmult
            }
        end
        if context.destroy_card and context.cardarea == G.play then
            if pseudorandom('ceramic_break') < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    remove = true
                }
            end
        end
    end
})

-- 5. Tecido (Cloth)
-- Effect: +5 Chips, +2 Mult
SMODS.Enhancement({
    key = 'cloth',
    atlas = 'enhancements',
    pos = { x = 1, y = 1 },
    config = { extra = { chips = 5, mult = 2 } },
    loc_txt = {
        name = 'Carta de Tecido',
        text = {
            "{C:chips}+#1#{} Fichas",
            "{C:mult}+#2#{} Mult"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, extra.mult } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
})

-- 6. Papel (Paper)
-- Effect: +30 Chips, 1 in 6 chance to break
SMODS.Enhancement({
    key = 'paper',
    atlas = 'enhancements',
    pos = { x = 2, y = 1 },
    config = { extra = { chips = 30, chance = 6 } },
    loc_txt = {
        name = 'Carta de Papel',
        text = {
            "{C:chips}+#1#{} Fichas",
            "{C:green}#2# em #3#{} chance de",
            "quebrar ao pontuar"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips, G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.destroy_card and context.cardarea == G.play then
            if pseudorandom('paper_break') < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    remove = true
                }
            end
        end
    end
})

-- 7. Diamante (Diamond)
-- Effect: $1 when scored
SMODS.Enhancement({
    key = 'diamond',
    atlas = 'enhancements',
    pos = { x = 0, y = 2 },
    config = { extra = { dollars = 1 } },
    loc_txt = {
        name = 'Carta de Diamante',
        text = {
            "Ganha {C:money}$#1#{} quando",
            "esta carta pontua"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.dollars } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
})

-- 8. Rubi (Ruby)
-- Effect: +10 Mult
SMODS.Enhancement({
    key = 'ruby',
    atlas = 'enhancements',
    pos = { x = 1, y = 2 },
    config = { extra = { mult = 10 } },
    loc_txt = {
        name = 'Carta de Rubi',
        text = {
            "{C:mult}+#1#{} Mult"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})

-- 9. Esmeralda (Emerald)
-- Effect: +50 Chips
SMODS.Enhancement({
    key = 'emerald',
    atlas = 'enhancements',
    pos = { x = 2, y = 2 },
    config = { extra = { chips = 50 } },
    loc_txt = {
        name = 'Carta de Esmeralda',
        text = {
            "{C:chips}+#1#{} Fichas"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})

-- 10. Sombra (Shadow)
-- Effect: X1.5 Mult when scored
SMODS.Enhancement({
    key = 'shadow',
    atlas = 'enhancements',
    pos = { x = 3, y = 0 },
    config = { extra = { xmult = 1.5 } },
    loc_txt = {
        name = 'Carta de Sombra',
        text = {
            "{X:mult,C:white} X#1# {} Mult"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.xmult
            }
        end
    end
})

-- 11. Luz (Light)
-- Effect: 1 in 4 chance to gain  when scored
SMODS.Enhancement({
    key = 'light',
    atlas = 'enhancements',
    pos = { x = 3, y = 1 },
    config = { extra = { dollars = 3, chance = 4 } },
    loc_txt = {
        name = 'Carta de Luz',
        text = {
            "{C:green}#1# em #2#{} chance de",
            "ganhar {C:money}$#3#{}"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { G.GAME.probabilities.normal, extra.chance, extra.dollars } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('light_money') < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
})

-- 12. Planta (Plant)
-- Effect: Gains +5 Chips when scored
SMODS.Enhancement({
    key = 'plant',
    atlas = 'enhancements',
    pos = { x = 3, y = 2 },
    config = { extra = { chips_gain = 5 } },
    loc_txt = {
        name = 'Carta de Planta',
        text = {
            "Ganha {C:chips}+#1#{} Fichas",
            "quando pontua"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips_gain } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra_chips = (card.ability.extra_chips or 0) + card.ability.extra.chips_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
})

-- 13. Sagrada (Holy)
-- Effect: +10 Mult, +30 Chips
SMODS.Enhancement({
    key = 'holy',
    atlas = 'enhancements',
    pos = { x = 0, y = 3 },
    config = { extra = { mult = 10, chips = 30 } },
    loc_txt = {
        name = 'Carta Sagrada',
        text = {
            "{C:mult}+#1#{} Mult",
            "{C:chips}+#2#{} Fichas"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.mult, extra.chips } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
})

-- 14. Morta-Viva (Undead)
-- Effect: 1 in 3 chance to retrigger
SMODS.Enhancement({
    key = 'undead',
    atlas = 'enhancements',
    pos = { x = 1, y = 3 },
    config = { extra = { chance = 3 } },
    loc_txt = {
        name = 'Carta Morta-Viva',
        text = {
            "{C:green}#1# em #2#{} chance de",
            "reativar esta carta"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context, effect)
        if context.repetition and context.cardarea == G.play then
            if pseudorandom('undead_retrigger') < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- 15. Maldita (Cursed)
-- Effect: X2 Mult, -20 Chips
SMODS.Enhancement({
    key = 'cursed',
    atlas = 'enhancements',
    pos = { x = 2, y = 3 },
    config = { extra = { xmult = 2, chips_loss = 20 } },
    loc_txt = {
        name = 'Carta Maldita',
        text = {
            "{X:mult,C:white} X#1# {} Mult",
            "{C:chips}-#2#{} Fichas"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.xmult, extra.chips_loss } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.xmult,
                chips = -card.ability.extra.chips_loss
            }
        end
    end
})

-- 16. Mágica (Magic)
-- Effect: 1 in 6 chance to create a Tarot card when scored
SMODS.Enhancement({
    key = 'magic',
    atlas = 'enhancements',
    pos = { x = 3, y = 3 },
    config = { extra = { chance = 6 } },
    loc_txt = {
        name = 'Carta Mágica',
        text = {
            "{C:green}#1# em #2#{} chance de",
            "criar uma carta de {C:tarot}Tarô{}",
            "quando pontua"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { G.GAME.probabilities.normal, extra.chance } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('magic_tarot') < G.GAME.probabilities.normal / card.ability.extra.chance then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'magic_enhancement')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_tarot'),
                        colour = G.C.PURPLE,
                        card = card
                    }
                end
            end
        end
    end
})

-- 17. Platina (Platinum)
-- Effect: +100 Chips
SMODS.Enhancement({
    key = 'platinum',
    atlas = 'v_platinum',
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 100 } },
    loc_txt = {
        name = 'Carta de Platina',
        text = {
            "{C:chips}+#1#{} Fichas"
        }
    },
    loc_vars = function(self, info_queue, card)

        local extra = (card and card.ability.extra or self.config.extra)

        return { vars = { extra.chips } }

    end,
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})


