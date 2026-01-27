# Changelog

All notable changes to this project will be documented in this file.

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
