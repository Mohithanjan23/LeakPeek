import 'package:flutter/material.dart';

class BreachingScreen extends StatelessWidget {
  const BreachingScreen({super.key});

  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                strokeWidth: 6.0,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'BREACHING...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
