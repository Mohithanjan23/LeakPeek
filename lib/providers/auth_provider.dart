import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _user = _authService.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    UserCredential? result = await _authService.signInWithEmailAndPassword(email, password);

    _isLoading = false;
    notifyListeners();

    return result != null;
  }

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    UserCredential? result = await _authService.registerWithEmailAndPassword(email, password);

    _isLoading = false;
    notifyListeners();

    return result != null;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}