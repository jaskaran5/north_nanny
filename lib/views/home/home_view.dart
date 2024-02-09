import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('Home View'),
        ),
      );
}
