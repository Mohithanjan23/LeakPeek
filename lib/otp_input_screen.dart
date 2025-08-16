import 'package:flutter/material.dart';

import 'dblink.dart'; // Import your DBLProvider

class OtpInputScreen extends StatefulWidget {
  final String email;
  const OtpInputScreen({super.key, required this.email});

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  final int _otpLength = 5;
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _otpControllers;
  final _dblink = DBLProvider();
  bool _isLoading = false;

  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Colors.white70;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
    _otpControllers = List.generate(_otpLength, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _nextField(String value, int index) {
    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.length == 1 && index == _otpLength - 1) {
      _focusNodes[index].unfocus();
    }
  }

  Future<void> _submitOtp() async {
    if (_isLoading) return;

    final String otp = _otpControllers.map((c) => c.text).join();
    if (otp.length != _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Please fill all the fields.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // --- IMPORTANT ---
      // TODO: You need to create a function in dblink.dart called 'verifyOtp'
      // final response = await _dblink.verifyOtp(widget.email, otp);

      // For now, we will assume the API call was successful and navigate.
      // if (response['status'] == 'success') {
      if (mounted) {
        // Navigate to confirmation and remove all screens behind it
        Navigator.pushNamedAndRemoveUntil(
            context, '/confirmation', (route) => false);
      }
      // } else {
      //   if (mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(backgroundColor: Colors.red, content: Text(response['message'] ?? 'Invalid OTP.')),
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
          onPressed: () => Navigator.pop(context),
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
                child: const Icon(Icons.sms_rounded,
                    size: 60, color: Colors.white),
              ),
              const SizedBox(height: 30),
              const Text(
                'Enter Verification code',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'We sent a verification code to your email\n${widget.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: lightTextColor, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _otpLength,
                  (index) => SizedBox(
                    width: 50,
                    height: 60,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 2.0),
                        ),
                      ),
                      onChanged: (value) {
                        _nextField(value, index);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitOtp,
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
                    : const Text('SUBMIT',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {/* TODO: Implement resend OTP logic */},
                child: const Text('Resend again',
                    style: TextStyle(color: lightTextColor, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
