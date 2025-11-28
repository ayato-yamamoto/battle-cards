import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BattleCardApp());
}

class BattleCardApp extends StatelessWidget {
  const BattleCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battle Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
