import 'package:flutter/cupertino.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomNotificationTile extends StatelessWidget {
  const CustomNotificationTile({
    super.key,
    required this.notificationHeading,
    required this.notificationSubHeading,
    required this.notificationTime,
    required this.isNotificationRead,
  });

  final String notificationHeading;
  final String notificationSubHeading;
  final String notificationTime;
  final bool isNotificationRead;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        margin: Dimens.edgeInsetsB16,
        height: Dimens.hundredFortyFive,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(Dimens.fourteen),
          border: Border.all(
            color: AppColors.notificationBackgroundColor,
            width: isNotificationRead ? 0.5 : Dimens.one,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.notificationBackgroundColor,
              blurRadius: Dimens.three,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: notificationHeading,
              style: AppStyles.ubNavyBlue14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight8,
            AppText(
              text: notificationSubHeading,
              style: AppStyles.ubNavyBlue14W400,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight8,
            AppText(
              text: notificationTime,
              style: AppStyles.ubNavyBlue12W500,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
}
