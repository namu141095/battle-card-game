import 'card.dart';
import 'player.dart';

class BattleState {
  final Player player1;
  final Player player2;
  late Player currentPlayer;
  late Player opponent;
  String? battleLog;
  bool isBattleOver = false;
  Player? winner;

  BattleState({
    required this.player1,
    required this.player2,
  }) {
    currentPlayer = player1;
    opponent = player2;
    
    // Initialize decks
    _initializeDecks();
    
    // Draw first cards
    drawFirstCards();
  }

  void _initializeDecks() {
    final cards = _generateSampleCards();
    
    // Distribute cards evenly
    for (int i = 0; i < cards.length; i++) {
      if (i % 2 == 0) {
        player1.deck.add(cards[i]);
      } else {
        player2.deck.add(cards[i]);
      }
    }
  }

  List<Card> _generateSampleCards() {
    return [
      Card(
        id: '1',
        name: 'Blaze Dragon',
        type: 'fire',
        hp: 120,
        attack: 95,
        defense: 80,
        description: 'A powerful fire dragon with devastating attacks',
      ),
      Card(
        id: '2',
        name: 'Wave Guardian',
        type: 'water',
        hp: 110,
        attack: 85,
        defense: 90,
        description: 'Masters of water with strong defense',
      ),
      Card(
        id: '3',
        name: 'Forest Protector',
        type: 'grass',
        hp: 100,
        attack: 88,
        defense: 85,
        description: 'Nature guardian with balanced stats',
      ),
      Card(
        id: '4',
        name: 'Thunder Beast',
        type: 'electric',
        hp: 95,
        attack: 105,
        defense: 70,
        description: 'Fastest attacker with high power',
      ),
      Card(
        id: '5',
        name: 'Inferno Salamander',
        type: 'fire',
        hp: 115,
        attack: 100,
        defense: 75,
        description: 'Ancient fire spirit with great strength',
      ),
      Card(
        id: '6',
        name: 'Tidal Leviathan',
        type: 'water',
        hp: 125,
        attack: 80,
        defense: 95,
        description: 'Largest water creature, very defensive',
      ),
      Card(
        id: '7',
        name: 'Verdant Golem',
        type: 'grass',
        hp: 130,
        attack: 75,
        defense: 100,
        description: 'Stone-like grass creature with high defense',
      ),
      Card(
        id: '8',
        name: 'Volt Phoenix',
        type: 'electric',
        hp: 105,
        attack: 110,
        defense: 65,
        description: 'Swift electric bird with piercing attacks',
      ),
    ];
  }

  void drawFirstCards() {
    final card1 = player1.drawCard();
    final card2 = player2.drawCard();
    
    if (card1 != null) {
      player1.setActiveCard(card1);
    }
    if (card2 != null) {
      player2.setActiveCard(card2);
    }
  }

  void switchPlayer() {
    final temp = currentPlayer;
    currentPlayer = opponent;
    opponent = temp;
  }

  void attack(String moveType) {
    if (currentPlayer.activeCard == null || opponent.activeCard == null) {
      battleLog = 'No cards in play!';
      return;
    }

    final attacker = currentPlayer.activeCard!;
    final defender = opponent.activeCard!;

    // Calculate damage
    int damage = Card.calculateDamage(attacker, defender);
    
    // Apply type advantage
    final typeAdvantage = Card.getTypeAdvantage(attacker.type, defender.type);
    damage = (damage * typeAdvantage).toInt();

    // Apply move modifier
    switch (moveType) {
      case 'quick':
        damage = (damage * 0.8).toInt();
        break;
      case 'special':
        damage = (damage * 1.5).toInt();
        break;
      case 'defense':
        damage = (damage * 0.3).toInt();
        break;
    }

    // Update defender HP
    int currentHp = defender.hp;
    currentHp -= damage;

    // Check if defender is defeated
    if (currentHp <= 0) {
      battleLog = '${attacker.name} defeated ${defender.name}!\n${currentPlayer.name} earned 10 points!';
      currentPlayer.addScore(10);
      currentPlayer.cardDefeated();
      opponent.activeCard = null;
      
      // Try to draw new card
      final newCard = opponent.drawCard();
      if (newCard != null) {
        opponent.setActiveCard(newCard);
      } else {
        isBattleOver = true;
        winner = currentPlayer;
        battleLog = '${currentPlayer.name} wins the battle!';
      }
    } else {
      battleLog = '${attacker.name} attacks ${defender.name} for $damage damage!\n${defender.name} HP: $currentHp/${defender.hp}';
    }

    switchPlayer();
  }

  void reset() {
    currentPlayer = player1;
    opponent = player2;
    isBattleOver = false;
    winner = null;
    battleLog = null;
    player1.reset();
    player2.reset();
    player1.deck.clear();
    player2.deck.clear();
    _initializeDecks();
    drawFirstCards();
  }

  Map<String, dynamic> getCurrentBattleState() {
    return {
      'currentPlayerName': currentPlayer.name,
      'currentPlayerCard': currentPlayer.activeCard,
      'opponentName': opponent.name,
      'opponentCard': opponent.activeCard,
      'battleLog': battleLog,
      'isBattleOver': isBattleOver,
      'winner': winner?.name,
      'currentPlayerScore': currentPlayer.score,
      'opponentScore': opponent.score,
    };
  }
}
