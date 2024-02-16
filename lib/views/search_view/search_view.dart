import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/widgets/app_text.dart';

import '../../utils/translations/translation_keys.dart';
import '../../widgets/custom_text_field.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: Dimens.edgeInsets16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: SvgPicture.asset(Assets.iconsBackArrow),
                    ),
                    Dimens.boxWidth16,
                    SizedBox(
                      height: Dimens.forty,
                      width: Dimens.twoHundredEightyOne,
                      child: TextField(
                        controller: searchTextEditingController,
                        maxLines: 1,
                        minLines: 1,
                        decoration: customFieldDeco(
                          hintText: '${TranslationKeys.search.tr} ',
                          fillColor: AppColors.searchColor,
                          prefixWidget: Padding(
                            padding: Dimens.edgeInsets12,
                            child: SvgPicture.asset(
                              Assets.iconsSearch,
                              height: Dimens.ten,
                              width: Dimens.ten,
                            ),
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              searchTextEditingController.clear();
                            },
                            child: Padding(
                              padding: Dimens.edgeInsets10,
                              child: SvgPicture.asset(
                                Assets.iconsRemove,
                              ),
                            ),
                          ),
                          hintStyle: AppStyles.ubHintColor12W500,
                        ),
                        cursorColor: AppColors.blackColor,
                        cursorWidth: Dimens.one,
                        style: AppStyles.ubBlack14W600,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                Dimens.boxHeight16,
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Dimens.boxHeight100,
                        Dimens.boxHeight100,
                        Dimens.boxHeight100,
                        AppText(
                          text: TranslationKeys.noResultFound.tr,
                          style: AppStyles.pdNavyBlue20W600,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
