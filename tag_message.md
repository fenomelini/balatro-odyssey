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
