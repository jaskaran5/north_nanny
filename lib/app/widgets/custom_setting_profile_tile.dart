import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
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
        child: SizedBox(
          height: 70,
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
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomCacheNetworkImage(img: '', size: 40),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Spacer(),
                  SvgPicture.asset(trailingIcon),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
          ),
        ));
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
