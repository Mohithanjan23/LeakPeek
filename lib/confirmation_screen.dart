import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  // Define the core colors from your design for consistency
  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(),
              // Custom Icon Container from Figma
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Confirmation Text
              const Text(
                'Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your Account Has Been Created.',
                textAlign: TextAlign.center,
                style: TextStyle(color: lightTextColor, fontSize: 16),
              ),
              const Spacer(),

              // Next Button
              ElevatedButton(
                onPressed: () {
                  // This should navigate to your main app screen, replacing the entire auth stack.
                  // Example:
                  // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
