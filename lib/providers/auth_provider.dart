import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  final AuthService _authService = AuthService();

  AuthProvider() {
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userEmail = prefs.getString('user_email');
      final userName = prefs.getString('user_name');
      final userId = prefs.getString('user_id');
      
      if (userEmail != null && userName != null && userId != null) {
        _user = User(
          id: userId,
          email: userEmail,
          name: userName,
          createdAt: DateTime.now(),
        );
      }
    } catch (e) {
      _errorMessage = 'Failed to check authentication state';
    }
    _setLoading(false);
  }

  Future<bool> signUp(String name, String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final user = await _authService.signUp(name, email, password);
      if (user != null) {
        _user = user;
        await _saveUserToPrefs(user);
        _setLoading(false);
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _setLoading(false);
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        _user = user;
        await _saveUserToPrefs(user);
        _setLoading(false);
        return true;
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    
    _setLoading(false);
    return false;
  }

  Future<void> signOut() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> _saveUserToPrefs(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_id', user.id);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}