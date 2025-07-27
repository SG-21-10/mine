import '../models/user.dart';

class AuthService {
  // Mock user database
  static final List<User> _users = [
    User(id: '1', email: 'admin@example.com', name: 'Admin User'),
    User(id: '2', email: 'user@example.com', name: 'Demo User'),
  ];

  // Mock passwords (in real app, these would be hashed)
  static final Map<String, String> _passwords = {
    'admin@example.com': 'admin123',
    'user@example.com': 'user123',
  };

  Future<User?> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (_passwords.containsKey(email) && _passwords[email] == password) {
      return _users.firstWhere((user) => user.email == email);
    }
    return null;
  }

  Future<User?> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Check if user already exists
    if (_users.any((user) => user.email == email)) {
      throw Exception('User already exists');
    }

    // Create new user
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
    );

    _users.add(newUser);
    _passwords[email] = password;

    return newUser;
  }

  Future<void> logout() async {
    // Perform any logout cleanup here
    await Future.delayed(const Duration(milliseconds: 500));
  }
}