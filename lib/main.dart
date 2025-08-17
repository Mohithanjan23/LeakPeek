import 'package:flutter/material.dart';

import 'breaching_screen.dart';
import 'confirmation_screen.dart';
import 'dashboard_screen.dart';
import 'email_verification_screen.dart';
import 'initial_screen.dart';
import 'login_screen.dart';
import 'otp_input_screen.dart';
import 'profile_registration_screen.dart';
import 'register_screen.dart';
import 'results_screen.dart'; // Import the results screen
import 'suggestions_screen.dart';
import 'upload_picture_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeakPeek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        primaryColor: const Color(0xFF4A148C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',

      // Define all the named routes for clean navigation
      routes: {
        '/': (context) => const InitialScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const RegisterScreen(),
        '/email-verification': (context) => const EmailVerificationScreen(),

        // UPDATED: This route now correctly handles the email argument
        '/otp': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String;
          return OtpInputScreen(email: email);
        },

        '/confirmation': (context) => const ConfirmationScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile-setup': (context) => const ProfileRegistrationScreen(),
        '/upload-picture': (context) => const UploadPictureScreen(),
        '/breaching': (context) => const BreachingScreen(),

        // ADDED: A route for the results screen that can handle arguments
        '/results': (context) {
          final breaches =
              ModalRoute.of(context)!.settings.arguments as List<BreachData>;
          return ResultsScreen(breaches: breaches);
        },

        '/suggestions': (context) => const SuggestionsScreen(),
      },
    );
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp();
      print('Firebase initialized successfully');
    } catch (e) {
      print('Firebase initialization error: $e');
    }

    runApp(LeakPeekApp());
  }
}
