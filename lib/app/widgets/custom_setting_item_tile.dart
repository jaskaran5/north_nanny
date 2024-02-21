import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: AppColors.primaryColor,
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
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
                  Text(
                    text,
                    style: AppStyles.B0B0BUrbanist14,
                  ),
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
