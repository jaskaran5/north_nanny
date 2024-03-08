import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

class CustomSettingProfileTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String subtitle;
  final String img;
  final String trailingIcon;

  const CustomSettingProfileTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.img,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: Dimens.edgeInsets16,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.ten),
          boxShadow: [
            BoxShadow(
              color: AppColors.settingBackgroundColor.withOpacity(.18),
              blurRadius: Dimens.fifteen,
            ),
          ],
        ),

        //fdsf
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCacheNetworkImage(
                  img: img,
                  size: Dimens.forty,
                  imageRadius: Dimens.hundred,
                ),
                Dimens.boxWidth10,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppStyles.ubBlack15W600,
                    ),
                    Text(
                      subtitle,
                      style: AppStyles.ubGrey12W500,
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(trailingIcon),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(15.0),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(.5),
  //               blurRadius: 10.0,
  //               spreadRadius: 2.0,
  //               offset: const Offset(0.0, 5.0),
  //             )
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //                   children: [
  //                     const CustomCacheNetworkImage(img: '', size: 50),
  //                     Column(
  //                       children: [
  //                         Text(title),
  //                         Text(subtitle),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               SvgPicture.asset(trailingIcon),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
