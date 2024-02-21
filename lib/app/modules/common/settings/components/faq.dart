import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:northshore_nanny_flutter/app/modules/common/settings/setting_controller.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_faq_tile.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: HexColor("#99ABC6"),
            body: ListView.builder(
              itemCount: controller.faqlist.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomFAQTile(
                  onTap: () {
                    controller.updateIsExpand(index: index);
                  },
                  isExpand: controller.faqlist[index]["isExpand"],
                  subtitle: controller.faqlist[index]["subtitle"],
                  title: controller.faqlist[index]["title"],
                );
              },
            ));
      },
    );
  }
}
