class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePassword(
    String? value, {
    bool requireDigit = true,
    bool requireLowercase = true,
    bool requireUppercase = true,
    bool requireNonAlphanumeric = true,
    int requiredLength = 6,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < requiredLength) {
      return 'Password must be at least $requiredLength characters';
    }

    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireNonAlphanumeric && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateTenantName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tenant name is required';
    }

    if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
      return 'Tenant name must start with a letter';
    }

    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9-]*$').hasMatch(value)) {
      return 'Tenant name can only contain letters, numbers, and dashes';
    }

    return null;
  }

  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters';
    }

    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    return null;
  }

  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
