import 'package:flutter/material.dart';
import '../models/battle_state.dart';
import '../models/player.dart';
import 'card_widget.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({Key? key}) : super(key: key);

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> with TickerProviderStateMixin {
  late BattleState battleState;
  late AnimationController _shakeController;
  late AnimationController _logAnimationController;

  @override
  void initState() {
    super.initState();
    final player1 = Player(id: '1', name: 'Player 1', deck: []);
    final player2 = Player(id: '2', name: 'AI Opponent', deck: []);
    battleState = BattleState(player1: player1, player2: player2);
    
    // Shake animation for damage feedback
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Battle log fade/slide animation
    _logAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _logAnimationController.dispose();
    super.dispose();
  }

  void _handleAttack(String moveType) {
    if (battleState.isBattleOver) return;

    setState(() {
      battleState.attack(moveType);
      _shakeController.forward().then((_) => _shakeController.reverse());
      _logAnimationController.forward(from: 0.0);
      
      // AI makes automatic move after short delay
      if (!battleState.isBattleOver) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && !battleState.isBattleOver) {
            setState(() {
              final moves = ['quick', 'special', 'defense'];
              final randomMove = moves[(DateTime.now().millisecondsSinceEpoch % 3).toInt()];
              battleState.attack(randomMove);
              _shakeController.forward().then((_) => _shakeController.reverse());
              _logAnimationController.forward(from: 0.0);
            });
          }
        });
      }
    });
  }

  void _resetGame() {
    setState(() {
      battleState.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = battleState.getCurrentBattleState();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle Arena'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade900, Colors.blue.shade900],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Score Board
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildScoreCard(
                      state['currentPlayerName'],
                      state['currentPlayerScore'],
                      Colors.green,
                    ),
                    const Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    _buildScoreCard(
                      state['opponentName'],
                      state['opponentScore'],
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Opponent Card
                if (state['opponentCard'] != null)
                  Column(
                    children: [
                      const Text(
                        'Opponent',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CardWidget(card: state['opponentCard']),
                    ],
                  )
                else
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: const Center(
                      child: Text(
                        'No Card',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                // Battle Log with fade and scale animation
                ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0)
                      .animate(CurvedAnimation(parent: _logAnimationController, curve: Curves.elasticOut)),
                  child: FadeTransition(
                    opacity: _logAnimationController,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Text(
                        state['battleLog'] ?? 'Battle started! Ready to fight?',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Player Card
                if (state['currentPlayerCard'] != null)
                  Column(
                    children: [
                      const Text(
                        'Your Card',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CardWidget(card: state['currentPlayerCard']),
                    ],
                  )
                else
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: const Center(
                      child: Text(
                        'No Card',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                // Action Buttons
                if (!battleState.isBattleOver)
                  Column(
                    children: [
                      const Text(
                        'Select Your Move',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              'Quick Attack',
                              Icons.flash_on,
                              Colors.yellow,
                              () => _handleAttack('quick'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildActionButton(
                              'Special Attack',
                              Icons.bolt,
                              Colors.orange,
                              () => _handleAttack('special'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildActionButton(
                              'Defend',
                              Icons.shield,
                              Colors.blue,
                              () => _handleAttack('defense'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${state['winner']} Wins!',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Final Score: ${state['currentPlayerScore']}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _resetGame,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          'Play Again',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(String name, int score, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$score pts',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return _AnimatedActionButton(
      label: label,
      icon: icon,
      color: color,
      onPressed: onPressed,
    );
  }
}

class _AnimatedActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _AnimatedActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  State<_AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<_AnimatedActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _pressAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _pressAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _pressController.forward().then((_) => _pressController.reverse());
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pressAnimation,
      child: ElevatedButton(
        onPressed: _handlePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Icon(widget.icon, color: Colors.white, size: 24),
            const SizedBox(height: 5),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
