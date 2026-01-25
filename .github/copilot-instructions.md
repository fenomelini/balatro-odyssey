# Balatro Odyssey - AI Coding Agent Instructions

## Project Overview

**Balatro Odyssey** is a massive mod adding **1,000 unique Jokers** to the poker roguelike game Balatro. Built with Steamodded framework, this mod implements complex cosmic-themed mechanics organized into 17 thematic groups (Singularity, Quantum, Temporal, Dimensional, etc.).

## 📚 OFFICIAL DOCUMENTATION - ALWAYS CONSULT FIRST

**NEVER invent, deduce, or guess API behavior. ALWAYS consult official documentation:**

### 1. **Project Content Reference (PRIMARY SOURCE FOR MECHANICS)**
   - **Vanilla Game Source**: `balatro_game/` - Contains the decompiled/open source code of the base game (Card.lua, Sprite.lua, etc.).
     - **USAGE**: READ-ONLY. Use this to understand how the base game functions. NEVER edit files in this folder.
   - **Jokers**: `docs/jokers_reference.md` - Primary reference for all 1000 Jokers.
   - **Decks**: `docs/decks_reference.md` - Details for the 100 thematic decks.
   - **Vouchers**: `docs/vouchers_reference.md` - Details for the 200 vouchers (100 pairs).
   - **Enhancements**: `docs/enhancements_reference.md` - Details for the 17 card enhancements.
   - **Tarots**: `docs/tarots_reference.md` - Details for the 100 tarot cards.
   - **Planets**: `docs/planets_reference.md` - Details for the 100 planet cards and hand mappings.
   - **Spectrals**: `docs/spectrals_reference.md` - Details for the 100 spectral cards.
   - **Blinds**: `docs/blinds_reference.md` - Details for the 100 custom bosses and blinds.
   - **Tags**: `docs/tags_reference.md` - Details for the 50 custom tags.
   - **Steamodded API**: `docs/steamodded_mechanics_reference.md` - Documentation of Steamodded capabilities and API.
   - **RULE**: These modular files are the **SINGLE SOURCE OF TRUTH** for mod content. Before implementing ANY feature, you MUST consult the specific reference file to ensure the implementation matches the design exactly. Use these files to verify mechanics, costs, and rarities before making code changes.

### 2. **Steamodded GitHub (TECHNICAL REFERENCE)**
   - URL: https://github.com/Steamodded/smods
   - **Use for**: 
     - Atlas system implementation (`src/game_object.lua`)
     - SMODS.Joker structure (`src/game_object.lua`)
     - Real working code examples

## ⚠️ CRITICAL RULES - READ FIRST

### Rule #1: IF IT'S WORKING, DON'T TOUCH IT
- **NEVER** modify systems that are functioning correctly.
- **ALWAYS** verify actual problems exist before "fixing" them.
- **TEST** in-game before making large-scale changes.

### Rule #2: Understand Steamodded BEFORE Changing
- Steamodded automatically prefixes asset paths with mod name (e.g., `odyssey_`).
- Defining `atlas = 'j_joker_key'` + `path = 'j_joker_key.png'` → looks for `odyssey_j_joker_key.png`.
- **Jokers WITHOUT `atlas` field use default Steamodded sprite automatically**.
- Only define atlas for jokers that ACTUALLY HAVE custom sprites.

### Rule #3: Validate Before Mass Changes
- Don't "correct" hundreds of problems without verifying they're real problems.
- False positives in validators can create more damage than bugs.

### Rule #4: Cleanup Temporary Scripts
- Any script created and saved by the agent that is **NOT** part of the Mod structure (e.g., helper scripts, repair scripts, one-off transformers) **MUST** be deleted immediately after its purpose is fulfilled.
- Keep the workspace clean and free of unnecessary auxiliary files.

## Architecture & Critical Constraints

### Single-File Distribution Requirement
- **CRITICAL**: Steamodded mods MUST use a single `.lua` file for distribution.
- Development uses modular structure in `src/`, but `build_and_package.py` concatenates to `BalatroOdyssey.lua`.
- **NEVER** use `require()` or multiple module files in the final output.
- **NEVER** edit `BalatroOdyssey.lua` directly - edit source files in `src/` instead.

### Build System Workflow
```bash
# 1. Edit modular source files
nano src/jokers/01_singularity_common.lua

# 2. Run build script to generate single output file, package zip, and install to game folder
python3 build_and_package.py
```

### Directory Structure

```
src/                              # ← Edit these files
├── 00_header.lua                 # Mod metadata and initialization
├── 01_atlas.lua                  # Sprite atlas definitions
├── 02_utils.lua                  # Helper functions
├── 99_footer.lua                 # Mod closing
├── localization/
│   ├── en-us.lua                 # English localization (REQUIRED for code keys)
│   └── pt_BR.lua                 # Portuguese localization (REQUIRED for display)
└── jokers/                       # Joker implementations (organized by group & rarity)
    ├── 01_singularity_common.lua
    ├── 02_singularity_uncommon.lua
    ├── ...
    └── 56_economy_legendary.lua

BalatroOdyssey.lua                # ← Build output (DO NOT EDIT)
```

**Structure:**
- Files organized by **group** and **rarity**.
- File naming convention: `NN_groupname_rarity.lua` (e.g. `01_singularity_common.lua`).

## Joker Implementation Patterns

### Standard Joker Template
All jokers follow this SMODS.Joker structure:
```lua
SMODS.Joker({
    key = 'joker_key',           -- Internal identifier (lowercase, underscores, English)
    loc_txt = {
        name = 'Display Name',   -- Placeholder, actual text is in localization files
        text = { 'Description' } -- Placeholder
    },
    config = { extra = { mult = 50 } },
    rarity = 2,                   -- 1=Common, 2=Uncommon, 3=Rare, 4=Legendary
    atlas = 'j_joker_key',        -- Individual atlas per joker (if custom sprite exists)
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize{ type = 'variable', key = 'a_mult', vars = { 50 } },
                mult_mod = 50,
                colour = G.C.MULT
            }
        end
    end
})
```

### End of Round Multiple Activation Bug
- `context.end_of_round` is triggered **ONCE PER CARD IN HAND**, not just once per round.
- **ALWAYS add `not context.other_card`** to prevent multiple activations.

## Localization and Internationalization

### ⚠️ CRITICAL: Dual Language Support Required

**Every text displayed to the player MUST be localized in both Portuguese (pt_BR) and English (en-us).**

1. **Structure**:
   - `src/localization/pt_BR.lua`: Brazilian Portuguese translations.
   - `src/localization/en-us.lua`: US English translations.

2. **Implementation Rule**:
   - **NEVER** hardcode text in description or name fields.
   - **ALWAYS** use localization keys.
   - When modifying any text, **YOU MUST UPDATE BOTH FILES**.
   - **NO PORTUGUESE IN `en-us.lua`**.
   - **NO ENGLISH IN `pt_BR.lua`** (except variable placeholders).

**Workflow for Text Changes**:
   a. Update `src/localization/pt_BR.lua`.
   b. Update `src/localization/en-us.lua`.
   c. Use the key in the object definition.

### ⚠️ CRITICAL: Localization Technical Standards

To avoid the "ERROR" description bug or empty text boxes, follow these technical rules:

1. **Mandatory Technical Prefixes**:
   - Inside the localization tables (`Joker`, `Tarot`, etc.), keys **MUST** have a technical prefix **BEFORE** the mod prefix.
   - **Jokers**: `j_odyssey_...`
   - **Tarots/Planets/Spectrals**: `c_odyssey_...`
   - **Vouchers**: `v_odyssey_...`
   - **Decks/Backs**: `b_odyssey_...`
   - **Blinds**: `bl_odyssey_...`
   - **Hands**: `odyssey_...` (Hands usually don't need an extra prefix, but must be in the correct table).

2. **Table Hierarchy (SMODS Requirements)**:
   ```lua
   return {
       descriptions = {
           Joker = { ["j_odyssey_key"] = { name = "Name", text = { "Line 1", "Line 2" } } },
           Tarot = { ["c_odyssey_key"] = { name = "Name", text = { "Line 1" } } },
           Hand = { ["odyssey_key"] = { name = "Name", text = { "Description" } } }, -- Hover text
       },
       misc = {
           poker_hands = { ["odyssey_key"] = "Display Name" },
           poker_hand_descriptions = { ["odyssey_key"] = { "Description" } } -- Run info text
       }
   }
   ```

3. **Poker Hand Rules**:
   - Custom hands **MUST** be defined in three places:
     - `descriptions.Hand` for the tooltip when hovering.
     - `misc.poker_hands` for the name in the UI.
     - `misc.poker_hand_descriptions` for the "Run Info" screen.
   - Failure to populate all three results in "ERROR" strings.

4. **Syntax Preservation**:
   - Use `["key"] = { ... }` format for keys with special characters or to be safe.
   - Keys must be **LOWERCASE** and match the `key` field in the `SMODS` object definition.

### Official Game Glossary & Formatting (PT-BR Standards)
Use these translations and formatting codes to maintain consistency with the base game's official localization.

**Color & Style Codes:**
- `{C:chips}Fichas{}` -> Orange text for Chips.
- `{C:mult}Multi{}` -> Red text for Mult.
- `{X:mult,C:white} X#1# {} Multi` -> White text on Red background for XMult (Standard).
- `{C:attention}Texto{}` -> Yellow text for important terms (Hands, Joker, etc.).
- `{C:inactive}Texto{}` -> Grey text for secondary or current status information.
- `{C:green}Texto{}` -> Green text for probabilities or odds.
- `{C:money}$#1#{}` -> Yellow text for money/dollars.
- `{C:tarot}Tarô{}`, `{C:planet}Planeta{}`, `{C:spectral}Espectral{}` -> Specific colors for consumable types.
- `{C:hearts}Copas{}`, `{C:diamonds}Ouros{}`, `{C:spades}Espadas{}`, `{C:clubs}Paus{}` -> Suit colors.

| English (Code/Tech) | Portuguese (In-Game PT-BR) | Notes |
|---------------------|---------------------------|-------|
| **Joker**           | Curinga                   | Official term. ("Joker" is also common in mods). |
| **Chips**           | Fichas                    | Formatting: `{C:chips}` |
| **Mult**            | Multi                     | Formatting: `{C:mult}` |
| **Blind**           | Blind                     | Kept in English (Big Blind, Small Blind). NOT "Cega". |
| **Ante**            | Aposta                    | |
| **Round**           | Rodada                    | |
| **Hand**            | Mão                       | |
| **Discard**         | Descarte                  | |
| **Deck**            | Baralho                   | |
| **Suit**            | Naipe                     | |
| **Rank**            | Classe                    | (e.g. "Todas as Classes"). |
| **Face Card**       | Carta de Realeza          | Do NOT use "Figura". |
| **Enhanced**        | Aprimorada                | |
| **Seal**            | Selo                      | |
| **Sticker**         | Adesivo                   | |
| **Voucher**         | Cupom                     | Official PT-BR term is "Cupom". |
| **Tarot**           | Tarô                      | Formatting: `{C:tarot}` |
| **Shop**            | Loja                      | |

**Formatting Rules:**
1. **Highlighting**: ALWAYS use `{C:attention}` for game mechanics terms (like "Mão de pôquer", "Baralho", "Nível").
2. **Numbers**: Use `{C:attention}#1#{}` for numeric variables that aren't Chips, Mult, or Money.
3. **Current Status**: Information about the current state of a scaling card (e.g., "(No momento, {C:mult}+10{C:inactive} Multi)") MUST use `{C:inactive}` for the parenthetical text.
4. **X-Mult Layout**: Standard XMult formatting is `{X:mult,C:white} X#1# {} Multi`. Note the spaces inside the braces.
5. **Chance/Green**: Use `{C:green}#1# em #2#{}` for probability descriptions.

## Sprite System

### 🛠️ COMMON PITFALLS & TECHNICAL STANDARDS (STABILITY)

#### 1. Framework & Data Safety
- **Nil Config Checks**: ALWAYS check if `card.ability.extra` or `self.config.extra` exists before access. Steamodded may not initialize these instantly during state transitions. Use `(card.ability.extra or {})`.
- **Rank Identification**: The rank "10" is internally mapped to `'T'`. Use `'T'` (e.g., `S_T`) instead of `'10'` in any code referring to card IDs or ranks.

#### 2. Lovely TOML Syntax (CRITICAL - Lovely 0.8.0)
- **Single File Requirement**: ALWAYS use a single `lovely.toml` in the root of the mod. DO NOT use a `lovely/` folder or fragmented files, as Lovely 0.8.0 crashes with "more than 1 element" or "missing field patches" depending on the configuration.
- **Manifest & Patches Rule**: If the file contains a `[manifest]` block, it **MUST** contain the `[[patches]]` array in the SAME file.
- **Sub-table Formatting**: Use the `[[patches]]` header followed by `[patches.pattern]` or `[patches.copy]` for clarity and stability in Lovely 0.8.0.
- **Regex Formatting**: Use **double quotes** (`"..."`) for regex strings to support backslashes. Escape backslashes twice (`\\s`, `\\d`). Single quotes (`'...'`) treat content as literals and will fail if they contain escape sequences.
- **Match Indent**: Always set `match_indent = true` for pattern patches to ensure cross-platform compatibility.
- **Working Template**:
  ```toml
  [manifest]
  version = "1.0.0"
  priority = 0

  [[patches]]
  [patches.pattern]
  target = "game.lua"
  pattern = "{card_limit = 5, type = 'play'})"
  position = "at"
  payload = "{card_limit = 10, type = 'play'})"
  match_indent = true
  ```

#### 3. Localization & UI Rendering
- **Closing Style Tags**: EVERY style tag (e.g., `{C:mult}`, `{X:mult}`) MUST be closed with `{}` immediately after the term. Unclosed tags crash UI formatting and remove all subsequent spaces in the description.
- **Decimal Support**: Use the modded `number_format` (in `src/04_ui_overrides.lua`) for any multiplier or chip value that requires decimal precision below 1,000.

#### 4. Total Conversion & Shop Filtering
- **Pool Management**: Content replacement is handled globally via filter in `game.lua`. 
- **CRITICAL: Shop Variety**: When omitting vanilla items (Total Conversion), ALWAYS exempt specific sets to prevent shop stagnancy (where only 2 Buffoon packs appear) and UI crashes in boosters.
- **Exempt Sets**: `Booster`, `Back`, `Tag`, `Stake`, and `Edition` MUST REMAIN in the pool.
- **Example Filter Pattern**:
  ```lua
  if not string.find(k, "odyssey") then
      local exempt_sets = {Booster = true, Back = true, Tag = true, Stake = true, Edition = true}
      if v.set and not exempt_sets[v.set] then
          v.omit = true
      end
  end
  ```
- **Legacy Enhancements**: DO NOT use vanilla keys like `m_stone`, `m_steel`, or `m_gold`. Use the mod's equivalents: `m_odyssey_emerald` (Stone), `m_odyssey_platinum` (Steel), and `m_odyssey_plastic` (Gold functionality).

### ⚠️ CRITICAL: Atlas System Rules

**How Steamodded Atlas System Works:**

1. **Mod Prefix Behavior:**
   - Steamodded adds `modname_` prefix ONLY to the **atlas key**, NOT to the file path.
   - If your mod is called "BalatroOdyssey", the prefix is `odyssey_`.
   
2. **Atlas Definition:**
   ```lua
   SMODS.Atlas({
       key = 'j_key',                    -- Becomes 'odyssey_j_key' internally
       path = 'odyssey_j_key.png',       -- Must match EXACT filename in assets/1x/
       px = 71, py = 95
   })
   ```

3. **Joker Atlas Reference:**
   ```lua
   SMODS.Joker({ . . . atlas = 'j_key' . . . }) -- References 'j_key', NOT 'odyssey_j_key'
   ```

### Sprite Processing Workflow
When adding new sprites, place raw images (any size) in `assets/raw/jokers/` and run:
`python3 process_new_sprites.py`
This script handles resizing, corner rounding, and naming conventions.

## Project-Specific Conventions

### Language Standards

**Portuguese (Brazil)** - Used ONLY for:
- ✅ User-facing game text (`loc_txt` content).
- ✅ Documentation files.

**English** - Used for ALL technical elements:
- ✅ Code (all Lua code, variables, functions).
- ✅ Keys (joker keys, atlas keys).
- ✅ File names.
- ✅ Comments in code.

**NEVER mix languages** in the same context.

### Compatibility Flags
- `blueprint_compat = true` - Can be copied by Blueprint joker.
- `eternal_compat = true` - Can have Eternal sticker.
- `perishable_compat = false` - Don't use on permanent scaling jokers.
