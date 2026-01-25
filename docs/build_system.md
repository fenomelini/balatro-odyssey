# 📁 ESTRUTURA DO PROJETO - BALATRO ODYSSEY

## ✅ Build System Implementado!

O projeto agora usa uma **estrutura modular** para desenvolvimento, mas gera um **arquivo único** para distribuição (compatível com Steamodded).

---

## 📂 Estrutura de Diretórios

```
balatro-odyssey/
├── manifest.json                    # Configuração do mod
├── BalatroOdyssey.lua              # ← ARQUIVO FINAL (gerado por build.py)
├── BalatroOdyssey_original.lua     # Backup do arquivo original
├── assets/                          # Sprites dos Jokers
│   ├── 1x/jokers/                  # 71×95px (50 sprites)
│   └── 2x/jokers/                  # 142×190px (50 sprites)
├── src/                             # ← CÓDIGO FONTE MODULAR
│   ├── 00_header.lua               # Cabeçalho Steamodded
│   ├── 01_atlas.lua                # Configuração de 10 atlas
│   ├── 02_utils.lua                # Funções auxiliares
│   ├── jokers/                      # ← JOKERS ORGANIZADOS
│   │   ├── 01_solidao.lua          # Jokers 1-5 (231 linhas)
│   │   ├── 02_solidao_avancada.lua # Jokers 6-16 (496 linhas)
│   │   ├── 03_singularidade.lua    # Jokers 17-30 (530 linhas)
│   │   ├── 04_singularidade_extrema.lua # Jokers 31-40 (542 linhas)
│   │   └── 05_quantum_start.lua    # Jokers 41-50 (427 linhas)
│   └── 99_footer.lua               # Footer do mod
├── build.py                         # ← SCRIPT DE BUILD
├── extract_jokers.py                # Script de extração
├── extract_precise.py               # Script melhorado
├── generate_placeholders.py         # Gerador de sprites placeholder
└── docs/                            # Documentação
    ├── README.md
    ├── jokers_mechanics_reference.md
    ├── IMPLEMENTATION_PLAN.md
    ├── SPRITE_GUIDE.md
    ├── CODE_TEMPLATES.md
    ├── TESTING_GUIDE.md
    ├── ORGANIZATION_PROPOSAL.md
    └── JOKERS_1-50_SUMMARY.md
```

---

## 🔨 Como Usar o Build System

### 1. Editar Código

Edite apenas arquivos em `src/`:

```bash
# Editar Joker específico
nano src/jokers/01_solidao.lua

# Adicionar novos Jokers
nano src/jokers/06_cosmic_quantum.lua

# Modificar utils
nano src/02_utils.lua
```

### 2. Build

Gere o arquivo final:

```bash
python3 build.py
```

**Output:**
```
============================================================
🔨 BUILDING BALATRO ODYSSEY
============================================================

✓ 00_header.lua                            (   14 linhas)
✓ 01_atlas.lua                             (   84 linhas)
✓ 02_utils.lua                             (   69 linhas)
✓ jokers/01_solidao.lua                    (  231 linhas)
✓ jokers/02_solidao_avancada.lua           (  496 linhas)
✓ jokers/03_singularidade.lua              (  530 linhas)
✓ jokers/04_singularidade_extrema.lua      (  542 linhas)
✓ jokers/05_quantum_start.lua              (  427 linhas)
✓ 99_footer.lua                            (    4 linhas)

============================================================
✅ BUILD COMPLETO!
============================================================
📄 Arquivo: BalatroOdyssey.lua
📊 Arquivos processados: 9
📏 Total de linhas: 2,422
🃏 Total de Jokers: 50
💾 Tamanho: 71.7 KB
⏰ Build: 2025-12-31 02:01:17
============================================================

🔍 Validando código...
   SMODS.Joker({: 50
   }): 60
   Keys únicos: 63
   
✅ Validação passou!
```

### 3. Testar

Copie `BalatroOdyssey.lua` para pasta de mods e teste no jogo.

---

## 💡 Vantagens do Build System

### ✅ Para Desenvolvimento

| Antes | Depois |
|-------|--------|
| 1 arquivo de 50,000 linhas | 17 arquivos de 500-1000 linhas cada |
| Difícil navegar | Fácil encontrar qualquer Joker |
| Git diffs enormes | Commits limpos e específicos |
| 1 dev por vez | Múltiplos devs em paralelo |

### ✅ Para Distribuição

- ✅ **Compatível 100%** com Steamodded (arquivo único)
- ✅ **Mesmo resultado** que desenvolvimento manual
- ✅ **Validação automática** de sintaxe
- ✅ **Estatísticas** em tempo real

---

## 📝 Workflow Recomendado

### Adicionar Novos Jokers (51-100)

```bash
# 1. Criar novo arquivo
nano src/jokers/06_cosmic_quantum.lua

# 2. Adicionar código dos Jokers 51-100
# (usar templates de CODE_TEMPLATES.md)

# 3. Build
python3 build.py

# 4. Testar
# (copiar BalatroOdyssey.lua para mods/)

# 5. Commit apenas src/
git add src/jokers/06_cosmic_quantum.lua
git commit -m "Added Jokers 51-100: Cosmic Quantum"
```

### Modificar Joker Existente

```bash
# 1. Editar arquivo específico
nano src/jokers/01_solidao.lua

# 2. Rebuild
python3 build.py

# 3. Testar mudanças

# 4. Commit
git add src/jokers/01_solidao.lua
git commit -m "Fixed Solitário Joker calculation"
```

---

## 🎯 Plano para 1,000 Jokers

Com build system, implementar será muito mais fácil:

```
src/jokers/
├── 01_solidao.lua                    # ✅ FEITO (1-5)
├── 02_solidao_avancada.lua           # ✅ FEITO (6-16)
├── 03_singularidade.lua              # ✅ FEITO (17-30)
├── 04_singularidade_extrema.lua      # ✅ FEITO (31-40)
├── 05_quantum_start.lua              # ✅ FEITO (41-50)
├── 06_quantum_full.lua               # ⏳ PRÓXIMO (51-100)
├── 07_anti_pattern_basic.lua         # ⏳ (101-150)
├── 08_anti_pattern_advanced.lua      # ⏳ (151-200)
├── 09_synergy_basic.lua              # ⏳ (201-250)
├── 10_synergy_advanced.lua           # ⏳ (251-300)
├── 11_resource_revolution.lua        # ⏳ (301-400)
├── 12_temporal_paradox.lua           # ⏳ (401-500)
├── 13_suit_sovereignty.lua           # ⏳ (501-600)
├── 14_rank_royalty.lua               # ⏳ (601-700)
├── 15_wild_card.lua                  # ⏳ (701-800)
├── 16_meta_mechanics.lua             # ⏳ (801-900)
└── 17_ultimate_power.lua             # ⏳ (901-1000)
```

**Estimativa**: ~500-1000 linhas por arquivo = gerenciável!

---

## 🔧 Scripts Disponíveis

### build.py
- **Função**: Concatena src/ → BalatroOdyssey.lua
- **Uso**: `python3 build.py`
- **Features**:
  - Validação automática
  - Estatísticas detalhadas
  - Verificação de parênteses
  - Detecção de keys duplicadas

### extract_jokers.py
- **Função**: Extrai Jokers de arquivo monolítico para src/
- **Uso**: `python3 extract_jokers.py`
- **Útil para**: Reorganizar código existente

### generate_placeholders.py
- **Função**: Gera sprites placeholder
- **Uso**: `python3 generate_placeholders.py`
- **Output**: 100 sprites PNG (50×1x + 50×2x)

---

## 📊 Estatísticas Atuais

```
Progresso:     50/1,000 Jokers (5%)
Arquivos src:  9 arquivos
Linhas código: 2,422 linhas
Tamanho:       71.7 KB
Sprites:       100 placeholders
```

---

## 🚀 Próximos Passos

1. ✅ Build system implementado
2. ✅ Código modularizado (50 Jokers)
3. ⏳ Implementar Jokers 51-100 em novo arquivo
4. ⏳ Testar build system com 100 Jokers
5. ⏳ Refinar e documentar process

---

## ❓ FAQ

### P: Posso editar BalatroOdyssey.lua diretamente?
**R**: Não recomendado! Suas mudanças serão sobrescritas no próximo build. Edite sempre `src/`.

### P: Como adiciono um novo Joker?
**R**: Edite arquivo apropriado em `src/jokers/`, rode `python3 build.py`, teste.

### P: Preciso fazer build toda vez?
**R**: Sim, mas é rápido (~1 segundo). Adicione ao git pre-commit hook se quiser.

### P: E se eu estragar algo?
**R**: Arquivo `BalatroOdyssey_original.lua` é backup. Ou use git: `git checkout src/`

### P: Posso ter mais de 17 arquivos?
**R**: Sim! Adicione quantos quiser em `src/jokers/`. Build ordena alfabeticamente.

---

**Status**: ✅ Build System Operacional  
**Versão**: 0.05-modular  
**Última Atualização**: 2025-12-31

*"Write modular, ship monolithic."*
