import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  static const String route = '/auth';

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Auth View'),
        ),
      );
}
