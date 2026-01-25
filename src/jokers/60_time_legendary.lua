-- ============================================
-- TIME & TURNS - Legendary (Jokers 649-650)
-- ============================================

-- 649: Father Time
SMODS.Joker({
    unlocked = true,
    key = 'j_time_father_time',
    discovered = true,
    config = { extra = { xmult = 5 } },
    rarity = 4,
    cost = 20,
    atlas = 'j_time_father_time',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})

-- 650: Guardian of Eternity
SMODS.Joker({
    unlocked = true,
    key = 'j_time_guardian_of_eternity',
    discovered = true,
    config = { extra = { xmult = 4 } },
    rarity = 4,
    cost = 20,
    atlas = 'j_time_guardian_of_eternity',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { card.ability.extra.xmult } } end,
    add_to_deck = function(self, card)
        G.GAME.odyssey_guardian_of_eternity = (G.GAME.odyssey_guardian_of_eternity or 0) + 1
        if G.jokers and G.jokers.cards then
            for _, v in ipairs(G.jokers.cards) do
                v.ability.eternal = true
            end
        end
    end,
    remove_from_deck = function(self, card)
        G.GAME.odyssey_guardian_of_eternity = nil
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.xmult,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
            }
        end
    end
})
