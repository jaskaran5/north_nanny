import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/controllers/filter/filter.dart';
import 'package:northshore_nanny_flutter/res/res.dart';
import 'package:northshore_nanny_flutter/widgets/widgets.dart';
import '../../utils/translations/translation_keys.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<FilterController>(builder: (controller) {
        return Scaffold(
          appBar: CustomAppbarWidget(
            title: TranslationKeys.filters.tr,
          ),
          body: SafeArea(
            child: Padding(
              padding: Dimens.edgeInsets16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dimens.boxHeight16,
                  AppText(
                    text: TranslationKeys.distance.tr,
                    style: AppStyles.ubBlack16W700,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                  ),
                  RangeSlider(
                    values: const RangeValues(0.0, 20.0),
                    onChanged: (value) {},
                    max: 20.0,
                    min: 0.0,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
