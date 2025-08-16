import 'package:flutter/material.dart';

import 'dblink.dart'; // Import your DBLProvider
import 'profile_registration_screen.dart';
import 'results_screen.dart'; // Import your ResultsScreen

// Main screen that holds the Scaffold and connects the HomePage and the Drawer.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const Color backgroundColor = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'HOME PAGE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const _AppDrawer(), // The custom drawer widget
      body: const _HomePage(), // The custom home page widget
    );
  }
}

// -----------------------------------------------------------------------------
// The UI for the main content area (the "HOME PAGE" design)
// CONVERTED TO A STATEFUL WIDGET
// -----------------------------------------------------------------------------
class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final _searchController = TextEditingController();
  final _dblink = DBLProvider();

  static const Color primaryColor = Color(0xFF4A148C);
  static const Color lightTextColor = Colors.white70;

  Future<void> _performBreachCheck() async {
    if (_searchController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enter an email or mobile number."),
        ),
      );
      return;
    }

    // Navigate to the loading screen
    Navigator.pushNamed(context, '/breaching');

    try {
      // --- IMPORTANT ---
      // TODO: You need to create a function in dblink.dart called 'checkBreach'
      // final results = await _dblink.checkBreach(_searchController.text);

      // For now, we will simulate a 2-second delay and create mock data
      await Future.delayed(const Duration(seconds: 2));

      // Mock data - replace with 'results' from your actual API call
      List<BreachData> mockResults = [
        BreachData(
          title: "Major Site Breach",
          description: "Your password and email were found.",
        ),
        BreachData(
          title: "Another Platform Leak",
          description: "Your username was exposed.",
        ),
      ];

      if (mounted) {
        // Remove the loading screen and push the results screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(breaches: mockResults),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // If there's an error, pop the loading screen and show a message
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('An error occurred: $e'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor, width: 2),
              ),
              child: const Icon(Icons.search, color: primaryColor, size: 70),
            ),
            const SizedBox(height: 30),
            const Text(
              'Check if your data has breached',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                labelText: 'EMAIL/MOBILE NUMBER',
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
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _performBreachCheck,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'BREACH',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Using LEAKPEEK is subject to its terms of use.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// The _AppDrawer widget remains the same as before...
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  static const Color drawerColor = Color(0xFFC5CAE9);
  static const Color drawerTextColor = Color(0xFF311B92);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDrawerHeader(context),
          _buildDrawerItem(icon: Icons.shield_outlined, text: 'Breaching'),
          _buildDrawerItem(icon: Icons.list_alt_rounded, text: 'Pastes'),
          _buildDrawerItem(icon: Icons.lock_outline_rounded, text: 'Passwords'),
          _buildDrawerItem(
            icon: Icons.credit_card_rounded,
            text: 'Payment Cards',
          ),
          const Divider(color: drawerTextColor, indent: 16, endIndent: 16),
          _buildDrawerItem(icon: Icons.history, text: 'History'),
          const Spacer(),
          const Divider(color: drawerTextColor, indent: 16, endIndent: 16),
          _buildDrawerItem(
            icon: Icons.logout,
            text: '#LOGOUT',
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: drawerTextColor,
            child: Icon(Icons.person, size: 40, color: drawerColor),
          ),
          const SizedBox(height: 15),
          const Text(
            'USERNAME',
            style: TextStyle(
              color: drawerTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('abc@gmail.com', style: TextStyle(color: drawerTextColor)),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                // Navigate to the profile screen in view mode
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            const ProfileRegistrationScreen(isEditMode: false),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: drawerTextColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Track',
                style: TextStyle(color: drawerTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: drawerTextColor),
      title: Text(
        text,
        style: const TextStyle(
          color: drawerTextColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap ?? () {},
    );
  }
}
