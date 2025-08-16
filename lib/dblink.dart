import 'dart:convert';
import 'dart:io'; // Required for File

import 'package:http/http.dart' as http;

class DBLProvider {
  // IMPORTANT: Replace this with the actual URL of your deployed backend API.
  final String _baseUrl = 'YOUR_API_BASE_URL';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: {'email': email, 'password': password},
      );
      return _handleResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to connect to the server'};
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String mobileNumber,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        body: {
          'email': email,
          'password': password,
          'mobile_number': mobileNumber,
        },
      );
      return _handleResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to connect to the server'};
    }
  }

  // --- NEW FUNCTION for the home screen ---
  Future<Map<String, dynamic>> checkBreach(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/check-breach'),
        body: {'query': query},
      );
      return _handleResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to connect to the server'};
    }
  }

  // --- NEW FUNCTION for the profile screen (with image upload) ---
  Future<Map<String, dynamic>> updateProfile(
    Map<String, String> profileData,
    File? imageFile,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/update-profile'),
      );
      // Add text fields
      request.fields.addAll(profileData);

      // Add image file if it exists
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to connect to the server'};
    }
  }

  // --- NEW FUNCTION for sending verification email ---
  Future<Map<String, dynamic>> sendVerificationEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/send-otp'),
        body: {'email': email},
      );
      return _handleResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to connect to the server'};
    }
  }

  // --- NEW FUNCTION for verifying OTP ---
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/verify-otp'),
        body: {'email': email, 'otp': otp},
      );
      return _handleResponse(response);
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to connect to the server'};
    }
  }

  // Helper function to handle the HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final decodedResponse = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decodedResponse;
      } else {
        return {
          'status': 'error',
          'message': decodedResponse['message'] ?? 'An error occurred',
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Failed to decode response'};
    }
  }
}
