import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomFAQTile extends StatelessWidget {
  final Function()? onTap;
  final bool isExpand;
  final String title;
  final String subtitle;

  const CustomFAQTile({
    super.key,
    required this.onTap,
    required this.isExpand,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: isExpand ? 100 : 51.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                AppText(text: title),
                GestureDetector(
                    onTap: onTap, child: const Icon(Icons.add_alarm_outlined)),
              ]),
              Visibility(visible: isExpand, child: Text(subtitle))
            ],
          ),
        ),
      ),
    );
  }
}
