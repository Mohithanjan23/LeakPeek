import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SidebarDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF6B46C1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF553C9A),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF6B46C1),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _auth.currentUser?.email ?? 'User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            _buildMenuItem(Icons.dashboard, 'Dashboard', () {
              Navigator.pushNamed(context, '/dashboard');
            }),
            _buildMenuItem(Icons.search, 'Search', () {
              Navigator.pushNamed(context, '/home');
            }),
            _buildMenuItem(Icons.history, 'History', () {
              // Navigate to history screen
            }),
            _buildMenuItem(Icons.security, 'Security', () {
              // Navigate to security screen
            }),
            _buildMenuItem(Icons.settings, 'Settings', () {
              // Navigate to settings screen
            }),
            Divider(color: Colors.white30),
            _buildMenuItem(Icons.logout, 'Logout', () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/signin');
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
