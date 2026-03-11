# Changelog

All notable changes to this project will be documented in this file.

## [0.1.6-alpha] - 2026-03-11

### Fixed
- **Shop Slot Expansion — Completely Non-Functional**: The `shop_extra_joker_slots` tracking variable was written by multiple systems but never read anywhere in the codebase. As a result, no shop slot expansion ever took effect. Fixed by replacing all usages with direct calls to `change_shop_size(N)`, the correct game API that actually resizes the shop UI and populates new slots. Affected: Baralho Vácuo deck (`apply`) and 10 vouchers: `Cloning`, `Replicator`, `Library`, `Archives`, `Deep Space Obs`, `Planetarium`, `Laboratory`, `Research Center`, `Card`, and `Deck`.
- **Matter & Energy Tarots — Floating Cards in Shop**: Using Tarots 30 (Matter) and 31 (Energy) from the shop caused newly created Emerald/Plastic cards to appear floating in front of the shop UI. These tarots call `G.hand:emplace()` to add cards directly into the hand area, which requires the hand to be visible on screen. Fixed by restricting their use to the three valid play states (`SELECTING_HAND`, `HAND_PLAYED`, `DRAW_TO_HAND`) where the hand area is rendered and `emplace` positions correctly.

## [0.1.5-alpha] - 2026-03-10

### Added
- **Tarot Flip Animations**: Tarots now play a satisfying card-flip animation when used.
- **Zuckerberg (Spectral 72) — Full Implementation**: Using this spectral card now permanently activates a "Social Network" effect. Each Joker gains **+3 Mult** for every active Joker directly adjacent to it.
- **Deflation Joker — Shop Price Reduction**: The shop discount mechanic now actually works. Every round you hold this Joker, all shop prices drop by $1 (minimum $1 per item), accumulating over time.
- **Gnome Deck — New Mechanic**: Replaced an unachievable concept with a real and thematic one. The deck now starts every run with **+3 hand size** and **+1 Joker slot**.
- **Einstein (Spectral 41) — Full Implementation**: Using this spectral now actually converts chips to Mult for the next hand played. The total chips of all scoring cards are added as flat +Mult (one-time effect, consumed after the hand).
- **Pasteur (Spectral 56) — Debuff Immunity**: Using Pasteur now correctly marks cards as **permanently immune to debuffs**. Previously, the immunity flag was set but never enforced — debuffs still applied normally.
- **Rank Shift Joker — Full Implementation**: The joker was setting a flag but never doing anything with it. The chip swap mechanic now works correctly: **Aces score 2 chips** and **2s score 11 chips** while this Joker is held.

### Changed
- **Wig Joker**: Redesigned from a broken "Kings count as Queens" concept to a working mechanic: grants **+5 Mult for each King scored** in the current hand.
- **The Mind Tarot**: Redesigned from the pointless "sort deck by rank" effect to something impactful: gives every card currently in your hand a **permanent +10 Chips bonus**.
- **The Time Tarot**: The **+1 Hand** bonus is now permanent, applying to all future rounds — not just the current blind.
- **The Creator Deck**: Description updated from the vague "Creative Mode" to accurately explain the mechanic: starts the run with the Legendary Joker **The Creator**.
- **Relativity Joker**: Description now clearly shows the speed threshold and rewards — playing fast (under 5s) gives **+100 Chips**; playing slow (over 5s) gives **X1.5 Mult**.
- **Luck Manipulator Joker**: Description corrected to match the actual effect: **doubles all luck probabilities** (e.g., a 1-in-4 chance becomes 2-in-4). The old description "1 in X → 1 in X-1" was wrong.
- **Zuckerberg (Spectral 72) — Description**: Updated to clearly state **+3 Mult per adjacent active Joker**, replacing the vague original wording.
- **Seasons Joker — Description**: Description was vague ("changes bonus suit each round"). Now clearly states the actual bonus: **+20 Chips and +5 Mult** for all cards of the current suit, and which suit is currently active.
- **Einstein (Spectral 41) — Description**: Fixed typos in both PT and EN descriptions.

### Fixed
- **Nebula Deck**: The deck was marking the Telescope voucher as "used" but never actually applying its effect (doubled Planet card rate in packs). Fixed: the effect is now correctly applied at the start of every run.
- **Gravitational Deck**: The "first card played triggers twice" mechanic was not working. The deck was comparing against the wrong card position, which could be a non-scoring kicker card. Fixed: now correctly targets the **first scoring card** in the played hand.
- **Event Horizon Deck**: The permanent +0.5 Mult gained from destroying cards was accumulating correctly but **never appearing in the score** — there was no code to actually apply it. Fixed: the accumulated Mult is now applied to every hand scored.
- **Quasar Deck**: Three bugs fixed: (1) An erroneous "skip the first Small Blind" behaviour that was never part of the deck's design was removed. (2) The **+20 Base Mult** was never visible in the scoreboard because it was tied to Joker quantity. Fixed: the +20 Mult is now added permanently to all hand types at run start. (3) The "no interest" flag is now correctly applied.
- **Supernova Deck**: Three bugs fixed: (1) Description formatting — the red background style was covering the entire phrase instead of just "X3" due to a misplaced closing tag. Fixed. (2) XMult was starting at X4 on the first trigger instead of X3 due to an off-by-one error. Fixed. (3) The accumulated XMult was never applied to scoring — a missing code block. Fixed.
- **Rage Quit Joker**: The save mechanic was completely non-functional — it set a flag that was never read. It now correctly triggers when you **fail a blind**, resets your money to $0, and saves you from losing the run (once per run).
- **The Mind Tarot — Usability**: The tarot could be activated with no cards in hand, doing nothing. It now correctly requires at least **1 card in hand** before it can be used.
- **Deflation Joker — English Description**: Fixed a "Chips Chips" word duplication typo and corrected the color formatting of the money value.
- **Paper Enhancement — Portuguese Description**: Fixed a typo — "quebrar" (break) corrected to "rasgar" (tear).

## [0.1.4-alpha] - 2026-02-21

### Added
- **Total Conversion Toggle**: Added a new setting in the mod's configuration menu that allows players to choose whether to hide or show vanilla content (Jokers, Tarots, Planets, etc.). This requires a game restart to take effect.

### Fixed
- **Webb & Hubble (Spectrals)**: Corrected logic for negative card transformation and hand size bonuses.
- **Negative Cards UI**: Fixed hand size display in localization (changed "+nil" to "+1").
- **Collection Menu**: Disabled the auto-reveal of all cards to restore standard progression.
- **Platinum Enhancement**: Resolved the "red block" visual bug by providing a dedicated high-resolution sprite.
- **Double Deck**: Fixed a crash when starting a run with the Double Deck. The deck now correctly generates 104 cards.
- **MissingNo (Joker 250)**: Fixed logic for random value calculation and state persistence during rounds.
- **Merchant & Thief Tarots**: Resolved crash when used outside the shop context.
- **Event Horizon & Custom Decks**: Fixed recurring crash during round-end or discard events.
- **Startup Stability**: Fixed a critical startup crash that could occur if the mod was disabled.
- **Mod Settings Menu**: Fixed crash in the "CONFIG" tab.
- **Total Conversion - Vanilla Enhancements**: Fixed a bug where vanilla enhancements (Wood, Plastic, etc.) were still appearing in the Collection menu and game pools when "Total Conversion" was enabled.
- **Total Conversion - Stability**: Ensured Decks and Editions are correctly exempted from the vanilla omission filter to maintain project architectural standards and game stability.

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
