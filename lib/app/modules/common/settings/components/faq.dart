import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_faq_tile.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      id: 'faqView',
      initState: (_) {
        Get.find<SettingController>().getFaqList();
      },
      init: SettingController(),
      builder: (controller) {
        return Scaffold(
            appBar: CustomAppbarWidget(
              title: TranslationKeys.fAQ.tr,
            ),
            body: Padding(
              padding: Dimens.edgeInsets16,
              child: controller.faqResponseModel?.data != null
                  ? ListView.builder(
                      itemCount: controller.faqResponseModel?.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CustomFAQTile(
                        onTap: () {
                          controller.faqResponseModel?.data?[index].isSelected =
                              !(controller.faqResponseModel?.data?[index]
                                      .isSelected ??
                                  false);
                          controller.update(['faqView']);
                        },
                        isExpand: controller
                                .faqResponseModel?.data?[index].isSelected ??
                            false,
                        subtitle:
                            controller.faqResponseModel?.data?[index].answer ??
                                '',
                        title: controller
                                .faqResponseModel?.data?[index].questions ??
                            '',
                      ),
                    )
                  : Center(
                      child: AppText(
                        text: TranslationKeys.noResultFound.tr,
                        style: AppStyles.ubNavyBlue30W600,
                      ),
                    ),
            ));
      },
    );
  }
}
