import 'package:flutter/material.dart';

import '../res/res.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: ColorsValue.primaryColor,
              ),
            ),
          ),
        ),
      );
}
