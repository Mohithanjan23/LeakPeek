import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ), // Adjusted back arrow color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.black87, // Adjusted title color
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Email Address TextField
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.black,
              ), // Adjusted text color
              decoration: InputDecoration(
                labelText: 'EMAIL ADDRESS',
                labelStyle: const TextStyle(
                  color: Colors.black54,
                ), // Adjusted label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.black38,
                  ), // Adjusted border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Mobile Number TextField
            TextFormField(
              controller: _mobileNumberController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: Colors.black,
              ), // Adjusted text color
              decoration: InputDecoration(
                labelText: 'MOBILE NUMBER',
                labelStyle: const TextStyle(
                  color: Colors.black54,
                ), // Adjusted label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.black38,
                  ), // Adjusted border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password TextField
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(
                color: Colors.black,
              ), // Adjusted text color
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: const TextStyle(
                  color: Colors.black54,
                ), // Adjusted label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.black38,
                  ), // Adjusted border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black54, // Adjusted icon color
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password TextField
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              style: const TextStyle(
                color: Colors.black,
              ), // Adjusted text color
              decoration: InputDecoration(
                labelText: 'CONFIRM PASSWORD',
                labelStyle: const TextStyle(
                  color: Colors.black54,
                ), // Adjusted label color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.black38,
                  ), // Adjusted border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black54, // Adjusted icon color
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Terms and Condition Checkbox
            Row(
              children: <Widget>[
                Checkbox(
                  value: _termsAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      _termsAgreed = value!;
                    });
                  },
                  activeColor: Colors.purple,
                  checkColor: Colors.white,
                ),
                const Text(
                  'I agree to terms and condition',
                  style: TextStyle(
                    color: Colors.black87,
                  ), // Adjusted text color
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Sign Up Button
            ElevatedButton(
              onPressed:
                  _termsAgreed
                      ? () {
                        // TODO: Implement sign-up logic using dblink.dart
                        if (kDebugMode) {
                          print('Sign Up button pressed');
                        }
                        if (kDebugMode) {
                          print('Email: ${_emailController.text}');
                        }
                        if (kDebugMode) {
                          print('Mobile: ${_mobileNumberController.text}');
                        }
                        if (kDebugMode) {
                          print('Password: ${_passwordController.text}');
                        }
                        if (kDebugMode) {
                          print(
                            'Confirm Password: ${_confirmPasswordController.text}',
                          );
                        }
                        // After successful sign-up, you might navigate to the OTP verification screen
                        // Navigator.pushNamed(context, '/email_verification');
                      }
                      : null, // Disable button if terms are not agreed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            // Already have an account? Sign In
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                    ), // Adjusted text color
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the login screen
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
