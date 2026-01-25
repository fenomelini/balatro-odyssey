-- J989-998: Final & Specials (Rare)

-- Enlightenment (J989)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_enlightenment',
    config = { extra = { x_mult = 4 } },
    rarity = 3,
    atlas = 'j_final_enlightenment',
    pos = { x = 0, y = 0 },
    cost = 15,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
        if context.setting_blind and not context.blueprint then
            for k, v in ipairs(G.playing_cards) do
                v:set_ability(G.P_CENTERS.m_odyssey_ceramic)
            end
        end
    end
})

-- Ascension (J990)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_ascension',
    config = { extra = { x_mult = 5 } },
    rarity = 3,
    atlas = 'j_final_ascension',
    pos = { x = 0, y = 0 },
    cost = 15,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Transcendence (J991)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_transcendence',
    config = { extra = { x_mult = 6 } },
    rarity = 3,
    atlas = 'j_final_transcendence',
    pos = { x = 0, y = 0 },
    cost = 15,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            local bonus = card.ability.extra.x_mult
            for k, v in ipairs(G.jokers.cards) do
                if v.config.center.rarity == 4 then bonus = bonus * 2; break end
            end
            return {
                x_mult = bonus,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { bonus } }
            }
        end
    end
})

-- Divinity (J992)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_divinity',
    config = { extra = { x_mult = 7 } },
    rarity = 3,
    atlas = 'j_final_divinity',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Omniscience (J993)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_omniscience',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_final_omniscience',
    pos = { x = 0, y = 0 },
    cost = 15,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            if G.GAME.blind and not G.GAME.blind.reveal_boss then 
                G.GAME.blind:reveal_boss()
            end
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Omnipotence (J994)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_omnipotence',
    config = { extra = { x_mult = 10, hand_size = -2 } },
    rarity = 3,
    atlas = 'j_final_omnipotence',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult, card.ability.extra.hand_size } } end,
    add_to_deck = function(self, card)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end
})

-- Omnipresence (J995)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_omnipresence',
    rarity = 3,
    atlas = 'j_final_omnipresence',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.retrigger_joker and not context.blueprint then
            if context.other_joker ~= card then
                return {
                    message = 'OMNIPRESENCE',
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
})

-- Eternity (J996)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_eternity',
    config = { extra = { x_mult = 3 } },
    rarity = 3,
    atlas = 'j_final_eternity',
    pos = { x = 0, y = 0 },
    cost = 15,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
        if context.setting_blind and not context.blueprint then
            for k, v in ipairs(G.jokers.cards) do
                v:set_eternal(true)
            end
        end
    end
})

-- Infinity (J997)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_infinity',
    rarity = 3,
    atlas = 'j_final_infinity',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) 
        local bonus = G.GAME.hands_played or 0
        return { vars = { bonus } } 
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local bonus = G.GAME.hands_played or 0
            return {
                mult_mod = bonus,
                message = localize{ type = 'variable', key = 'a_mult', vars = { bonus } }
            }
        end
    end
})

-- Absolute (J998)
SMODS.Joker({
    discovered = true,
    unlocked = true,
    key = 'j_final_absolute',
    config = { extra = { min_mult = 1000, x_mult = 2 } },
    rarity = 3,
    atlas = 'j_final_absolute',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.min_mult, card.ability.extra.x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                mult_mod = 500,
                message = "ABSOLUTE"
            }
        end
    end
})
