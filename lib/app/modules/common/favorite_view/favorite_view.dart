import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/favorite_view/favorite_controller.dart';
import 'package:northshore_nanny_flutter/app/modules/customer/home/widgets/custom_home_list.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: FavoriteController(),
        builder: (context) => Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.favorites.tr,
          ),
          body: Padding(
            padding: Dimens.edgeInsets16,
            child: const HomeCustomListView(
              image: Assets.iconsImage,
              name: 'Sudhanshu',
              rating: " 4.5",
              reviews: "21",
              description:
                  'Dedicated nanny providing loving Care and guidance to littleness. Experienced in nurturing children',
              servicesList: ['Distance 10 miles', 'Age 23', 'Experience 7+'],
              isHeartTapped: true,
              heartSvg: Assets.iconsHeartFilled,
            ),
          ),
        ),
      );
}
