# Steamodded API Reference (v1.0.0+)

**Documento Oficial de Referência Técnica**
Este documento detalha todas as classes, métodos e capacidades do framework Steamodded (SMODS) para modding de Balatro.
*Baseado na análise do código fonte do repositório oficial.*

**REFERÊNCIA DE CÓDIGO VANILLA:**
A pasta `balatro_game/` na raiz do projeto contém o código-fonte original do jogo (Card.lua, Sprite.lua, etc).
**Use-apenas como leitura** para entender como o jogo funciona. Nunca edite arquivos nesta pasta.

---

## 1. Objetos Principais (Game Objects)

Todas as definições de objetos seguem o padrão `SMODS.Classe({ tabela_de_definição })`.

### 1.1. Jokers (`SMODS.Joker`)
Cria novos Jokers.
```lua
SMODS.Joker({
    key = 'joker_key',          -- ID único (será prefixado com mod_id_)
    loc_txt = {                 -- Texto de localização
        name = 'Nome',
        text = { 'Linha 1', 'Linha 2' }
    },
    config = { extra = {} },    -- Variáveis configuráveis
    rarity = 1,                 -- 1=Comum, 2=Incomum, 3=Raro, 4=Lendário
    cost = 4,                   -- Custo na loja
    pos = { x = 0, y = 0 },     -- Posição no Atlas
    atlas = 'atlas_key',        -- Chave do Atlas (opcional se usar padrão)
    blueprint_compat = true,    -- Compatível com Blueprint/Brainstorm
    eternal_compat = true,      -- Pode ser Eternal
    perishable_compat = true,   -- Pode ser Perishable
    unlocked = true,            -- Se começa desbloqueado
    discovered = true,          -- Se começa descoberto na coleção
    
    -- Métodos
    loc_vars = function(self, info_queue, card) ... end, -- Retorna variáveis para loc_txt
    calculate = function(self, card, context) ... end,   -- Lógica principal
    calc_dollar_bonus = function(self, card) ... end     -- Dinheiro ao fim da rodada
})
```

### 1.2. Consumíveis (`SMODS.Consumable`)
Cria Tarôs, Planetas e Espectrais.
```lua
SMODS.Consumable({
    set = 'Tarot',              -- 'Tarot', 'Planet', 'Spectral'
    key = 'key',
    loc_txt = { ... },
    config = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    cost = 3,
    unlocked = true,
    discovered = true,
    
    -- Métodos
    can_use = function(self, card) ... end, -- Retorna true se pode usar
    use = function(self, card, area, copier) ... end -- Efeito ao usar
})
```

### 1.3. Vouchers (`SMODS.Voucher`)
Cria Vouchers de loja.
```lua
SMODS.Voucher({
    key = 'key',
    loc_txt = { ... },
    config = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    cost = 10,
    unlocked = true,
    discovered = true,
    requires = {'v_pre_requisito'}, -- Chave do voucher anterior (para Tier 2)
    
    -- Métodos
    redeem = function(self) ... end -- Efeito ao comprar
})
```

### 1.4. Baralhos (`SMODS.Back`)
Cria Baralhos iniciais.
```lua
SMODS.Back({
    key = 'key',
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    config = { ... },           -- Configuração inicial (hand_size, discards, etc)
    
    -- Métodos
    apply = function(self) ... end, -- Executado ao iniciar a run
    trigger_effect = function(self, args) ... end -- Efeitos visuais/lógicos durante jogo
})
```

### 1.5. Blinds/Bosses (`SMODS.Blind`)
Cria Blinds e Boss Blinds.
```lua
SMODS.Blind({
    key = 'key',
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    dollars = 5,                -- Recompensa base
    mult = 2,                   -- Multiplicador de pontuação base
    boss = {                    -- Configuração de Boss
        min = 1,                -- Ante mínimo
        max = 10,               -- Ante máximo
        showdown = false        -- Se é Boss Final (Ante 8)
    },
    boss_colour = HEX('FF0000'), -- Cor do Boss
    
    -- Métodos
    in_pool = function(self) ... end, -- Condição para aparecer
    set_blind = function(self, reset, silent) ... end, -- Ao selecionar o Blind
    disable = function(self) ... end, -- Lógica de desabilitar Jokers/Cartas
    debuff_card = function(self, card, from_blind) ... end, -- Lógica de debuff por carta
    press_play = function(self) ... end, -- Ao jogar mão
    recalc_bonus = function(self, card, context) ... end -- Recálculo de pontuação
})
```

### 1.6. Tags (`SMODS.Tag`)
Cria Tags (recompensas de Skip).
```lua
SMODS.Tag({
    key = 'key',
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    min_ante = 1,
    
    -- Métodos
    apply = function(self, tag, context) ... end -- Efeito ao pegar/ativar
})
```

---

## 2. Modificadores de Cartas (Enhancements, Editions, Seals)

### 2.1. Aprimoramentos (`SMODS.Enhancement`)
Cria tipos de cartas como Aço, Vidro, Ouro.
```lua
SMODS.Enhancement({
    key = 'key',                -- Ex: 'wood' -> 'm_mod_wood'
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    config = { ... },
    
    -- Flags Opcionais
    replace_base_card = false,  -- Substitui arte base (como Pedra)
    no_rank = false,            -- Remove Rank (como Pedra)
    no_suit = false,            -- Remove Naipe (como Pedra)
    always_scores = false,      -- Pontua sempre (como Pedra)
    
    -- Métodos
    calculate = function(self, card, context, effect) ... end -- Lógica de pontuação/efeito
})
```

### 2.2. Edições (`SMODS.Edition`)
Cria efeitos visuais/stats como Foil, Holo, Polychrome.
```lua
SMODS.Edition({
    key = 'key',                -- Ex: 'glitch' -> 'e_mod_glitch'
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    config = { ... },
    shader = false,             -- Se usa shader especial
    
    -- Métodos
    calculate = function(self, card, context) ... end,
    get_weight = function(self) ... end -- Peso na geração aleatória
})
```

### 2.3. Selos (`SMODS.Seal`)
Cria selos como Red, Blue, Gold, Purple.
```lua
SMODS.Seal({
    key = 'key',
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    
    -- Métodos
    calculate = function(self, card, context) ... end
})
```

### 2.4. Adesivos (`SMODS.Sticker`)
Cria adesivos como Eternal, Perishable, Rental.
```lua
SMODS.Sticker({
    key = 'key',
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    
    -- Métodos
    calculate = function(self, card, context) ... end,
    should_apply = function(self, card, center, area) ... end
})
```

---

## 3. Customização Base (Naipes, Ranks, Sons, Shaders)

### 3.1. Naipes (`SMODS.Suit`)
Cria novos naipes.
```lua
SMODS.Suit({
    key = 'key',
    loc_txt = { ... },
    pos = { x = 0, y = 0 },     -- Posição no Atlas de Naipes
    ui_pos = { x = 0, y = 0 },  -- Posição no Atlas de UI
    atlas = 'atlas_key',
    card_key = 'C',             -- Letra identificadora (ex: 'S', 'H', 'D', 'C')
    suit_color = HEX('000000')  -- Cor base
})
```

### 3.2. Ranks (`SMODS.Rank`)
Cria novos ranks (além de 2-A).
```lua
SMODS.Rank({
    key = 'key',
    card_key = 'X',             -- Caractere identificador
    loc_txt = { ... },
    pos = { x = 0, y = 0 },
    atlas = 'atlas_key',
    shorthand = 'X',            -- Abreviação
    value = 15,                 -- Valor numérico
    face_nominal = 0.5,         -- Valor nominal (chips)
    next = {'next_rank_key'}    -- Próximo rank na sequência
})
```

### 3.3. Sons (`SMODS.Sound`)
Adiciona sons personalizados.
```lua
SMODS.Sound({
    key = 'key',
    path = 'sound_file.ogg'     -- Caminho relativo a assets/sounds/
})
-- Uso: play_sound('mod_prefix_key')
```

### 3.4. Shaders (`SMODS.Shader`)
Adiciona shaders GLSL.
```lua
SMODS.Shader({
    key = 'key',
    path = 'shader.fs'          -- Caminho relativo a assets/shaders/
})
```

### 3.5. Atlas (`SMODS.Atlas`)
Define folhas de sprites.
```lua
SMODS.Atlas({
    key = 'key',
    path = 'image.png',         -- Caminho relativo a assets/1x/ e assets/2x/
    px = 71,                    -- Largura do sprite
    py = 95                     -- Altura do sprite
})
```

---

## 4. Contextos de Cálculo (`context`)

Ao implementar `calculate(self, card, context)`, verifique as flags em `context`:

### Gatilhos de Jogo
*   `context.joker_main`: Cálculo principal de pontuação (Chips/Mult).
*   `context.before`: Antes da pontuação (ex: mudar naipe).
*   `context.after`: Após a pontuação (ex: ganhar dinheiro).
*   `context.end_of_round`: Fim da rodada (mão jogada ou descartada).
*   `context.individual`: Cálculo por carta pontuada.
*   `context.repetition`: Gatilho de retrigger.
*   `context.discard`: Ao descartar.
*   `context.other_joker`: Quando outro Joker ativa.
*   `context.buying_card`: Ao comprar carta na loja.
*   `context.selling_card`: Ao vender carta.
*   `context.skipping_booster`: Ao pular pacote.
*   `context.setting_blind`: Ao definir o Blind.
*   `context.first_hand_drawn`: Ao comprar primeira mão.
*   `context.destroying_card`: Ao destruir carta.
*   `context.using_consumable`: Ao usar consumível.

### Flags Úteis
*   `context.cardarea`: Área onde a carta está (`G.jokers`, `G.hand`, `G.play`).
*   `context.scoring_hand`: Tabela com cartas pontuando.
*   `context.poker_hands`: Tabela com mãos de poker formadas.
*   `context.blueprint`: Se ativado por Blueprint/Brainstorm.

---

## 5. Funções Globais Úteis

*   `SMODS.add_card(card)`: Adiciona carta a uma área segura.
*   `SMODS.create_card(params)`: Cria carta com parâmetros específicos.
*   `SMODS.poll_enhancement(key, mod, guaranteed, options)`: Sorteia aprimoramento.
*   `SMODS.poll_edition(key, mod, guaranteed, options)`: Sorteia edição.
*   `SMODS.poll_seal(key, mod, guaranteed, options)`: Sorteia selo.
*   `SMODS.change_base(card, suit, rank)`: Muda naipe/rank base.
*   `SMODS.eval_this(card, context)`: Força avaliação de efeito.
*   `pseudorandom(seed)`: Gera número aleatório determinístico.
*   `localize(key)`: Busca texto traduzido.

---

## 6. Desafios (`SMODS.Challenge`)

Cria modos de desafio.
```lua
SMODS.Challenge({
    key = 'key',
    loc_txt = { ... },
    rules = {
        custom = { ... },       -- Regras customizadas
        modifiers = { ... }     -- Modificadores de jogo
    },
    jokers = { ... },           -- Jokers iniciais
    deck = { ... },             -- Baralho inicial
    restrictions = { ... }      -- Cartas banidas
})
```

---

## 7. Integração Avançada: Shaders Customizados (CRÍTICO)

A implementação de shaders customizados em edições exige cuidados especiais devido a limitações do Love2D ao receber variáveis do Lua.

### O Problema do Crash "number expected, got table"
O Steamodded envia automaticamente os parâmetros da carta para o shader. Em Edições, ele envia a própria tabela `edition` como um dos parâmetros. O Love2D **não aceita tabelas** como argumentos de shader (`shader:send`), apenas `number`, `bool` ou `vec2/vec3/vec4`. Isso causa um crash imediato.

### Solução Obrigatória: Lovely Patch
Para usar shaders customizados em Edições, você DEVE injetar um código de limpeza (sanitization) no `engine/sprite.lua` usando Lovely.

**Exemplo de Patch (`lovely/crash_fix.toml`):**
```toml
[[patches]]
[patches.pattern]
target = "engine/sprite.lua"
pattern = "function Sprite:draw_shader(_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)"
position = "after"
match_indent = true
payload = "if _shader == 'seu_mod_shader_key' and _send and type(_send) == 'table' then local safe = {} for k,v in pairs(_send) do if type(v) == 'number' then safe[k] = v end end _send = safe end"
```
*Substitua `'seu_mod_shader_key'` pela chave exata do seu shader (com prefixo do mod).*

### Estrutura do Shader (.fs)
No arquivo GLSL, use `extern` para receber as variáveis. Se o Lua enviar números (`extern number`) ou vetores (`extern vec2`), declare de acordo.

**Código Lua:**
```lua
-- Na definição da edition ou enhancement
shader_val = 1.0  -- Exemplo simples
```

**Código Shader (.fs):**
```glsl
extern number your_mod_shader_key; // Recebe o valor de shader_val (ou o nome do shader se coincidir)

vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    // IMPORTANTE: Some TODAS as variáveis 'extern' num dummy para evitar que o compilador as remova
    float dummy = your_mod_shader_key + ...; 
    
    // Lógica do efeito...
    return Texel(texture, texture_coords) * color;
}
```
