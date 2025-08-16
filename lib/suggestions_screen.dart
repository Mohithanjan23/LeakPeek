import 'package:flutter/material.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  // Define the core colors from your design for consistency
  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'SUGGESTION',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Custom Icon Container
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: const Icon(
                Icons.policy_outlined,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            // Title
            const Text(
              'Suggestion',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Detailed Text Block
            const Text(
              'THE DIGITAL PERSONAL DATA PROTECTION ACT, 2023\n\n'
              'An Act to provide for the processing of digital personal data in a manner '
              'that recognizes both the right of individuals to protect their '
              'personal data and the\n'
              'need to process such personal data for lawful '
              'purposes and for matters\n'
              'connected therewith or incidental thereto.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: lightTextColor,
                fontSize: 16,
                height: 1.5, // Improves readability for blocks of text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
