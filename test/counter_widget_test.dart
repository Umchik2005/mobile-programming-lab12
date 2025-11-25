import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_debugging_flutter_lab/src/counter_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CounterScreen()));

    expect(find.text('0'), findsOneWidget);
    final fab = find.byKey(const Key('incrementFab'));
    expect(fab, findsOneWidget);

    await tester.tap(fab);
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
