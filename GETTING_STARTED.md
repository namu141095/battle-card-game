# Getting Started with Battle Card Game

## Quick Start Guide

### Step 1: Install Flutter

**Windows:**
1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract to a location (e.g., `C:\flutter`)
3. Add Flutter to your PATH:
   - Right-click "This PC" → Properties → Advanced system settings
   - Click "Environment Variables"
   - New User Variable: `FLUTTER_HOME` = `C:\flutter`
   - Add to Path: `C:\flutter\bin`
4. Open new PowerShell and verify:
   ```powershell
   flutter --version
   ```

### Step 2: Setup Project

1. Open PowerShell in project directory:
   ```powershell
   cd C:\Users\n-ma\Desktop\game\battle-card-game
   ```

2. Get dependencies:
   ```powershell
   flutter pub get
   ```

3. Check your devices:
   ```powershell
   flutter devices
   ```

### Step 3: Run the Game

```powershell
flutter run
```

If you have multiple devices, specify one:
```powershell
flutter run -d <device-id>
```

## Common Commands

```powershell
# Run the app
flutter run

# Run with debug info
flutter run -v

# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Build for Web
flutter build web

# Clean project
flutter clean

# Get dependencies
flutter pub get

# Analyze code
flutter analyze

# Run tests
flutter test
```

## Project Tree

```
battle-card-game/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── battle_state.dart
│   │   ├── card.dart
│   │   └── player.dart
│   └── screens/
│       ├── battle_screen.dart
│       ├── card_widget.dart
│       └── home_screen.dart
├── pubspec.yaml
├── README.md
├── GETTING_STARTED.md
└── LICENSE
```

## File Descriptions

### Models
- **card.dart** - Card class with type system and damage calculations
- **player.dart** - Player class managing deck and score
- **battle_state.dart** - Game state and battle logic

### Screens
- **home_screen.dart** - Main menu screen
- **battle_screen.dart** - Battle arena with UI
- **card_widget.dart** - Reusable card display component

## Game Files Explained

### 1. Card Model [lib/models/card.dart](lib/models/card.dart)
- Defines card attributes (HP, Attack, Defense)
- Implements type system
- Calculates damage with formulas
- Manages type advantages

### 2. Player Model [lib/models/player.dart](lib/models/player.dart)
- Manages player deck
- Tracks score
- Handles card drawing

### 3. Battle State [lib/models/battle_state.dart](lib/models/battle_state.dart)
- Core game logic
- Turn management
- Card generation (8 cards)
- Battle resolution

### 4. Home Screen [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
- Welcome screen
- Game information
- Start battle button

### 5. Battle Screen [lib/screens/battle_screen.dart](lib/screens/battle_screen.dart)
- Main game UI
- Card display
- Move buttons
- Battle log
- AI opponent logic

### 6. Card Widget [lib/screens/card_widget.dart](lib/screens/card_widget.dart)
- Beautiful card rendering
- Type-based colorization
- Stat display
- Reusable component

## Troubleshooting

### Issue: Flutter command not found
**Solution:** Add Flutter to PATH or use full path to flutter.exe

### Issue: Device not found
```powershell
flutter devices  # List available devices
flutter emulators  # List emulators
flutter emulators --launch <emulator_id>  # Launch emulator
```

### Issue: Build fails
```powershell
flutter clean
flutter pub get
flutter run
```

### Issue: Getting error about missing dependencies
```powershell
flutter pub upgrade
flutter pub get
```

## Code Modification Tips

### Adding New Cards
Edit [lib/models/battle_state.dart](lib/models/battle_state.dart), method `_generateSampleCards()`:

```dart
Card(
  id: '9',
  name: 'New Card',
  type: 'fire',  // fire, water, grass, electric
  hp: 120,
  attack: 100,
  defense: 80,
  description: 'Your description here',
),
```

### Changing Colors
- Home: Modify gradients in [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
- Battle: Modify colors in [lib/screens/battle_screen.dart](lib/screens/battle_screen.dart)
- Cards: Modify type colors in [lib/models/card.dart](lib/models/card.dart)

### Adjusting Game Balance
Edit [lib/models/battle_state.dart](lib/models/battle_state.dart):
- `attack()` method - change damage multipliers
- `_generateSampleCards()` - change card stats

## Next Steps

1. ✅ Install Flutter
2. ✅ Run `flutter pub get`
3. ✅ Run `flutter run`
4. 🎮 Start battling!
5. 🎨 Customize cards and colors
6. 📱 Build for your device

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design](https://material.io/design)
- [Flutter Packages](https://pub.dev)

---

**Happy gaming! 🎮**
