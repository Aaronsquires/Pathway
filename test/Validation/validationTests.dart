import 'package:flutter_test/flutter_test.dart';
import 'package:pathway/Utils/Widgets/Validators.dart';

void main() {
  test('Email Vailidator', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Email cannot be empty');
  });

  test('Null Email Vailidator', () {
    var result = EmailFieldValidator.validate('');
    expect(result, null);
    
  });

  test('Password Vailidator', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password cannot be empty');
  });
  
  test('Null Password Vailidator', () {
    var result = EmailFieldValidator.validate('');
    expect(result, null);
    
  });

  test('DisplayName Vailidator', () {
    var result = DisplayNameFieldValidator.validate('');
    expect(result, 'DisplayName cannot be empty');
  });
  
  test('Null DisplayName Vailidator', () {
    var result = EmailFieldValidator.validate('');
    expect(result, null);
    
  });
}