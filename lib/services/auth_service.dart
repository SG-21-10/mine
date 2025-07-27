import '../models/user.dart';
import '../utils/validators.dart';

class AuthService {
  // Mock user database
  static final List<Map<String, dynamic>> _users = [];

  Future<User?> signUp(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Validate inputs
    if (!Validators.isValidEmail(email)) {
      throw Exception('Please enter a valid email address');
    }

    if (!Validators.isValidPassword(password)) {
      throw Exception('Password must be at least 8 characters with uppercase, lowercase, and number');
    }

    if (name.trim().isEmpty) {
      throw Exception('Name cannot be empty');
    }

    // Check if user already exists
    final existingUser = _users.firstWhere(
      (user) => user['email'] == email,
      orElse: () => {},
    );

    if (existingUser.isNotEmpty) {
      throw Exception('User with this email already exists');
    }

    // Create new user
    final userData = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name.trim(),
      'email': email.toLowerCase(),
      'password': password, // In real app, this should be hashed
      'createdAt': DateTime.now().toIso8601String(),
    };

    _users.add(userData);

    return User(
      id: userData['id'],
      email: userData['email'],
      name: userData['name'],
      createdAt: DateTime.parse(userData['createdAt']),
    );
  }

  Future<User?> signIn(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Validate inputs
    if (!Validators.isValidEmail(email)) {
      throw Exception('Please enter a valid email address');
    }

    if (password.isEmpty) {
      throw Exception('Please enter your password');
    }

    // Find user
    final userData = _users.firstWhere(
      (user) => user['email'] == email.toLowerCase() && user['password'] == password,
      orElse: () => {},
    );

    if (userData.isEmpty) {
      throw Exception('Invalid email or password');
    }

    return User(
      id: userData['id'],
      email: userData['email'],
      name: userData['name'],
      createdAt: DateTime.parse(userData['createdAt']),
    );
  }
}