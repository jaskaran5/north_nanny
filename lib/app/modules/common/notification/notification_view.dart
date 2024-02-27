import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/utils/enums.dart';
import 'package:northshore_nanny_flutter/app/utils/translations/translation_keys.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_notification_tile.dart';

import '../../../res/theme/dimens.dart';
import '../booking_details/booking_detail_binding.dart';
import '../booking_details/booking_detail_controller.dart';
import '../booking_details/booking_detail_view.dart';

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
                (index) => GestureDetector(
                  onTap: (){
                    if (!Get.isRegistered<
                        BookingDetailController>()) {
                      BookingDetailBinding().dependencies();
                    }
                    var controller=Get.find<BookingDetailController>();
                    if(index==0){
                      controller.bookingDetailStatus=BookingDetailStatus.now;
                    }else if(index==1){
                      controller.bookingDetailStatus=BookingDetailStatus.past;
                    }else{
                      controller.bookingDetailStatus=BookingDetailStatus.complete;
                    }
                    Get.to(const BookingDetailView());
                  },
                  child: CustomNotificationTile(
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
        ),
      );
}
