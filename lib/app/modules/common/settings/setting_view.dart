import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_setting_item_tile.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_setting_profile_tile.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppText(text: "Settings"),
        CustomSettingProfileTile(
          onTap: () {},
          title: "Profile name",
          subtitle: "email",
          img: '',
        ),
        CustomSettingItemTile(
          onTap: () {},
          text: "Profile",
        ),
      ],
    );
  }
}
