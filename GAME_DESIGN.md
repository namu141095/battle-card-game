# Battle Card Game - Complete Game Design Document

## Project Overview

Battle Card Game is a turn-based card battle game inspired by Pokémon, built with Flutter. Players battle AI opponents using a deck of cards with different types and abilities. The game features a type advantage system, strategic move selection, and real-time battle feedback.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    BattleCardGameApp                         │
│                   (main.dart)                                │
└─────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┴─────────┐
                    │                   │
            ┌───────▼────────┐   ┌─────▼──────────┐
            │  HomeScreen    │   │  BattleScreen  │
            │  (home_screen) │   │ (battle_screen)│
            └────────────────┘   └─────┬──────────┘
                                        │
                                ┌───────▼────────────┐
                                │   CardWidget       │
                                │  (card_widget)     │
                                └────────────────────┘
                                        │
                        ┌───────────────┼─────────────────┐
                        │               │                 │
                    ┌───▼──┐      ┌────▼────┐       ┌───▼──┐
                    │ Card │      │ Player  │       │Battle│
                    │Models│      │Models   │       │State │
                    └──────┘      └─────────┘       │Models│
                                                     └──────┘
```

## Game Flow Diagram

```
START
  │
  ├─→ HomeScreen (Display Welcome & Game Info)
  │
  └─→ User clicks "Start Battle"
       │
       ├─→ BattleScreen initializes
       │   ├─→ Create Player 1 & Player 2
       │   ├─→ Load card decks
       │   └─→ Draw first cards
       │
       └─→ Battle Loop:
            │
            ├─→ Display current cards for both players
            ├─→ Current player chooses move
            ├─→ Calculate damage (with type advantage)
            ├─→ Update opponent card HP
            │
            ├─→ [IF opponent card HP <= 0]
            │   ├─→ Mark card as defeated
            │   ├─→ Award points to current player
            │   ├─→ Draw new card for opponent
            │   └─→ [IF opponent has no cards left]
            │       ├─→ Battle ends
            │       └─→ Current player wins!
            │
            ├─→ Switch to opponent turn
            ├─→ Opponent (AI) selects random move after 2 seconds
            └─→ Repeat battle loop
```

## Detailed Class Structure

### Card Model (lib/models/card.dart)

**Properties:**
```dart
- id: String           // Unique identifier
- name: String         // Card name
- type: String         // Element type (fire, water, grass, electric)
- hp: int              // Health points
- attack: int          // Attack power (0-125)
- defense: int         // Defense value (0-100)
- description: String  // Flavor text
```

**Key Methods:**
```dart
getTypeColor()                          // Returns hex color for type
Card.calculateDamage(Card, Card)        // Calculates damage with variance
Card.getTypeAdvantage(String, String)   // Returns damage multiplier (0.5-1.5)
getAvailableMoves()                     // Returns list of available moves
```

**Type System:**
- Fire: Effective against Grass, weak to Water
- Water: Effective against Fire, weak to Electric
- Grass: Effective against Water, weak to Fire
- Electric: Effective against Water, weak to Grass

**Damage Formula:**
```
baseDamage = attacker.attack
defenseFactor = 1 - (defender.defense / 100)
variance = ±10%
damage = baseDamage × defenseFactor × (1 + variance) × typeAdvantage × moveMultiplier
```

### Player Model (lib/models/player.dart)

**Properties:**
```dart
- id: String           // Player ID
- name: String         // Player name
- deck: List<Card>     // List of cards in deck
- activeCard: Card?    // Currently active card
- score: int           // Total points earned
- cardsDefeated: int   // Number of opponent cards defeated
```

**Key Methods:**
```dart
drawCard()             // Draw random card from deck, removes from deck
setActiveCard(Card)    // Set the active card for battle
addScore(int)          // Add points to player score
cardDefeated()         // Increment defeated card counter
reset()                // Reset for new game
```

### Battle State Model (lib/models/battle_state.dart)

**Properties:**
```dart
- player1: Player              // First player
- player2: Player              // Second player
- currentPlayer: Player        // Whose turn it is
- opponent: Player             // The other player
- battleLog: String?           // Current battle action log
- isBattleOver: bool          // Game finished?
- winner: Player?             // Who won
```

**Key Methods:**
```dart
drawFirstCards()              // Draw initial cards for both players
switchPlayer()                // Change whose turn it is
attack(String moveType)       // Execute attack action
reset()                       // Start new battle
getCurrentBattleState()       // Return game state as map
_generateSampleCards()        // Create all 8 starting cards
_initializeDecks()            // Distribute cards to players
```

**Card Deck (8 Cards):**
1. Blaze Dragon (Fire) - 120 HP, 95 ATK, 80 DEF
2. Wave Guardian (Water) - 110 HP, 85 ATK, 90 DEF
3. Forest Protector (Grass) - 100 HP, 88 ATK, 85 DEF
4. Thunder Beast (Electric) - 95 HP, 105 ATK, 70 DEF
5. Inferno Salamander (Fire) - 115 HP, 100 ATK, 75 DEF
6. Tidal Leviathan (Water) - 125 HP, 80 ATK, 95 DEF
7. Verdant Golem (Grass) - 130 HP, 75 ATK, 100 DEF
8. Volt Phoenix (Electric) - 105 HP, 110 ATK, 65 DEF

## Screen Descriptions

### HomeScreen
**Purpose:** Welcome screen and game information
**Components:**
- Title: "Battle Card Game"
- Subtitle: "Challenge opponents with your card deck!"
- Feature list with game information
- "Start Battle" button (launches BattleScreen)
- Footer with credits

**UI Elements:**
- Gradient background (Blue 900 to Blue 600)
- Elevated button for starting battle
- Text containers with semi-transparent background

### BattleScreen
**Purpose:** Main battle arena and game mechanics
**Components:**
1. Score Display (top)
   - Player 1 name and points
   - VS indicator
   - Player 2 (AI) name and points

2. Opponent Card Display
   - CardWidget showing AI's current card

3. Battle Log
   - Text showing last action/damage dealt
   - Type advantage notifications

4. Player Card Display
   - CardWidget showing player's current card

5. Action Buttons
   - Quick Attack (Yellow, 0.8x multiplier)
   - Special Attack (Orange, 1.5x multiplier)
   - Defend (Blue, 0.3x multiplier)

6. Battle Result Screen
   - Winner announcement
   - Final score display
   - "Play Again" button

**Game Logic:**
- Player makes move
- AI responds after 2-second delay with random move
- Turn alternates until battle ends

### CardWidget
**Purpose:** Reusable component for displaying cards
**Components:**
1. Header Section
   - Card name
   - Type badge (colored, uppercase)
   - Description text

2. Stats Section
   - HP box (red)
   - ATK box (orange)
   - DEF box (blue)

3. Moves Section
   - List of available moves with⚔ icon

**Styling:**
- Gradient background based on type color
- Type-based color border (Fire=red, Water=blue, etc.)
- Shadow effect for depth
- Responsive sizing

## Game Rules & Mechanics

### Turn Structure
1. Current player is displayed at top of screen
2. Player selects one of three moves:
   - **Quick Attack** (80% damage)
   - **Special Attack** (150% damage)
   - **Defense** (30% damage - defensive play)
3. Damage calculation occurs with formulas
4. Opponent's HP is reduced
5. AI automatically responds
6. If card isn't defeated, turn switches
7. If card is defeated, new card is drawn

### Win Conditions
- First player to defeat all opponent cards wins
- Winner receives their final score (points = 10 per card defeated)
- Both players' decks have 4 cards each
- Maximum 4 wins per player

### Type Advantage Table
```
Attacker\Defender | Fire  | Water | Grass | Electric
───────────────────┼───────┼───────┼───────┼──────────
Fire               | 1.0x  | 0.5x  | 1.5x  | 1.0x
Water              | 1.5x  | 1.0x  | 0.5x  | 1.5x
Grass              | 0.5x  | 1.5x  | 1.0x  | 1.0x
Electric           | 1.0x  | 1.5x  | 0.5x  | 1.0x
```

### Scoring System
- 10 points per card defeated
- No points deducted for using moves
- Displayed in real-time on battle screen

## Customization Guide

### Adding New Cards

Edit `_generateSampleCards()` in [lib/models/battle_state.dart](lib/models/battle_state.dart):

```dart
List<Card> _generateSampleCards() {
  return [
    // ... existing cards ...
    Card(
      id: '9',
      name: 'Ice Golem',
      type: 'water',  // Should match your type
      hp: 110,
      attack: 85,
      defense: 95,
      description: 'Frozen guardian with powerful defense',
    ),
  ];
}
```

**Type Values:** 'fire', 'water', 'grass', 'electric'

**Recommended Stats:**
- HP: 90-130 (total health)
- Attack: 75-110 (damage output)
- Defense: 65-100 (damage reduction)

### Creating Custom Type

In [lib/models/card.dart](lib/models/card.dart), modify `getTypeColor()`:

```dart
String getTypeColor() {
  switch (type.toLowerCase()) {
    case 'fire':
      return 'FF6B35';  // Orange-red
    case 'water':
      return '004E89';  // Dark blue
    case 'grass':
      return '2ECC71';  // Green
    case 'electric':
      return 'F1C40F';  // Yellow
    case 'ice':        // NEW
      return '00D4FF';  // Cyan
    default:
      return '95A5A6';  // Gray
  }
}
```

And update `getTypeAdvantage()` method to add ice type relationships.

### Adjusting Difficulty

In [lib/screens/battle_screen.dart](lib/screens/battle_screen.dart), AI selection:

```dart
// Change this line in _handleAttack:
final moves = ['quick', 'special', 'defense'];  // Current random

// Make AI smarter (prioritize special attacks):
final moves = ['special', 'special', 'quick', 'defense'];

// Make AI defensive:
final moves = ['defense', 'quick', 'quick'];
```

### Changing Colors

**Home Screen Gradient:**
In [lib/screens/home_screen.dart](lib/screens/home_screen.dart):
```dart
gradient: LinearGradient(
  colors: [Colors.green.shade900, Colors.green.shade600],  // Changed from blue
),
```

**Battle Screen:**
In [lib/screens/battle_screen.dart](lib/screens/battle_screen.dart):
```dart
gradient: LinearGradient(
  colors: [Colors.purple.shade900, Colors.red.shade900],  // Custom colors
),
```

## Performance Optimization

### Current Implementation
- Uses StatefulWidget for state management
- Minimal widget rebuilds with setState
- Card drawing uses random index
- No unnecessary allocations in battle loop

### For Large Deck Size
- Consider Provider or Riverpod for better state management
- Implement lazy loading for card assets
- Cache card widgets

## Testing Scenarios

### Test Case 1: Type Advantage
- Use Fire card vs Grass card
- Verify damage is multiplied by 1.5x
- Use Grass card vs Fire card
- Verify damage is multiplied by 0.5x

### Test Case 2: Card Defeat
- Damage opponent card until HP <= 0
- Verify new card is drawn
- Verify score increases by 10

### Test Case 3: Battle End
- Defeat all opponent cards
- Verify battle ends
- Verify winner is announced
- Verify "Play Again" button works

### Test Case 4: Move Modifiers
- Quick Attack should do ~80% of normal damage
- Special Attack should do ~150% of normal damage
- Defense should do ~30% of normal damage

## File Dependencies

```
main.dart
├── Depends on: HomeScreen
└── MaterialApp wrapper

HomeScreen
├── Depends on: BattleScreen (navigation)

BattleScreen
├── Depends on: BattleState model
├── Depends on: CardWidget
├── Creates: Player instances
└── Uses: setState for updates

CardWidget
├── Depends on: Card model
└── Pure display component

BattleState
├── Depends on: Card, Player models
└── Contains: Core game logic

Card
└── Standalone model

Player
└── Standalone model
```

## Future Enhancement Ideas

1. **Advanced Features**
   - Multiple card types (7+)
   - Special abilities per card
   - Item/buff system
   - Status effects (poison, paralysis)

2. **Gameplay**
   - Campaign mode (multiple battles)
   - Different difficulty levels
   - Deck building system
   - Card rarity system

3. **UI/UX**
   - Animated card transitions
   - Visual effects for type advantage
   - Sound effects
   - Background music
   - Victory animations

4. **Social**
   - Multiplayer battles
   - Leaderboards
   - Achievement system
   - Replay sharing

5. **Data**
   - Save games
   - Card collection
   - Battle history
   - Statistics

---

**Document Version:** 1.0  
**Last Updated:** February 9, 2026  
**Flutter Version:** 3.0.0+
