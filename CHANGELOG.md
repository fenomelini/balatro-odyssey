# Changelog

All notable changes to this project will be documented in this file.

## [0.1.9-alpha] - 2026-03-15

### Fixed

#### Jokers

**Singularity series (#1–40):**

- **Dimensional Isolator (#18)**: Was activating whenever it was placed at the edge of the Joker row — i.e., with only one neighbor. It is designed to activate only when completely isolated with no neighbors on either side. Fixed.
- **Reverse Big Bang (#40)**: Was dealing X10 Mult instead of the intended X5 Mult. Fixed.

**Quantum series (#41–80):**

- **Schrödinger's Cat (#48)**: Was giving +25 Mult per flip instead of the correct +20 Mult. Fixed.
- **Time Paradox (#61)**: Tracks your previous hand's score and adds it as a bonus to your next hand. It was always reading zero for both score values, so the bonus was always nothing — and on the second hand played, the game would crash. Fixed.
- **Infinite Loop (#63) and Chrono Trigger (#67)**: Both jokers count how many times a specific hand type has been played and reward you for it. Both counters were stuck at zero at all times, so the reward never triggered — and playing a hand could crash the game. Fixed.
- **Dimensional Portal (#71)**: When changing the suit of a card in your hand, it could enter an infinite freeze if the random selection kept returning the suit the card already had. The joker now always picks a different suit immediately. Fixed.
- **Higher Planes (#79)**: Was randomly giving either X3 Mult or +100 Mult on a coin flip. The correct behavior is always a flat +100 Mult. Fixed.
- **Hyperspace (#80)**: Was always giving a flat X10 Mult regardless of hand size. The correct behavior is +15 Mult per card scored, up to 5 cards (maximum +75 Mult). Fixed.

**Temporal series (#81–120):**

- **Time Traveler II (#103)**: Tracks your highest Mult and Chips from scoring and uses them as a future bonus. It was always recording 0 for both values, so the boost was always nothing. Fixed.
- **Stasis (#106)**: Was supposed to grant a bonus hand every time a Blind was beaten. It never triggered. Fixed.
- **Uncertain Future (#108)**: Same issue as Time Traveler II — always recording 0 for scoring values, so the bonus never activated. Fixed.
- **Forgotten Past (#117)**: Promises +2 extra hands when equipped. The hands were never actually granted. Fixed.
- **Eternal Loop (#120)**: Counts how many times a specific hand type has been played and rewards you for it. The counter was always reading as zero due to a mismatched name, so the reward never worked — and playing a hand could crash the game. Fixed.

**Dimensions series (#121–160):**

- **Infinite Growth (#122)**: Was supposed to permanently gain X0.05 Mult each time a Blind was beaten. It never scaled at all. Fixed.
- **Best Play (#136)**: Tracks the best hand played each round and applies those stats as a bonus on your final hand. It was always recording the minimum possible values, making the final-hand bonus effectively useless. Fixed.
- **Learning (#137)**: Was supposed to permanently gain +5 Mult whenever a Blind was beaten while using more than one hand. It never triggered. Fixed.
- **Dimensional Merge (#151)**: Did absolutely nothing when a Two Pair was played — the entire effect was missing. The mechanic (score a bonus based on the gap between Two Pair and Four of a Kind base values) is now fully implemented.
- **Dimensional Lord (#153)**: Hovering over this card in the Collection menu crashed the game. Fixed.
- **Dimensional Collapse (#156)**: If a Blueprint was copying this joker when a Boss Blind started, two random Jokers were destroyed instead of one. Fixed.

**Celestial series (#161–200):**

- **Rings of Saturn (#180)**: The "+20 Mult" popup was appearing over the Joker card itself instead of over the 8 being scored. Fixed.
- **Zero Gravity (#181)**: Was supposed to give X3 Mult when playing a Straight. The multiplier was silently ignored due to a wrong internal key. Fixed. Additionally, the promised wraparound Straight mechanic (K-A-2-3-4 counts as a Straight) was never implemented. Now fully works.
- **White Dwarf (#190)**: Was only activating on the very first hand of each round instead of every hand. Fixed.
- **Big Bang (#191)**: When sold, was supposed to spawn 5 random Common Jokers. The rarity value was invalid, causing the game to create nothing (or crash). Fixed.
- **Cosmic Inflation (#196)**: Was doubling your money after every Blind won, not just Boss Blinds. Fixed.

**Chaos series (#201–240):**

- **Frenzy (#212)**: Gains +5 Mult every time a hand is played and should reset when the player discards. The reset condition had a guard that was always false during discard events, so the Mult never reset and kept growing forever. Fixed.
- **Butterfly Effect (#218)**: Supposed to make all played cards score with the suit of the first card in the played hand. Was instead permanently changing the suits of the cards in the player's hand (the ones not being played). Fixed to only affect the played hand.
- **Discord (#220)**: Gives a bonus when you play a hand that isn't the "highest-level" hand type. Was incorrectly using how many times each hand had been played instead of its Planet level to determine the top hand. Fixed to use hand level.
- **Transmutation (#223)**: When sold, was supposed to spawn a random Uncommon Joker. The rarity value used was invalid — same class of bug as Big Bang (#191). Nothing appeared when the joker was sold. Fixed.
- **Will-o'-the-Wisp (#226)**: Creates a Negative consumable when a Boss Blind is defeated. Had no check for whether the consumable slots were full — the card could be added over the limit, causing UI overflow and potential crashes. Fixed.
- **Primal Form (#234)**: Was supposed to transform all played cards into Aces for the current hand. Was selecting the wrong cards (held hand instead of the played hand), and the transformation code used a broken internal card-lookup format that always crashed the game immediately. Both issues fixed.
- **Maximum Entropy (#235)**: Destroys a random Joker at the end of each round. Could target and destroy Eternal Jokers, which are supposed to be indestructible. Fixed.
- **Heart of Chaos (#236)**: Copies the effect of a random Joker to its right. Was updating the shared scoring context object in-place, causing all Jokers evaluated after it to behave as if they were being copied by Blueprint — suppressing things like card creation or consumable rewards. Fixed to pass a local copy of the context.
- **Crawling Chaos (#240)**: Gains X0.5 Mult every hand and is supposed to reset back to X2 after failing a round. The reset never triggered, so the multiplier grew permanently. Fixed.
- **Chain Reaction (#225)**: Was supposed to give +5 Mult for each Joker ability that activated during the current hand. Instead, it was using the total number of Jokers owned as a proxy — owning 5 Jokers always gave the same bonus regardless of how many actually fired. Now counts real activations.
- **The Great Filter (#238)**: Was supposed to permanently unlock X5 Mult the first time you played a Five of a Kind. It never triggered because the hand name check used `'5 of a Kind'` instead of the engine's actual name `'Five of a Kind'`. Fixed.

**Glitch series (#241–280):**

- **Dead Pixel (#244)**: Was debuffing a random card from the unplayed hand instead of from the scored hand. The debuff was also permanent — it was never cleared at the end of the round, leaving cards crippled for the rest of the run. Fixed.
- **MissingNo (#250)**: The XMult it generates was silently discarded every hand due to a wrong internal key. The joker showed the correct popup but applied nothing. Also crashed the Collection menu when opened. Both fixed.
- **Blue Screen (#251)**: When discarding 5 same-suit cards, it was awarding $4 five times ($20 total) instead of once. Fixed.
- **God Mode (#259)**: The rescue effect was triggering once per card in your hand simultaneously, causing a crash when the second trigger tried to access an already-destroyed joker reference. Fixed to trigger only once.
- **Noclip (#260)**: Was an empty stub — the mechanic (face cards count as any suit) was never implemented. Now fully implemented.
- **Hex Editor (#275)**: Was using broken internal card-lookup keys to reference cards in the game's table. This crashed the game whenever the effect tried to look up a card. Fixed.
- **Digital Singularity (#280)**: Crashed the Collection menu when opened due to unsafe tooltip generation. Fixed.

**Corruption series (#281–320):**

- **Decomposition (#288)**: Was supposed to permanently gain +5 Mult for every card discarded throughout the entire run. It was destroying itself after the very first discard, picking up only +5 Mult once and disappearing. Fixed.
- **Pestilence (#311)**: Playing a Flush crashed the game. Fixed.

**Paradox series (#321–360):**

- **Reverse Flush (#326)**, **Pacifist Joker (#333)**, **Order of Chaos (#338)**, **All or Nothing (#339)**, **Zeno's Paradox (#340)**, **Alive and Dead Cat (#341)**, **Beginning of the End (#342)**: All 7 jokers showed an XMult popup when triggered but the multiplier was never actually applied to the score. Fixed across the board.
- **Useful Discard (#324)**: Discarding cards should permanently award +2 Chips for the current round. None of the Chips were being awarded when cards were discarded. Fixed.
- **Failure's Success (#337)**: Should give $10 whenever the player fails to beat a Blind. Was giving $10 whenever the player won instead. Fixed.
- **Grandfather Paradox (#360)**: Should save the player when they lose a Blind. The rescue never triggered — losing a round never activated the effect. Fixed.
- **Square Circle (#343)**: Did absolutely nothing. Diamond cards should count as black cards for all scoring purposes. The effect is now fully implemented.
- **Hot Cold (#344)**: Did absolutely nothing. Hearts should score as Spades and Spades should score as Hearts. The effect is now fully implemented.
- **Past Future (#345)**: Was supposed to give X3 Mult if the previous Blind was beaten in a single hand. The joker was completely inactive — the multiplier never applied and the game never tracked how many hands were used in the previous round. Fixed.
- **Mortal Immortal (#347)**: Was supposed to allow Eternal Jokers to be sold for $0. Even with this joker in play, Eternal Jokers still could not be sold. Fixed; Eternal Jokers now show a $0 sell button and can be removed from play.

**Anomaly series (#361–400):**

- **Spade Anomaly (#361)**, **Heart Anomaly (#362)**, **Club Anomaly (#363)**, **Diamond Anomaly (#364)**: All 4 jokers are supposed to make one suit count as another when forming Flushes. They were doing nothing at all — the suit swaps were never applied. Fixed.
- **Static Noise (#374)**: Should give a 1 in 4 chance to gain $5 each time a hand is played. It was only rolling that chance once, at the very end of the round. Fixed.
- **Chromatic Anomaly (#367)**: Supposed to make Polychrome editions appear more often in the shop. Had no effect whatsoever — the Polychrome rate increase was tracked internally but never applied. Fixed.
- **Augmented Reality (#381)**: Should prevent Ceramic Cards from breaking. Ceramic Cards kept breaking regardless. Fixed.
- **Race Condition (#388)**: Should give +50 Mult only if the very first hand of the round is played within 5 seconds. It was always giving +50 Mult with no time check at all. Fixed.
- **Mirror Universe (#394)**: Should double all money gained and all money lost. Neither effect was being applied. Fixed.
- **Function Collapse (#397)**: Should make face cards (J, Q, K) count as having no suit for Flush purposes. Face cards were behaving normally regardless. Fixed.
- **Memory Dump (#387)**: Selling this joker was supposed to add 3 random cards to your hand. Instead, the game crashed every time it was sold. Fixed.
- **The Watcher (#399)**: The secondary effect — revealing the order of cards remaining in your deck — was never implemented. While this joker is in play, deck cards are now shown face-up so you can see what you'll draw next. Fixed.

**Tribal series (#451–500):**

- **Necromancer (#462)**: Should revive the last destroyed face card back into your deck during the next scoring hand. It never activated — the game was never recording which face card was destroyed, so there was nothing to revive. Additionally, the revival code itself had a bug that would have put the wrong card type back even if the data existed. Both issues are now fixed.
- **Viking (#481)**: Should pay $1 at end of round for each playing card destroyed during that round. The counter tracking destroyed cards was initialized but never incremented, so Viking always paid $0. The counter also never reset between rounds, which would have caused permanent over-payment had it ever worked. Both issues are now fixed.
- **Mage Circle (#492)**: Should grant +1 Consumable Slot and make Tarot cards appear twice as often in the shop. The consumable slot worked, but the Tarot frequency boost was completely missing — the code comment said "handled elsewhere" but that code was never written. The Tarot rate bonus is now correctly applied when the joker is in play.
- **King of Kings (#499)**: Should make all played cards count as Kings for rank-based triggers while in play. The joker correctly sets an internal flag when added to your collection, but nothing ever read that flag to change how cards report their rank. All played cards now correctly report as Kings while this joker is active.
- **Assassin (#475)**: Should destroy the lowest-ranked held card and grant X2 Mult each time a hand is played. The card destruction worked correctly, but the X2 Mult reward was silently discarded and never applied to the score. Fixed.

**Elemental series (#401–450):**

- **Magma (#412)**: Should make Hearts and Diamonds count as the same suit while in play. The effect was tracked internally but never applied — Hearts and Diamonds were always treated as separate suits. Fixed.
- **Mud (#413)**: Should make Spades and Clubs count as the same suit while in play. Same issue as Magma — the effect was never applied. Fixed.
- **Ash (#420)**: When all 5 discarded cards were red, was awarding $3 up to five times ($15 total) instead of once. Fixed.
- **Blizzard (#436)**: After scoring a 5-Spades hand, the "Freeze Blind" effect — preventing the next round's Blind requirement from increasing — was tracked internally but never actually applied. Fixed.
- **Phoenix (#439)**: When all 5 discarded cards were Hearts, was gaining +1 Mult up to five times instead of once. Fixed.
- **Leviathan (#440)**: The +1 maximum Hand bonus from scoring a 5-Spades Flush was only lasting for the current round instead of being permanent. Fixed.
- **Fifth Element (#443)**: The four Elemental Spirit Jokers (Fire, Water, Earth, Air) could never be detected due to an internal naming mismatch, so the X5 Mult bonus never activated. Fixed.
- **Master Alchemist (#444)**: Attempting to convert any card to a Diamond immediately crashed the game due to an invalid internal card reference. Fixed.
- **Heart of the World (#445)**: Should prevent Boss Blinds from debuffing your cards based on suit. The immunity was tracked internally but never applied — cards were still being debuffed normally. Fixed.
- **Absolute Zero (#448)**: Crashed the game the moment any hand was scored while this joker was in play. Fixed. Additionally, the zero-chip detection now correctly identifies hands where no chips were scored.
- **Avatar (#449)**: Should allow any 5-card combination to count as a Flush, regardless of suit. The effect was tracked internally but the hand evaluation was never overridden — only true same-suit hands counted as Flush. Fixed.
- **Cataclysm (#450)**: Crashed the game immediately when purchased, due to an invalid internal random number calculation producing a nil suit. Fixed.

#### Decks

- **42 decks were showing Portuguese names and descriptions in English**: 42 decks had names like "Ira Deck", "Preguiça Deck", "Vulcânico Deck", and descriptions with Portuguese mixed in when playing in English. All 42 now display correct English text. Affected decks: Wrath, Sloth, Pride, Alpha, Omega, Prime, Odyssey, Fractal, Mirror, Ghost, Vampire, Zombie, Cyborg, Mutant, Clone, Radioactive, Frozen, Volcanic, Oceanic, Solar, Lunar, Stellar, Mystic, Tech, Primitive, Arcane, Celestial, Spectral, Standard, Buffoon, Mercenary, Investor, Minimalist II, Maximalist II, Lucky II, King Arthur, Merlin, Phoenix, Chimera, Unicorn, Behemoth, Titan.

- **Odyssey Deck (#50) and Unicorn Deck (#94)**: These two decks start with a random Legendary Joker. They were sometimes picking Jokers that don't exist in this mod, crashing the game. They now always pick from the correct pool.

- **Sloth Deck (#42)**: The number of discards was being reduced by a huge amount instead of 3. In practice this gave the player negative discards, which could crash the game. Fixed to correctly reduce by 3.
- **Cyborg Deck (#56)**: The automated Jokers created by this deck had no rarity assigned, causing a crash when the game tried to display them. Fixed.
- **Sloth Deck (#42) and Invisible Deck (#60)**: The X3 / X4 Mult bonuses were not working correctly — the bonus scaled with the number of Jokers you had instead of being a flat multiplier. Both now apply their multiplier correctly at all times.
- **Oceanic (#66), Solar (#67), Minimalist II (#80)**: Same multiplier issue as above. All three now apply their bonuses correctly.
- **Dragon (#89), Leviathan (#96), Behemoth (#97), Mirror (#53), Event Horizon (#7), Vampire (#54)**: Same multiplier issue as above. All six now apply their bonuses correctly.
- **Maximalist II (#81)**: The number of discards was being reduced by 3 instead of kept the same as the base game, unintentionally giving the player too many or too few depending on the situation. Fixed.
- **Dragon Deck (#89)**: The Blind score requirement was not being multiplied as described. It now correctly makes Blinds 10x harder.
- **Poverty Deck (#38)**: Interest was being calculated incorrectly and paying out less money than intended. Fixed.
- **Radioactive Deck (#62)**: Rank decay was crashing the game mid-round. Fixed.
- **Ghost Deck (#53), Vampire Deck (#54)**: Face-down card detection was broken, causing incorrect behavior when cards were flipped. Fixed.
- **Timeline Deck (#33)**: The bonus from the previous hand was never actually being added to your score — it was silently zeroing out the counter instead. The bonus now applies correctly every hand.
- **Phoenix Deck (#90)**: The once-per-run resurrection never triggered when the player had no Jokers in play. It now works regardless of how many Jokers you have.
- **6 deck popup messages** were missing from both languages, showing `"ERROR"` in floating text during gameplay. All 6 now display correctly.

### Added

#### Decks

- **Enhancement Decks #25–32 now have custom artwork**: The eight decks based on mod enhancements (Ceramic, Rubber, Platinum, Diamond, Magic, Holy, Ruby, Emerald) were using generic placeholder images. Each deck now displays its own unique image.

- **10 Decks fully implemented for the first time** — the following decks had descriptions but no working mechanics. All have been implemented with faithful (or redesigned-where-necessary) mechanics:
  - **Zombie Deck (#55)**: Once per round, the first discarded card automatically returns to hand.
  - **Ethereal Deck (#61)**: At the start of each Ante, receive 1 free Spectral card.
  - **Magnetic Deck (#63)**: Cards of the same rank are sorted together in the deck and drawn in groups.
  - **Lunar Deck (#68)**: 4-blind scoring cycle — New Moon (1x) → Waxing (1.5x) → Full Moon (2x) → Waning (0.5x).
  - **Primitive Deck (#72)**: Shop items cost $9999 (effectively inaccessible). Blind rewards are doubled.
  - **Mercenary Deck (#78)**: No money is earned from winning Blinds. Each Joker sold grants $5 instead.
  - **Chimera Deck (#92)**: Deck starts with 4 groups of 13 enhanced cards: Rubber, Ceramic, Holy, and Magic.
  - **Titan Deck (#98)**: Hand size is 4 (each card occupies 2 slots).
  - **Alien Deck (#57)** *(redesigned)*: The original mechanic (4 new alien suits) was not possible to implement without breaking how Flushes work. New mechanic: starting card suits are randomized, and Flush scores X2 Mult.
  - **Hydra Deck (#91)** *(redesigned)*: The original mechanic (extra Blinds after winning) was not possible to implement without rebuilding how the blind progression works. New mechanic: each Blind beaten permanently grants +2 Mult.

---

## [0.1.8-alpha] - 2026-03-13

### Fixed

#### Startup Crashes

- **17 Jokers caused the game to crash at startup** because their artwork files had mismatched names — the game couldn't find the images it expected and refused to load. All 17 now load correctly:
  - Beginner's Luck, Pandora's Box *(Chaos)*
  - Fool's Gold, Philosopher's Stone, Market's Hand *(Economy)*
  - Devil's Hand, King's Hand, Queen's Hand, Jack's Hand, Ace's Hand *(Hand & Discard)*
  - Liar's Paradox, Failure's Success, Zeno's Paradox, Fermi's Paradox *(Paradox)*
  - Celestial Wormhole *(Celestial)*
  - Post-Apocalypse *(Corruption)*
  - Apotheosis *(Transformations)*

#### Decks

- **Ceramic Deck, Gold Deck, Steel Deck, Stone Deck**: These four decks had no Portuguese description at all. They now display correct text in both languages.
- **13 Decks showing Portuguese text in English**: When playing in English, the following decks were displaying their descriptions in Portuguese. All now show correct English text: Alien Deck, Unlucky Deck, Chaotic II Deck, Dragon Deck, Ethereal Deck, Griffin Deck, Hydra Deck, Invisible Deck, Kraken Deck, Lust Deck, Magnetic Deck, Ordered II Deck, King Midas Deck.

#### Blinds

- **The Infinity (Boss #88)** and **The Zero (Boss #89)**: The English version of these two Boss Blinds was displaying the Portuguese words instead of their English equivalents. They now correctly read "Singularity" and "Nullity".
- **The Blue Screen (Boss #95)**: The Portuguese version was showing the untranslated English acronym "BSOD (Blue Screen of Death)". It now correctly reads "Tela Azul da Morte (BSOD)".

---

## [0.1.7-alpha] - 2026-03-12

### Fixed

#### Jokers

- **Basilisk**: Description was incorrectly listing the wrong card type. Now correctly references Emerald cards in both languages.
- **Seer**: The next card's suit was not being shown in the description as promised. The suit now displays correctly. Mult formatting was also wrong and has been corrected.
- **Shaman**: Was permanently enhancing cards that stayed in hand instead of only the cards actually played. Now only affects the cards you play.
- **Syntax Error**: Two values — Chips and Money — were completely missing from the description, showing blank spaces. Both now display correctly.
- **The Sage (#70)**: Using this Joker was crashing the game. Fixed.

#### Tarots

- **The Thief (#11)**: When stealing a card from the shop, the card was being added to your inventory without being removed from the shop, leaving a ghost copy behind. It is now correctly removed from the shop when taken.
- **The Soul (#12)**: Was creating common or uncommon Jokers instead of the Legendary Joker it is supposed to produce. Now correctly gives a Legendary Joker.
- **King / Queen / Jack / Ace (#13)**: Were always creating cards with the same fixed suit instead of a random one. The suit is now properly randomized each time.
- **The Fool & Fool II (#15 / #27)**: These cards could never be used — they were looking for a field that doesn't exist in the game. Both now work correctly.
- **Builder (#21)**: Was granting the extra discard only at the start of the next round instead of immediately in the current round. Now grants the discard right away.
- **The Lie (#22)**: Cards were not actually being hidden — they were just staying face-up. Cards now correctly flip face-down. The money shown in the description was also missing its yellow color formatting.
- **The Dream (#52) & The Nightmare (#53)**: When used, these cards were creating base game Tarot/Spectral cards (such as "The High Priestess") instead of Odyssey-exclusive ones. Both cards now always produce a random Odyssey card of the correct type. Descriptions updated in both languages to clarify the effect.
- **The Order (#40)**: Two bugs fixed. (1) The promised +10 permanent Chip bonus to all cards in hand was never actually happening — the card was only rearranging the hand visually without granting any bonus. It now correctly sorts the hand by Suit and gives every card in hand a permanent +10 Chips bonus. (2) The English description had the wrong name ("Order" instead of "The Order") and showed the Portuguese word "Fichas" instead of "Chips".

#### Planets

- **Kepler / Kepler-452b (#23)**: The level-up animation was playing once for each poker hand in the game, causing a long freeze. It now plays a single animation and instantly levels up all hands at once.

#### Vouchers

- **Magician**: Was not granting the $1 reward when a Tarot was used. Now correctly pays out each time. The Illusionist (its upgrade) was also not adding the Tarot back for a second use — this has been fixed.
- **Shadow**: The debuff immunity granted by this voucher was not being respected. Cards were still being debuffed by Boss Blinds as normal. Now works correctly.
- **Mechanic & Engineer**: Both vouchers existed in the game but did absolutely nothing when redeemed. Their intended effects are now fully implemented.
- **Mechanic** (description): Fixed a text typo in the English description.

#### Blinds

- **Chaos Blind**: The "suits change randomly after each discard" mechanic was completely missing — the blind existed but did nothing special. Suit randomization now triggers correctly after every discard.

#### Decks

- **Order Deck**: Two bugs fixed. (1) The deck was never actually sorting the cards — the sort was never being called. The deck now correctly starts each round in order from lowest to highest rank so you draw 2s first. (2) The X2 Mult bonus for playing cards in order was firing multiple times (once per Joker owned) instead of once per hand, meaning with 5 Jokers it was giving X64 Mult. Now correctly fires once per hand.
- **Timeline Deck**: The "10% of previous hand score added to current hand" bonus was completely non-functional — it never triggered during play. The bonus now correctly applies at the end of every hand, regardless of how many Jokers you have. The timing was also fixed: the bonus from the previous hand is now applied to the current hand, and 10% of the current hand is saved for the next one, as intended.
- **Leviathan Deck**: The English version of the deck was showing its name and description in Portuguese. Corrected to display proper English text.

---

## [0.1.6-alpha] - 2026-03-11

### Added

#### Spectrals — 38 Cards Now Actually Work

A full review of all 100 Spectral cards revealed that 30 of them were completely absent from the game and 8 others existed on paper but did absolutely nothing when used. All 38 have now been fully implemented. Here's what each one does:

- **Big Bang**: Resets your hands and discards back to where they started this round, and permanently grants X2 Mult.
- **Cordas**: Permanently reduces your hand size by 2, but upgrades every poker hand type by 1 level as compensation.
- **Heisenberg**: Hides the score requirement of the current blind and immediately hands you $30.
- **Drake**: From this point on, whenever you play a hand that beats the current blind score, you score with X2 Mult.
- **Galileu**: Immediately adds 2 random Tarot cards to your consumable area.
- **Newton**: Each unscored card you play this round adds +1 to your available hand count.
- **Hawking**: Immediately adds 2 random Spectral cards to your consumable area.
- **Tyson**: Levels up every poker hand type by 1.
- **Kaku**: Levels up every poker hand type by 2 and permanently raises your hand size by 2.
- **Penrose**: Each card you play has a 25% chance to score one extra time.
- **Gödel**: Doubles the score requirement of the current blind, but grants X3 Mult for the rest of this round.
- **Turing**: Immediately spawns a random Joker and gives you $20.
- **Feynman**: Every Joker you currently own permanently gains +10 Mult.
- **Bohr**: From now on, every time you draw cards your hand order is randomly shuffled.
- **Curie**: At the end of every future round, all cards in your deck permanently change to a random rank.
- **Darwin**: Every time a card contributes to scoring, it permanently gains +1 Chip.
- **Mendel**: Every card in your deck immediately gains a random Edition (Foil, Holographic, Polychrome, or Negative).
- **Tesla**: Every consumable you use now has a 50% chance of not being consumed.
- **Marconi**: Cards that share a rank with another card in the same hand score one additional time.
- **Wright**: All playing cards in your deck permanently become immune to Boss Blind debuffs.
- **Babbage**: Your very next hand scores with X5 Mult.
- **Lovelace**: Permanently sorts all cards in your deck from lowest to highest rank.
- **Hopper**: Each scoring card has a 10% chance to trigger X100 Mult.
- **Berners-Lee**: Every Joker you currently own permanently gains +5 Mult.
- **Gates**: The top 5 cards of your deck are permanently flipped face-up so you can see what's coming.
- **Musk**: Levels up all Flush variants (Flush, Straight Flush, Royal Flush, Flush Five, Flush House) by 5.
- **Nakamoto**: After every hand you play, your money randomly changes by ±50%.
- **Collins**: Immediately duplicates every consumable currently in your hand area.
- **Laika**: All Jokers you currently own receive the Eternal sticker and can never be sold or destroyed.
- **Ham**: All Jokers you currently own permanently gain +100 Chips.
- **Leonov**: Highlight up to 2 cards before using this — they will be kept in your hand at the start of the next round.
- **Hadfield**: All Jokers you currently own score with X2 Mult for the very next hand.
- **Kelly**: Every card in your deck receives a random Seal.
- **Cristoforetti**: Every hand you play this round permanently adds +5 Mult.
- **Peake**: All Spade cards in your deck become Ruby-enhanced cards.
- **Vostok**: Levels up Flush and Flush Five by 3.
- **Mercury**: Levels up Straight and Straight Flush by 3.
- **Gemini**: Levels up Two Pair and Pair by 3.

### Fixed

#### Spectrals

- **Singularity (#21)**: When used with only 2 Jokers, it was destroying the same Joker twice instead of destroying the first and second Jokers separately. The second Joker now correctly disappears.
- **Two crash bugs**: After implementing the spectrals above, two cards (Pauli and Edison) had their entries accidentally broken during editing, causing the game to crash at startup. Both have been restored, and a full syntax check confirmed all 100 spectral entries are valid.

#### Tarots

- **The Creator (#75)**: When used, the generated Legendary Joker was landing in the consumable slot instead of the Joker slot, making it completely inaccessible and leaving an empty ghost card behind. It now correctly appears in your Joker area.
- **King / Queen / Jack / Ace (Tarots #62–65)**: These tarots were supposed to create a card of the stated rank with a *random* suit, but every single generated card always had the exact same fixed suit. The suit is now properly randomized.
- **The Order (#40)**: In addition to its intended effect, it was incorrectly granting all hand cards a permanent +10 Chip bonus that was never part of its design. This unintended bonus has been removed.
- **The Blacksmith (#90)**: Was applying the Paper enhancement (tears when discarded) instead of the Rubber enhancement (rebound effects) it is supposed to grant. The correct enhancement is now applied.
- **Matter (#30) & Energy (#31)**: Using these cards from the shop caused the newly created Emerald/Plastic cards to appear floating in front of the shop UI rather than entering the hand properly. These tarots now correctly require you to be in an active round — when your hand is visible on screen — before they can be used.

#### Decks

- **Multiple Decks — Silent Broken Mechanics**: Two core game triggers that several deck effects depended on were calling internal functions that don't actually exist, meaning those effects quietly never ran at all. This was silently breaking the **Supernova**, **Greed**, **Mutant**, and **Radioactive** decks, among others. The correct triggers are now in place and all affected mechanics work.
- **Wrath Deck**: Was incorrectly granting a free extra discard every round due to a configuration error. Discards now correctly cost $1 per card used as intended.
- **Chaotic Blind II**: Was accidentally awarding X2 Mult bonus to the player (making it *easier* than a normal blind). It now correctly applies its difficulty as designed.
- **Ordered Blind II**: Was accidentally applying X0.5 Mult penalty to the player (making it *harder* than intended). Fixed.
- **Griffin Deck**: The mechanic that automatically skips the Small Blind was silently not working. Fixed.
- **Mercenary Deck**: Selling a Joker was not granting the promised +$5 bonus. It now correctly pays out on every sale.
- **Phoenix Deck**: The resurrection mechanic — which is supposed to save you the first time you fail a blind — was completely broken and never triggered. It now correctly activates on blind failure.
- **Odyssey Deck (#50)**: Was not correctly spawning a random Legendary Joker at run start. Fixed.
- **Unicorn Deck (#94)**: Was not correctly spawning a random Legendary Joker at run start. Fixed.

#### Shop & Vouchers

- **Vacuum Deck**: The deck description promises shops with 6 card slots, but shops were always showing only the default 2. The effect that was supposed to expand the shop was written but never actually applied to the game. Shops now correctly show 6 card slots when playing with this deck.
- **10 Vouchers with extra shop slots** (Cloning, Replicator, Library, Archives, Deep Space Observatory, Planetarium, Laboratory, Research Center, Card, Deck): All ten of these vouchers promised to add extra card slots to the shop, but redeeming them did absolutely nothing — the shop size never changed. Fixed across all ten: each voucher now immediately expands the shop when redeemed.

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
