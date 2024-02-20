import 'package:flutter/material.dart';

class CustomSettingItemTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const CustomSettingItemTile({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 18, 17, 17),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0),
            )
          ],
        ),
        child: Row(
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }
}
