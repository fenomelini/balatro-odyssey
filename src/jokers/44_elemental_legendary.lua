-- ============================================
-- ELEMENTAL - Legendary (Jokers 449-450)
-- ============================================

-- 449. Avatar
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_avatar',
    discovered = false,
    config = { extra = { x_mult = 4 } },
    rarity = 4,
    atlas = 'j_elemental_avatar',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
            }
        end
        if context.setting_blind then
            G.GAME.modifiers.odyssey_any_flush = true
        end
    end
})

-- 450. Cataclysm
SMODS.Joker({
    unlocked = true,
    key = 'j_elemental_cataclysm',
    discovered = false,
    config = { extra = { x_mult = 10 } },
    rarity = 4,
    atlas = 'j_elemental_cataclysm',
    pos = { x = 0, y = 0 },
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card) return { vars = { (( (card and card.ability and card.ability.extra) or self.config.extra )).x_mult } } end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
                message = localize{type='variable', key='a_xmult', vars={card.ability.extra.x_mult}}
            }
        end
        if context.buy_joker and not context.blueprint then
            local suits = {"Hearts", "Spades", "Diamonds", "Clubs"}
            local target_suit = suits[pseudorandom('cataclysm') % 4 + 1]
            local cards_to_destroy = {}
            for i = 1, #G.playing_cards do
                if G.playing_cards[i].base.suit == target_suit then
                    table.insert(cards_to_destroy, G.playing_cards[i])
                end
            end
            for _, c in ipairs(cards_to_destroy) do
                c:start_dissolve()
            end
            return {
                message = "Cataclysm: " .. target_suit .. " destroyed!",
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
    end
})

