import 'card.dart';

class Player {
  final String id;
  final String name;
  List<BattleCard> deck;
  BattleCard? activeCard;
  int score;
  int cardsDefeated;

  Player({
    required this.id,
    required this.name,
    required this.deck,
    this.activeCard,
    this.score = 0,
    this.cardsDefeated = 0,
  });

  // Get remaining cards in deck
  int get remainingCards => deck.length;

  // Draw a random card from deck
  BattleCard? drawCard() {
    if (deck.isEmpty) {
      return null;
    }
    final randomIndex = (deck.length * (DateTime.now().millisecondsSinceEpoch % 100) / 100).toInt();
    return deck.removeAt(randomIndex);
  }

  // Set active card for battle
  void setActiveCard(BattleCard card) {
    activeCard = card;
  }

  // Add points
  void addScore(int points) {
    score += points;
  }

  // Count defeated cards
  void cardDefeated() {
    cardsDefeated++;
  }

  // Reset for new game
  void reset() {
    activeCard = null;
    score = 0;
    cardsDefeated = 0;
  }
}
