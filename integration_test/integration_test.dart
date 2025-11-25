import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_debugging_flutter_lab/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('sign-in flow integration test', (WidgetTester tester) async {
    // Start app at the login route
    await tester.pumpWidget(const MyApp(initialRoute: '/login'));
    await tester.pumpAndSettle();

    final email = find.byKey(const Key('emailField'));
    final pass = find.byKey(const Key('passwordField'));
    final submit = find.byKey(const Key('submitButton'));

    expect(email, findsOneWidget);
    expect(pass, findsOneWidget);
    expect(submit, findsOneWidget);

    await tester.enterText(email, 'user@example.com');
    await tester.enterText(pass, 'password');
    await tester.pumpAndSettle();

    // Tap submit
    await tester.tap(submit);
    await tester.pumpAndSettle();

    // After successful sign-in the app routes to '/'
    expect(find.text('0'), findsOneWidget);
  });
}
