import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'Please enter a valid number';
    }
    if (quantity <= 0) {
      return 'Quantity must be greater than 0';
    }
    if (quantity > 999) {
      return 'Quantity cannot exceed 999';
    }
    return null;
  }

  static String? validateDiscount(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Discount is optional
    }
    final discount = double.tryParse(value);
    if (discount == null) {
      return 'Please enter a valid number';
    }
    if (discount < 0) {
      return 'Discount cannot be negative';
    }
    if (discount > 100) {
      return 'Discount cannot exceed 100%';
    }
    return null;
  }

  static String? validateTax(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Tax is optional
    }
    final tax = double.tryParse(value);
    if (tax == null) {
      return 'Please enter a valid number';
    }
    if (tax < 0) {
      return 'Tax cannot be negative';
    }
    if (tax > 100) {
      return 'Tax cannot exceed 100%';
    }
    return null;
  }
}