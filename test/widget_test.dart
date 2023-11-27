// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/main.dart'; // Import your main.dart file or the appropriate file where LoginPage is defined

void main() {
  testWidgets('Login Page UI Test', (WidgetTester tester) async {
    // Build your app and trigger a frame.
    await tester.pumpWidget(const MyApp(token: '',)); // Use MyApp() to wrap your LoginPage

    // Verify that your widgets are correctly displayed and interacted with.
    expect(find.text("Let's sign in with your TOY BOT account"), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Additional Element 1'), findsOneWidget);
    expect(find.text('Additional Element 2'), findsOneWidget);

    // Perform interactions and verify changes (if any).
    // For example, you can simulate tapping on buttons or filling in text fields here.

    // For now, let's just verify the initial state.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
  });
}
