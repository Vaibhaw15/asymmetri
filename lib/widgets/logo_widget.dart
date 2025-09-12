import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        'assets/images/logo.jpg',
        height: 60,
        width: 280,
        fit: BoxFit.fitWidth,
        errorBuilder: (context, error, stackTrace) {
          return const Text(
            'ASYMMETRI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          );
        },
      ),
    );
  }
}
