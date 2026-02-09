import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BattleCardGameApp());
}

class BattleCardGameApp extends StatelessWidget {
  const BattleCardGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battle Card Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
