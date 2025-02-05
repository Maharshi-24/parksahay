import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parksahay/auth/auth_gate.dart';
import 'package:parksahay/main.dart'; // Import your main.dart file
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core for initialization

void main() {
  setUpAll(() async {
    // Initialize Firebase before running tests
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "YOUR_API_KEY", // Replace with your Firebase API key
        appId: "YOUR_APP_ID", // Replace with your Firebase App ID
        messagingSenderId: "YOUR_MESSAGING_SENDER_ID", // Replace with your Messaging Sender ID
        projectId: "YOUR_PROJECT_ID", // Replace with your Firebase Project ID
      ),
    );
  });

  testWidgets('Park Sahay App smoke test', (WidgetTester tester) async {
    // Build the ParkSahayApp widget and trigger a frame.
    await tester.pumpWidget(const ParkSahayApp());

    // Verify that the app starts with the AuthGate widget.
    expect(find.byType(AuthGate), findsOneWidget);

    // Optionally, you can add more tests here to verify other widgets or functionality.
  });
}