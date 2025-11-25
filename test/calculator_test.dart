import 'package:flutter_test/flutter_test.dart';
import 'package:testing_debugging_flutter_lab/src/calculator.dart';

void main() {
  group('Calculator.add', () {
    test('adds positive numbers', () {
      // Arrange
      final calc = Calculator();
      // Act
      final result = calc.add(2, 3);
      // Assert
      expect(result, 5);
    });

    test('adds negative numbers', () {
      final calc = Calculator();
      expect(calc.add(-2, -3), -5);
    });

    test('adds zero correctly', () {
      final calc = Calculator();
      expect(calc.add(0, 5), 5);
      expect(calc.add(0, 0), 0);
    });

    test('mixed sign', () {
      final calc = Calculator();
      expect(calc.add(-2, 5), 3);
    });
  });
}
