import 'dart:math';

class Card {
  final String id;
  final String name;
  final String type; // fire, water, grass, electric
  final int hp;
  final int attack;
  final int defense;
  final String description;

  Card({
    required this.id,
    required this.name,
    required this.type,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.description,
  });

  // Get card color based on type
  String getTypeColor() {
    switch (type.toLowerCase()) {
      case 'fire':
        return 'FF6B35';
      case 'water':
        return '004E89';
      case 'grass':
        return '2ECC71';
      case 'electric':
        return 'F1C40F';
      default:
        return '95A5A6';
    }
  }

  // Calculate damage based on attack and defense
  static int calculateDamage(Card attacker, Card defender) {
    final baseDamage = attacker.attack;
    final defenseFactor = 1 - (defender.defense / 100);
    final variance = Random().nextDouble() * 0.2 - 0.1; // ±10%
    
    return (baseDamage * defenseFactor * (1 + variance)).toInt();
  }

  // Check type advantage
  static double getTypeAdvantage(String attackerType, String defenderType) {
    if (attackerType == defenderType) return 1.0;
    
    if (attackerType == 'fire' && defenderType == 'grass') return 1.5;
    if (attackerType == 'fire' && defenderType == 'water') return 0.5;
    if (attackerType == 'water' && defenderType == 'fire') return 1.5;
    if (attackerType == 'water' && defenderType == 'electric') return 1.5;
    if (attackerType == 'grass' && defenderType == 'water') return 1.5;
    if (attackerType == 'grass' && defenderType == 'fire') return 0.5;
    if (attackerType == 'electric' && defenderType == 'water') return 1.5;
    if (attackerType == 'electric' && defenderType == 'grass') return 0.5;
    
    return 1.0;
  }

  // Get available moves
  List<String> getAvailableMoves() {
    return [
      'Quick Attack',
      'Special Attack',
      'Defense Stance',
    ];
  }
}
