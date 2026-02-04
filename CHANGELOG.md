# Changelog

All notable changes to this project will be documented in this file.

## [0.1.3-alpha] - 2026-02-03

### Added
- **Marie Curie (Spectral 53)**: Implemented full deck randomization mechanic. Now randomizes the rank of all cards in your deck at the end of each round while preserving suits.
- **Developer Joker**: New functional mechanic - removes the lowest rank card from deck at end of round and creates a "Patch Card" (enhanced card with random Enhancement, Edition, and Seal).
- **Four Leaf Clover**: New probability mechanic - adds +1 to the numerator of all probabilities (e.g., 1/4 becomes 2/4).
- **Futurist Joker**: New mechanic - doubles all hand levels gained from Planet cards (replaces non-functional "preview boss" mechanic).
- **The Chaos (Tarot)**: Now randomizes both rank AND suit of all cards in hand (replaces cosmetic shuffle).
- **The War (Tarot)**: Added detailed money gain description ($2 per destroyed face card).
- **The Warrior (Tarot 80)**: Implemented targeted selection mechanic - adds +100 permanent chip bonus to up to 2 selected cards.
- Dynamic status indicator for Jekyll & Hyde showing current multiplier state in description.
- Expanded motivational message list for String Joker (added 10+ new phrases).
- **Costume Joker**: New transformation mechanic - converts the first played card into a random Enhanced Card each hand (replaces non-functional "art change" mechanic).

### Changed
- **Noxious Spores**: Corrected card type reference from non-existent "Stone" to "Emerald" cards (mod's equivalent).
- **Butterfly Effect**: Improved mechanic - now permanently converts all cards in hand to the suit of the first played card (replaces temporary visual-only effect).
- **Pawn Shop**: Implemented sell price override - all consumables now sell for $5 when this Joker is active.

### Fixed
- **Jekyll & Hyde**: Fixed description formatting (removed concatenated color tags, added proper spacing, added current state indicator).
- **End of Round Bug Prevention**: Added `not context.other_card` checks to prevent multiple activations in round-end events.
- **Wormhole Joker**: Fixed non-functional Small Blind skip. Now properly awards money and transitions to Big Blind.
- **Localization Improvements**: Standardized formatting codes across Portuguese and English descriptions.

### Technical
- Improved error handling in card generation functions across all pool types.
- Added vanilla override hooks for sell price modification (Pawn Shop) and hand level doubling (Futurist).
- Updated build system to version 0.1.3-alpha.

---

## [0.1.2-alpha] - 2026-01-27
### Added
- **Rogue Joker (Castling) Mechanic**: Implemented full protection logic. Now grants +20 Mult normally, but upgrades to X2 Mult when King Joker is present in the inventory.
- **Connector Joker Bridge Functionality**: Jokers that depend on neighbor positions now "skip" the Connector and interact with the next adjacent Joker, creating a "bridge" effect. Also provides +10 Mult as a secondary bonus.
- **Drake Spectral Oracle System**: Implemented victory guarantee display. When Drake is used, the game shows "VITÓRIA GARANTIDA" whenever the selected hand mathematically exceeds the current Blind's score requirement.

### Changed
- **Amplifier Joker**: Fully implemented the 50% effect boost mechanic. Now correctly identifies the Joker to the right and amplifies its Chips, Mult, or XMult effects by +50%.
- **NFT Joker**: Now properly unsellable. Receives the Eternal sticker automatically on acquisition and has sell value forced to $0.
- **Reroll Vouchers (Dados/D20)**: Fixed the cost reduction mechanic. Now correctly applies -$1 to the shop reroll cost immediately after redemption.
- **Plague Joker Probability Display**: Corrected the localization variable system to show accurate odds (e.g., "1 em 3" instead of "1 em 1").

### Fixed
- **Critical Crash: Polychrome Edition in Tags/HUD**: Resolved the game.lua:1272 crash that occurred when hovering over Tags or viewing editions without a physical card instance. Applied nil-safety checks across 100+ files.
- **Foil Deck "ERROR" Display**: Fixed naming conflict between "Foil Deck" and "Foil Edition". Renamed the deck's internal key to laminado to disambiguate from vanilla editions.
- **Foil Edition Display Bug**: Corrected the +table: 0x... visual glitch that appeared when Foil edition was applied to Jokers with complex internal data structures (like Metronome).
- **Tryhard Joker Crash**: Replaced deprecated G.shake reference with the correct G.ROOM.jiggle system call.
- **Total Conversion Filter Regression**: Vanilla Planets, Tarots, Spectrals, and Vouchers had reappeared in shops. Reapplied the complete filter to ensure only Odyssey content spawns (except exempted sets like Boosters, Backs, Tags, Stakes, and Editions).
- **Blind Icon Rendering**: Fixed missing/generic Blind sprites (like "O Gancho") by exempting the Blind set from the Total Conversion filter.
- **Privacy & Security**: Updated `.gitignore` to protect development documentation and AI instructions from being uploaded to public repositories.
- **Historical Data Cleanup**: Removed sensitive files from Git history and remote tags to ensure a clean public release.

### Localization
- **Magician Joker**: Replaced "Wild Cards" with "Cartas Coringa" in Portuguese localization.
- **Master of Space, Noclip, Beast Tamer**: Translated remaining "Wild Cards" references to "Cartas Coringa".
- **Rogue Joker Description**: Clarified the King protection mechanic in both PT-BR and EN-US.
- **Drake Spectral Description**: Improved formatting and added proper color tags for clarity.

### Technical
- **Lovely TOML Patches**: Updated regex patterns for edition safety and shop variety preservation.
- **Nil-Safety Overhaul**: Applied defensive programming across all Joker loc_vars and calculate functions to prevent crashes when card or card.ability is nil during UI rendering.
- **Build System**: Regenerated BalatroOdyssey.lua (42,769 lines) and BalatroOdyssey.zip with all corrections.

### Known Issues
- **Hand Limit Regex Patches**: Lovely patches for increasing hand limit from 5 to 10 cards are failing to match target code. Functionality works in-game, but warnings persist in logs. (Not fixed per user request - flagged for future investigation).

## [0.1.1-alpha] - 2026-01-25

### Fixed
- **Collection/Deck Info Crash**: Fixed a critical crash occurring when hovering over objects in the collection or deck view where the mod expected a card instance to exist. Applied safety guards to `loc_vars` in 86 files.
- **Tryhard Joker Fix**: Corrected a crash when `j_social_tryhard` triggered. Replaced the non-existent `G.shake` variable with `G.ROOM.jiggle`.
- Fixed crash in `blind.lua` when debuffing null cards.
- Fixed rendering crash in Boss Blinds when `boss_colour` was missing or invalid.
- Resolved card duplication bug in the Dimensional Deck.

### Added
- **Gauntlet Progression System**: 
  - Antes 1-8 now feature Vanilla Boss Blinds for a familiar start.
  - Antes 9-99 feature Balatro Odyssey's custom Boss Blinds.
  - Victory target updated to Ante 100 ("The Final Odyssey").
- Reintegrated vanilla Blinds and Tags into the "Your Collection" menu for a complete atlas experience.
- Implemented base `pt_BR` localization for core systems and initial Jokers.

### Changed
- Standardized project documentation and commit logs to English for international release.
- Removed deprecated `docs/build_system.md`.
- Refined internal number formatting (K, M, B) to handle the scale of Odyssey's high-stakes game.
- Default Hand Size increased to 10 to accommodate high-level strategic play.
- Updated `manifest.json` and internal header to version `0.1.1-alpha`.
