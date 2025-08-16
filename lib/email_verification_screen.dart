import 'package:flutter/material.dart';

import 'dblink.dart'; // Import your DBLProvider

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailController = TextEditingController();
  final _dblink = DBLProvider();
  bool _isRecaptchaChecked = false;
  bool _isLoading = false;

  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Colors.white70;

  Future<void> _sendVerificationCode() async {
    if (_isLoading) return;

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Please enter an email address.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // --- IMPORTANT ---
      // TODO: You need to create a function in dblink.dart called 'sendVerificationEmail'
      // final response = await _dblink.sendVerificationEmail(_emailController.text);

      // For now, we will assume the API call was successful and navigate.
      // if (response['status'] == 'success') {
      if (mounted) {
        Navigator.pushNamed(context, '/otp', arguments: _emailController.text);
      }
      // } else {
      //   if (mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(backgroundColor: Colors.red, content: Text(response['message'] ?? 'Failed to send code.')),
      //     );
      //   }
      // }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text('An error occurred: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: const Icon(Icons.mail_outline,
                    size: 70, color: Colors.white),
              ),
              const SizedBox(height: 30),
              const Text(
                'Enter Your Email Address',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'We will send you a verification code',
                textAlign: TextAlign.center,
                style: TextStyle(color: lightTextColor, fontSize: 16),
              ),
              const SizedBox(height: 40),
              _buildTextField(
                  controller: _emailController, labelText: 'EMAIL ADDRESS'),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey.shade700),
                ),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isRecaptchaChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isRecaptchaChecked = value ?? false;
                        });
                      },
                      activeColor: primaryColor,
                      checkColor: Colors.white,
                      side: const BorderSide(color: lightTextColor),
                    ),
                    const Text("I'm not a robot",
                        style: TextStyle(color: lightTextColor, fontSize: 16)),
                    const Spacer(),
                    Image.asset('assets/recaptcha_logo.png', height: 40),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _sendVerificationCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 3))
                    : const Text('VERIFY',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String labelText}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: lightTextColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
    );
  }
}
