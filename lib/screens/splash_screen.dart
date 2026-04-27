// This handles the optional bonus challenge.
// It shows a welcoming UI for 3 seconds before automatically routing to the main app.

import 'dart:async';
import 'package:flutter/material.dart';
import 'task_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // --> Timer to hold the splash screen for 3 seconds, then navigate
    Timer(const Duration(seconds: 3), () {
      // --> pushReplacement removes the splash screen from the back history
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TaskHomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.task_alt, size: 100, color: Colors.white),
            Container(height: 21), // --> Reusing your spacing pattern
            const Text(
              "Taskify",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(color: Colors.white), // --> Loading animation
          ],
        ),
      ),
    );
  }
}
