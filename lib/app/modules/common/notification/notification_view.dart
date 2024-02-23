import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_notification_tile.dart';

import '../../../res/theme/dimens.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppbarWidget(
          addBackButton: false,
          leadingWidth: Dimens.zero,
          centerTitle: false,
          title: TranslationKeys.notifications.tr,
          titleAlignment: TextAlign.start,
        ),
        body: Padding(
          padding: Dimens.edgeInsets16,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                4,
                (index) => CustomNotificationTile(
                  notificationHeading: 'Attention!',
                  notificationSubHeading:
                      'The job will automatically be marked as complete in ten minutes. Confirm now that the job was completed.',
                  notificationTime: '1 month ago',
                  isNotificationRead: true,
                  containerColor: index == 0 || index == 1
                      ? AppColors.notificationBackgroundColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
      );
}
