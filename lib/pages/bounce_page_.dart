import 'package:flutter/material.dart';

class BouncePage extends StatelessWidget {
  const BouncePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
