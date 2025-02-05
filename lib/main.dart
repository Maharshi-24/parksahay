import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const ParkSahayApp());
}

class ParkSahayApp extends StatelessWidget {
  const ParkSahayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Park Sahay',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: const AuthGate(),
    );
  }
}