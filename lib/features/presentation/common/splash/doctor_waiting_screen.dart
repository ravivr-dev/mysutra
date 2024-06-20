import 'package:flutter/material.dart';

class DoctorsWaitingRoute extends StatelessWidget {
  const DoctorsWaitingRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Waiting For Verification",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
