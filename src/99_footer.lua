----------------------------------------------
------------MOD CODE END----------------------
----------------------------------------------

-- Executar overrides de vanilla
if BalatroOdyssey.disable_vanilla_content then
    BalatroOdyssey.disable_vanilla_content()
end
if BalatroOdyssey.disable_vanilla_decks then
    BalatroOdyssey.disable_vanilla_decks()
end

-- Revelar todo o conteúdo do Odyssey no menu Coleções
BalatroOdyssey.reveal_all_content()

--------------------------------------------------------------------------------
-- PONTUAÇÃO E LIMITES (EXPAND PLAY LIMIT)
--------------------------------------------------------------------------------
-- Permitir jogar até 10 cartas para as mãos especiais do Odyssey

G.FUNCS.can_play = function(e)
    if not G.hand or not G.hand.highlighted or #G.hand.highlighted <= 0 or (G.GAME and G.GAME.blind and G.GAME.blind.block_play) or #G.hand.highlighted > 10 then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.BLUE
        e.config.button = 'play_cards_from_highlighted'
    end
end

-- Hook para garantir limites (Reforço dinâmico em cada frame)
local old_game_update = Game.update
function Game:update(dt)
    old_game_update(self, dt)
    
    -- Safety checks para evitar crash se o jogo não estiver totalmente carregado
    if G.play and G.play.config then
        G.play.config.card_limit = 10
    end
    
    if G.hand and G.hand.config then
        -- Balatro usa ambos os nomes dependendo do contexto
        G.hand.config.highlighted_limit = 10
        G.hand.config.highlight_limit = 10
    end
end

-- Garantir limites no início ou carregamento de uma run
local game_start_run_ref = Game.start_run
function Game:start_run(args)
    local ret = game_start_run_ref(self, args)
    if G.play then G.play.config.card_limit = 10 end
    if G.hand then 
        G.hand.config.highlighted_limit = 10
        G.hand.config.highlight_limit = 10
    end
    return ret
end

local game_load_run_ref = Game.load_run
function Game:load_run(args)
    local ret = game_load_run_ref(self, args)
    if G.play then G.play.config.card_limit = 10 end
    if G.hand then 
        G.hand.config.highlighted_limit = 10
        G.hand.config.highlight_limit = 10
    end
    return ret
end
