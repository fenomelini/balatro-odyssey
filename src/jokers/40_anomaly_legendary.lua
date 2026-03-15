local jokers = {
    -- 399. The Watcher
    {
        key = 'j_anomaly_the_watcher',
        config = { extra = { x_mult = 3 } },
        rarity = 4,
        atlas = 'j_anomaly_the_watcher',
        cost = 20,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
            -- Reveal deck order: flip all deck cards face-up at round start (after shuffle)
            if context.setting_blind and G.GAME.modifiers.odyssey_reveal_deck then
                G.E_MANAGER:add_event(Event({func = function()
                    if G.deck then
                        for _, c in ipairs(G.deck.cards) do
                            if c.facing == 'back' then c:flip() end
                        end
                    end
                    return true
                end}))
            end
        end,
        add_to_deck = function(self, card, from_debuff)
            G.GAME.modifiers.odyssey_reveal_deck = true
            -- Immediately reveal current deck cards
            if G.deck then
                for _, c in ipairs(G.deck.cards) do
                    if c.facing == 'back' then c:flip() end
                end
            end
        end,
        remove_from_deck = function(self, card, from_debuff)
            -- Only hide deck if no other Watcher copy remains
            local has_other = false
            if G.jokers and G.jokers.cards then
                for _, j in ipairs(G.jokers.cards) do
                    if j.config and j.config.center
                        and j.config.center.key == 'j_odyssey_j_anomaly_the_watcher'
                        and j ~= card then
                        has_other = true
                        break
                    end
                end
            end
            if not has_other then
                G.GAME.modifiers.odyssey_reveal_deck = nil
                if G.deck then
                    for _, c in ipairs(G.deck.cards) do
                        if c.facing == 'front' then c:flip() end
                    end
                end
            end
        end

    },
    -- 400. Fatal Error
    {
        key = 'j_anomaly_fatal_error',
        config = { extra = { x_mult = 10, money = 100 } },
        rarity = 4,
        atlas = 'j_anomaly_fatal_error',
        cost = 20,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        loc_vars = function(self, info_queue, card)

            local extra = ( (card and card.ability and card.ability.extra) or self.config.extra )

            return { vars = { extra.x_mult, extra.money } }

        end,
        calculate = function(self, card, context)
            if context.joker_main then
                return {
                    message = localize{ type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    Xmult_mod = card.ability.extra.x_mult
                }
            end

            if context.end_of_round and not context.repetition and not context.other_card then
                if not context.blueprint then
                    local deletable_jokers = {}
                    for _, j in ipairs(G.jokers.cards) do
                        if not j.ability.eternal and j ~= card then
                            table.insert(deletable_jokers, j)
                        end
                    end
                    if #deletable_jokers > 0 then
                        local target = deletable_jokers[pseudorandom('fatal_error') % #deletable_jokers + 1]
                        target.getting_sliced = true
                        G.E_MANAGER:add_event(Event({func = function()
                            target:start_dissolve()
                        return true end }))
                    end
                end

                return {
                    dollars = card.ability.extra.money,
                    message = localize('$')..card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    }
}

for _, joker_def in ipairs(jokers) do
    joker_def.unlocked = true
    joker_def.discovered = false
    SMODS.Joker(joker_def)
end
