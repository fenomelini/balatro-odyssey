# 🎨 GUIA DE SPRITES - BALATRO ODYSSEY

## 📏 Especificações

### Tamanhos
- **1x:** 71x95 pixels (resolução padrão)
- **2x:** 142x190 pixels (alta resolução)

### Formato
- **PNG** com transparência

## 🗂️ Organização de Arquivos

### Estrutura Atual
```
assets/
├── raw/
│   └── jokers/
│       ├── 1.png                        # Sprite bruto - Joker #1 (Solitário)
│       ├── 2.png                        # Sprite bruto - Joker #2 (Isolado)
│       ├── 3.png                        # Sprite bruto - Joker #3 (Eremita)
│       └── ... (até 1000.png)
├── 1x/
│   ├── odyssey_j_solitary.png           # Joker #1 (processado)
│   ├── odyssey_j_isolated.png           # Joker #2 (processado)
│   ├── odyssey_j_hermit.png             # Joker #3 (processado)
│   ├── odyssey_j_purist.png             # Joker #4 (processado)
│   └── ... (996 mais arquivos)
└── 2x/
    ├── odyssey_j_solitary.png           # Joker #1 (alta resolução)
    ├── odyssey_j_isolated.png           # Joker #2 (alta resolução)
    └── ... (996 mais arquivos)

src/
└── 01_atlas.lua                         # Todas as definições de atlas
```

### Nomenclatura de Arquivos

**Imagens Brutas (assets/raw/jokers/):**
- **Padrão:** `[numero].png` onde número = posição no jokers_mechanics_reference.md
- **Exemplos:** `1.png`, `2.png`, `50.png`, `1000.png`
- **Tamanho:** Qualquer (será redimensionado pelo script)
- **Formato:** PNG com transparência
- **Importante:** O número corresponde EXATAMENTE ao número do joker no documento

**Sprites Processados (assets/1x/ e assets/2x/):**
- **Padrão:** `[joker_key].png`
- **SEM prefixo odyssey_** - Steamodded constrói o path automaticamente
- **Key do joker:** Minúsculas, underscores, sem acentos
- **Extensão:** `.png`

### Exemplos de Nomenclatura Completa
```
# jokers_mechanics_reference.md | Joker PT            | Key EN          | Raw          | Processado (1x & 2x)
-----------------------------|---------------------|-----------------|--------------|----------------------
1                            | Solitário           | solitary        | 1.png        | solitary.png
2                            | Isolado             | isolated        | 2.png        | isolated.png
12                           | Exército de 1 Homem | one_man_army    | 12.png       | one_man_army.png
31                           | Buraco Negro        | black_hole      | 31.png       | black_hole.png
48                           | Schrödinger         | schrodinger     | 48.png       | schrodinger.png
150                          | Distorção Temporal  | temporal_warp   | 150.png      | temporal_warp.png
1000                         | Lei Zero            | zeroth_law      | 1000.png     | zeroth_law.png
```

**Mapeamento Número → Key:**
O script `process_joker_sprites.py` contém um array com todas as 1000 keys na ordem correta do documento jokers_mechanics_reference.md.

### ⚠️ Regras Importantes
1. **NÃO usar prefixo** `odyssey_` nos arquivos - Steamodded adiciona automaticamente no path
2. **NUNCA** usar espaços (substitua por `_`)
3. **NUNCA** usar acentos (ã→a, é→e, ç→c)
4. **SEMPRE** minúsculas apenas
5. **SEMPRE** criar versões 1x E 2x do sprite

## 🎨 Sistema de Atlas

### ✅ Configuração Atual (Atlas Individual)
O projeto usa **1 atlas por joker** (não grids):

```lua
-- Exemplo: Joker #1
SMODS.Atlas({ 
    key = 'j_solitary',                    -- Chave do atlas
    path = 'odyssey_j_solitary.png',       -- Arquivo individual
    px = 71,                                -- Largura
    py = 95                                 -- Altura
})

-- No código do Joker:
SMODS.Joker({
    key = 'solitary',
    atlas = 'j_solitary',                  -- Referencia o atlas acima
    pos = { x = 0, y = 0 },                -- Sempre (0,0) em atlas individual
    ...
})
```

### Estrutura de Atlas Individual

**Para cada joker:**
1. **1 arquivo PNG** em `assets/1x/odyssey_j_joker_key.png` (71×95px)
2. **1 arquivo PNG** em `assets/2x/odyssey_j_joker_key.png` (142×190px)
3. **1 definição de atlas** em `src/01_atlas.lua`
4. **Posição sempre (0,0)** pois cada sprite ocupa o atlas inteiro

### Vantagens desta Abordagem
- ✅ Sprites independentes (fácil adicionar/remover)
- ✅ Sem necessidade de recalcular posições de grid
- ✅ Fácil manutenção e atualização
- ✅ Compatível com Steamodded
- ✅ Performance adequada (Steamodded carrega sob demanda)

### Convenção de Nomenclatura

**Atlas key:**
```lua
key = 'j_joker_key'  -- Sempre prefixado com j_
```

**Arquivo PNG:**
```
joker_key.png  -- SEM prefixo! Steamodded constrói o path automaticamente
```

**Joker key:**
```lua
key = 'joker_key'  -- Sem prefixo j_
```

**IMPORTANTE - Como o Path é Construído:**
```lua
-- Definição do atlas:
SMODS.Atlas({ key = 'j_solitary', path = 'solitary.png', px = 71, py = 95 })

-- Steamodded constrói automaticamente:
-- ModPath + assets/1x/ + solitary.png
-- Resultado: /path/to/mod/assets/1x/solitary.png
```

### Exemplos Reais
```lua
-- Joker #1: Solitário
SMODS.Atlas({ key = 'j_solitary', path = 'solitary.png', px = 71, py = 95 })
SMODS.Joker({ key = 'solitary', atlas = 'j_solitary', pos = { x = 0, y = 0 } })

-- Joker #40: Reverse Big Bang
SMODS.Atlas({ key = 'j_reverse_big_bang', path = 'reverse_big_bang.png', px = 71, py = 95 })
SMODS.Joker({ key = 'reverse_big_bang', atlas = 'j_reverse_big_bang', pos = { x = 0, y = 0 } })

-- Joker #150: (exemplo futuro)
SMODS.Atlas({ key = 'j_dimensional_rift', path = 'dimensional_rift.png', px = 71, py = 95 })
SMODS.Joker({ key = 'dimensional_rift', atlas = 'j_dimensional_rift', pos = { x = 0, y = 0 } })
```

### Script de Processamento Atualizado

**Processar sprites brutos (assets/raw/jokers/) para 1x e 2x:**
```python
#!/usr/bin/env python3
"""
process_joker_sprites.py
Processa sprites brutos numerados para formato final do mod
"""
from PIL import Image
import os
import re
import glob

# Diretórios
raw_dir = "assets/raw/jokers"
output_1x = "assets/1x"
output_2x = "assets/2x"
src_jokers_dir = "src/jokers"

def extract_joker_keys():
    """Extrai keys dos jokers do código fonte na ordem correta"""
    keys = []
    
    # Ler todos os arquivos de jokers em ordem
    joker_files = sorted(glob.glob(f"{src_jokers_dir}/*.lua"))
    
    for filepath in joker_files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Extrair keys (formato: key = 'joker_name',)
        pattern = r"key\s*=\s*'([^']+)',"
        matches = re.findall(pattern, content)
        
        # Filtrar keys de jokers (ignorar outras keys como 'message')
        for match in matches:
            if match not in ['message', 'a_mult', 'a_chips'] and match not in keys:
                keys.append(match)
    
    return keys

def process_sprites():
    """Processa todos os sprites numerados"""
    
    # Extrair keys do código
    joker_keys = extract_joker_keys()
    print(f"📚 Encontradas {len(joker_keys)} keys no código\n")
    
    # Criar diretórios de saída se não existirem
    os.makedirs(output_1x, exist_ok=True)
    os.makedirs(output_2x, exist_ok=True)
    
    processed = 0
    missing = 0
    
    for i, key in enumerate(joker_keys, 1):
        input_path = f"{raw_dir}/{i}.png"
        
        if not os.path.exists(input_path):
            print(f"⚠️  Faltando: {input_path} (Joker #{i}: {key})")
            missing += 1
            continue
        
        try:
            img = Image.open(input_path).convert('RGBA')
            
            # Gerar 1x (71x95)
            img_1x = img.resize((71, 95), Image.LANCZOS)
            output_1x_path = f"{output_1x}/odyssey_j_{key}.png"
            img_1x.save(output_1x_path, 'PNG', optimize=True)
            
            # Gerar 2x (142x190)
            img_2x = img.resize((142, 190), Image.LANCZOS)
            output_2x_path = f"{output_2x}/odyssey_j_{key}.png"
            img_2x.save(output_2x_path, 'PNG', optimize=True)
            
            processed += 1
            print(f"✓ {i:3d}. {key:30s} → {output_1x_path}")
            
        except Exception as e:
            print(f"❌ Erro processando {input_path}: {e}")
    
    print(f"\n📊 Resumo:")
    print(f"  ✅ Processados: {processed}")
    print(f"  ⚠️  Faltando:    {missing}")
    print(f"  📝 Total keys:  {len(joker_keys)}")

if __name__ == '__main__':
    print("🔧 Processando sprites do Balatro Odyssey...\n")
    process_sprites()
```

**Uso:**
```bash
cd /home/nomelini/mods/balatro/balatro-odyssey
python3 process_joker_sprites.py
```

**O script:**
- ✅ Extrai keys AUTOMATICAMENTE do código em `src/jokers/*.lua`
- ✅ Mantém a ordem correta dos jokers (por arquivo e posição)
- ✅ Mapeia `raw/jokers/1.png` → `odyssey_j_solitary.png`
- ✅ Gera versões 1x e 2x
- ✅ Reporta sprites faltantes
- ✅ Estatísticas ao final

## 📝 Checklist por Joker

### Implementação Completa
- [ ] Design conceitual definido
- [ ] Sprite bruto criado (qualquer tamanho)
- [ ] Sprite 1x (71x95px) processado
- [ ] Sprite 2x (142x190px) processado
- [ ] Arquivos salvos em `assets/1x/` e `assets/2x/`
- [ ] Atlas definido em `src/01_atlas.lua`
- [ ] Código Lua do joker implementado
- [ ] Build executado (`python3 build.py`)
- [ ] Mod empacotado
- [ ] Testado in-game

### Template de Atlas
```lua
-- Adicionar em src/01_atlas.lua (gerado automaticamente por build)
SMODS.Atlas({ 
    key = 'j_[joker_key]', 
    path = '[joker_key].png',  -- SEM prefixo odyssey_!
    px = 71, 
    py = 95 
})
```

### Template de Joker
```lua
-- Adicionar no arquivo apropriado em src/jokers/
SMODS.Joker({
    key = '[joker_key]',
    loc_txt = {
        name = '[Nome em Português]',
        text = {
            '[Linha 1 da descrição]',
            '[Linha 2 da descrição]'
        }
    },
    config = { extra = { mult = 50 } },  -- Valores configuráveis
    rarity = 1,  -- 1=Common, 2=Uncommon, 3=Rare, 4=Legendary
    atlas = 'j_[joker_key]',
    pos = { x = 0, y = 0 },  -- Sempre (0,0) em atlas individual
    cost = 4,  -- Preço na loja (4-10)
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        -- Para usar #1#, #2#, etc. na descrição
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize{ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                colour = G.C.MULT
            }
        end
    end
})
```

**Campos importantes:**
- `unlocked = true` - Joker disponível desde o início
- `discovered = true` - Aparece no compêndio
- `blueprint_compat` - Pode ser copiado pelo Blueprint
- `eternal_compat` - Pode ter sticker Eternal
- `perishable_compat` - Pode ter sticker Perishable (false para jokers de crescimento permanente)

## 🚀 Workflow de Produção

### Workflow Completo (Joker Individual)

#### Etapa 1: Design e Preparação
1. Ler mecânica do [jokers_mechanics_reference.md](jokers_mechanics_reference.md)
2. Definir key do joker (inglês, lowercase, underscores)
3. Esboçar conceito visual
4. Definir paleta de cores por tema

#### Etapa 2: Criação de Arte
1. **Criar sprite bruto** (qualquer tamanho, PNG com transparência)
2. **Salvar em** `assets/raw/jokers/[numero].png` onde:
   - `[numero]` = posição do joker no jokers_mechanics_reference.md
   - Exemplo: Joker #1 (Solitário) → `1.png`
   - Exemplo: Joker #50 (Observador) → `50.png`
   - Exemplo: Joker #1000 (Lei Zero) → `1000.png`
3. **Executar script de processamento:**
   ```bash
   python3 process_joker_sprites.py
   ```
   - Script lê `assets/raw/jokers/1.png`, `2.png`, etc.
   - Mapeia número → joker key (extrai do código fonte automaticamente)
   - Gera `assets/1x/[key].png` (71×95px)
   - Gera `assets/2x/[key].png` (142×190px)
4. **Verificar saída** em `assets/1x/` e `assets/2x/`

#### Etapa 3: Integração no Código
1. **Adicionar atlas** em `src/01_atlas.lua`:
   ```lua
   SMODS.Atlas({ key = 'j_joker_key', path = 'joker_key.png', px = 71, py = 95 })
   ```

2. **Implementar joker** no arquivo apropriado em `src/jokers/`:
   ```lua
   SMODS.Joker({
       key = 'joker_key',
       atlas = 'j_joker_key',
       pos = { x = 0, y = 0 },
       -- ... resto do código
   })
   ```

3. **Build e empacotamento**:
   ```bash
   python3 build_and_package.py
   ```

   O script automaticamente:
   - Concatena todos os arquivos Lua
   - Copia sprites para zip/BalatroOdyssey/assets/
   - Cria o arquivo ZIP final

---

**Nota:** Sprites placeholder podem ser usados inicialmente para testar mecânicas. Substitua por arte final depois.
