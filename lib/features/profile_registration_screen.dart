import 'dart:io'; // Required for using the File class

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the package

import 'dblink.dart'; // Import your DBLProvider
import 'upload_picture_screen.dart'; // Import for navigation

class ProfileRegistrationScreen extends StatefulWidget {
  final bool isEditMode;

  const ProfileRegistrationScreen({super.key, this.isEditMode = true});

  @override
  State<ProfileRegistrationScreen> createState() =>
      _ProfileRegistrationScreenState();
}

class _ProfileRegistrationScreenState extends State<ProfileRegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityCountryController = TextEditingController();

  final _dblink = DBLProvider();
  bool _isLoading = false;
  File? _image; // State variable to hold the selected image file

  static const Color primaryColor = Color(0xFF4A148C);
  static const Color backgroundColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Colors.white70;

  // --- NEW FUNCTION to handle image picking ---
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image from the gallery
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isEditMode) {
      // TODO: If viewing an existing profile, load data and image URL here.
    }
  }

  Future<void> _saveProfile() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Create a new function in dblink.dart, like 'updateProfile',
      // that takes this information AND the image file to save to your backend.
      //
      // Example of what the call might look like:
      // final response = await _dblink.updateProfile(
      //   name: _nameController.text,
      //   ...
      //   profileImage: _image, // Pass the image file
      // );

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UploadPictureScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('An error occurred: $e'),
          ),
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
        title: Text(
          'PROFILE',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              // --- UPDATED to be tappable ---
              child: GestureDetector(
                onTap: _pickImage, // Call the image picker function
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: primaryColor,
                      // --- UPDATED to show the selected image ---
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child:
                          _image == null
                              ? const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.white,
                              )
                              : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add_circle,
                            color: primaryColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            _buildTextField(controller: _nameController, labelText: 'NAME'),
            const SizedBox(height: 16.0),
            _buildTextField(controller: _dobController, labelText: 'D.O.B'),
            const SizedBox(height: 16.0),
            _buildTextField(controller: _genderController, labelText: 'GENDER'),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: _mobileNumberController,
              labelText: 'MOBILE NUMBER',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: _emailController,
              labelText: 'EMAIL ADDRESS',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            _buildTextField(
              controller: _cityCountryController,
              labelText: 'CITY,COUNTRY',
            ),
            const SizedBox(height: 40.0),
            if (widget.isEditMode)
              _buildButton(text: 'NEXT', onPressed: _saveProfile)
            else
              _buildButton(
                text: 'DONE',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child:
          _isLoading
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
              : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
