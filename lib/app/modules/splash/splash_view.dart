import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/splash/splash_view_controller.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<SplashController>(
        builder: (controller) => Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.iconsSplash,
                ),
              ],
            ),
          ),
        ),
      );
}
