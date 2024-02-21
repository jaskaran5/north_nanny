import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';

class CustomSettingItemTile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String leadingIcon;
  final String trallingIcon;

  const CustomSettingItemTile(
      {super.key,
      required this.onTap,
      required this.text,
      required this.trallingIcon,
      required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          child: Card(
            color: AppColors.primaryColor,
            elevation: 0,
            margin: const EdgeInsets.all(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    leadingIcon,
                    height: 28,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(text),
                  const Spacer(),
                  SvgPicture.asset(trallingIcon),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
