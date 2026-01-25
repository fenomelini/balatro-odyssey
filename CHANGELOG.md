# Changelog

All notable changes to this project will be documented in this file.

## [0.1.1-alpha] - 2026-01-25

### Fixed
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
- Default Hand Size increased to 10 to accommodate high-level strategic play.
- Updated `manifest.json` and internal header to version `0.1.1-alpha`.
