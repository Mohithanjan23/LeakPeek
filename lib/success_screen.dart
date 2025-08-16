import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background color (white)
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Success Icon
              Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Icon(Icons.check, size: 70, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Success Message
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
                'Your Account has been Created.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 40),

              // Next Button
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to the next step in the flow (e.g., profile setup)
                  Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  ); // Example navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
