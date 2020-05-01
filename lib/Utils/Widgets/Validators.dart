class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email cannot be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password cannot be empty' : null;
  }
}

class DisplayNameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'DisplayName cannot be empty' : null;
  }
}