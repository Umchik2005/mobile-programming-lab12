import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_debugging_flutter_lab/src/login_screen.dart';
import 'package:testing_debugging_flutter_lab/src/auth_service.dart';

class _FakeAuth implements AuthService {
  @override
  Future<bool> signIn(String email, String password) async => true;
}

void main() {
  testWidgets('Login form validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen(authService: _FakeAuth())));

    final emailField = find.byKey(const Key('emailField'));
    final passField = find.byKey(const Key('passwordField'));
    final submit = find.byKey(const Key('submitButton'));

    expect(emailField, findsOneWidget);
    expect(passField, findsOneWidget);
    expect(submit, findsOneWidget);

    // Initially empty -> button should be disabled
    final ElevatedButton btn = tester.widget<ElevatedButton>(submit);
    expect(btn.onPressed, isNull);

    // Enter invalid email
    await tester.enterText(emailField, 'not-an-email');
    await tester.enterText(passField, '');
    await tester.pump();
    // Still invalid
    final ElevatedButton btnStill = tester.widget<ElevatedButton>(submit);
    expect(btnStill.onPressed, isNull);

    // Enter valid inputs
    await tester.enterText(emailField, 'a@b.com');
    await tester.enterText(passField, 'password');
    await tester.pump();
    // Now button should be enabled
    final ElevatedButton btn2 = tester.widget<ElevatedButton>(submit);
    expect(btn2.onPressed, isNotNull);
  });
}
