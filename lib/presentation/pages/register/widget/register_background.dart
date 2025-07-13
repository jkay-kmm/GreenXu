import 'package:flutter/material.dart';

class RegisterBackground  extends StatelessWidget {
  const RegisterBackground ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: Color(0xFF22C55E),
      ),
    );
  }
}