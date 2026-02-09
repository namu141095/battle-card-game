# Battle Card Game - Flutter

A simple Pokémon-style battle card game built with Flutter. Battle opponents with your card deck, utilize type advantages, and manage your strategy wisely!

## Features

✨ **Game Features:**
- 8 unique collectible cards with different types (Fire, Water, Grass, Electric)
- Type advantage system (Rock-Paper-Scissors style mechanics)
- Real-time battle log showing move results
- AI opponent with automatic move selection
- Score tracking and card defeat counter
- Beautiful gradient UI with card styling
- Strategic move selection (Quick Attack, Special Attack, Defense)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── card.dart            # Card model with stats and damage calculations
│   ├── player.dart          # Player model for deck and score management
│   └── battle_state.dart    # Battle logic and game state management
└── screens/
    ├── home_screen.dart     # Welcome/menu screen
    ├── battle_screen.dart   # Main battle arena screen
    └── card_widget.dart     # Card display widget
```

## Game Mechanics

### Card Types & Advantages
- **Fire** beats **Grass** (1.5x damage)
- **Grass** beats **Water** (1.5x damage)
- **Water** beats **Fire** (1.5x damage)
- **Electric** beats **Water** (1.5x damage)

### Move Types
1. **Quick Attack** - 0.8x damage, fast and reliable
2. **Special Attack** - 1.5x damage, powerful but risky
3. **Defense** - 0.3x damage, focuses on protection

### Battle Flow
1. Each player draws cards from their deck
2. Players take turns attacking
3. Damage is calculated based on attacker's power and defender's defense
4. Type advantage multiplies damage (0.5x - 1.5x)
5. When a card's HP reaches 0, it's defeated and replaced with next card
6. Battle ends when one player runs out of cards
7. Winner earns 10 points per card defeated

## Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter extension
- Device or emulator ready

### Installation & Setup

1. **Install Flutter** (if not already installed):
   - Visit https://flutter.dev/docs/get-started/install
   - Follow platform-specific setup guide
   - Verify installation: `flutter doctor`

2. **Navigate to project directory**:
   ```bash
   cd C:\Users\n-ma\Desktop\game\battle-card-game
   ```

3. **Get dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## How to Play

1. **Launch** - Start the application and view the home screen
2. **Understand the Game** - Read feature list to understand mechanics
3. **Start Battle** - Click "Start Battle" button
4. **Make Moves**:
   - Choose move: Quick Attack, Special Attack, or Defend
   - AI opponent automatically responds after 2 seconds
5. **Use Strategy**:
   - Exploit type advantages for bonus damage
   - Use Special Attack when you need a power move
   - Use Defend against strong opponents
6. **Win** - Defeat all opponent cards to victory!

## Customization

### Add More Cards
Edit `_generateSampleCards()` in lib/models/battle_state.dart:

```dart
Card(
  id: '9',
  name: 'Your Card Name',
  type: 'fire', // fire, water, grass, electric
  hp: 100,
  attack: 90,
  defense: 85,
  description: 'Card description',
),
```

### Adjust Game Balance
- Modify damage formula in `Card.calculateDamage()`
- Change type advantage in `Card.getTypeAdvantage()`
- Adjust move multipliers in `BattleState.attack()`
- Modify scoring in battle logic

## Technical Stack

- **Framework**: Flutter 3.0.0+
- **Language**: Dart
- **State Management**: StatefulWidget
- **UI**: Material Design 3

## Building for Release

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Flutter not found | Install Flutter SDK and add to PATH |
| Build errors | Run `flutter clean` then `flutter pub get` |
| Emulator issues | Run `flutter devices` to check targets |
| Slow performance | Ensure device has sufficient resources |

## Future Enhancements

- More card types and abilities
- Leaderboard system
- Save/load game functionality
- Sound effects and music
- Card animations and effects
- Difficulty levels
- Multiplayer support
- Card creation tools

## License

This project is provided as-is for educational purposes.

---

**Enjoy the battle! 🎮⚔️**
