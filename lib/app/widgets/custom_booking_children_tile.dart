import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomBookingChildrenTile extends StatelessWidget {
  const CustomBookingChildrenTile({
    super.key,
    required this.childrenHeader,
    required this.childrenDetailsList,
    required this.isExpand,
    required this.expansionCallback,
  });

  final String childrenHeader;
  final List<String> childrenDetailsList;
  final bool isExpand;
  final Function(int panelIndex, bool isExpand) expansionCallback;

  @override
  Widget build(BuildContext context) => Container(
        padding: Dimens.edgeInsets16,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimens.fourteen,
          ),
          border: Border.all(color: AppColors.navyBlue, width: Dimens.two),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: childrenHeader,
              style: AppStyles.ubBlack14W700,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            Dimens.boxHeight10,
            ...List.generate(
              childrenDetailsList.length,
              (index) => Container(
                margin: Dimens.edgeInsetsB10,
                decoration: BoxDecoration(
                  color: AppColors.listColor,
                  borderRadius: BorderRadius.circular(Dimens.ten),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.ten),
                  child: ExpansionPanelList(
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: AppText(
                              text: childrenDetailsList[index].toString(),
                              style: AppStyles.ubBlack14W700,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                            subtitle: AppText(
                              text: 'Age 7 • Male ',
                              style: AppStyles.ubGrey12W500,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          );
                        },
                        body: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: AppText(
                                text: '• Allergies/Dietary Restrictions',
                                style: AppStyles.ubBlack12W600,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                              subtitle: AppText(
                                text: 'Wheat, Eggs, Tree nuts',
                                style: AppStyles.ubGrey12W500,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Dimens.boxHeight8,
                            ListTile(
                              title: AppText(
                                text: '• Medical Conditions',
                                style: AppStyles.ubBlack12W600,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                              subtitle: AppText(
                                text: 'Chickenpox',
                                style: AppStyles.ubGrey12W500,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        isExpanded: isExpand,
                        backgroundColor: AppColors.listColor,
                        canTapOnHeader: true,
                      ),
                    ],
                    dividerColor: AppColors.dividerColor,
                    expansionCallback: expansionCallback,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
