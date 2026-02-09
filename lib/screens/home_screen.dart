import 'package:flutter/material.dart';
import 'battle_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.blue.shade600],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              // Game Title
              const Text(
                'Battle Card Game',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Challenge opponents with your card deck!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 80),
              
              // Game Info
              Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white30),
                ),
                child: Column(
                  children: const [
                    Text(
                      '🎮 Game Features',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '• 8 unique cards with different types\n'
                      '• Type advantage system (Fire > Grass > Water > Electric)\n'
                      '• Strategic card management\n'
                      '• Real-time battle log\n'
                      '• Score tracking system',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Start Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BattleScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Start Battle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: const [
                    Text(
                      'Made with Flutter',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '© 2026 Battle Card Game',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
