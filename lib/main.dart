import 'package:flutter/material.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const YugiohApp());
}

class YugiohApp extends StatelessWidget {
  const YugiohApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yu-Gi-Oh! Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}
