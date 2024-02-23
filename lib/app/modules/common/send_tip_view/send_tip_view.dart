import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_app_bar.dart';

class SendTipView extends StatelessWidget {
  const SendTipView({super.key});

  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: CustomAppbarWidget(),
    body: Padding(
      padding: Dimens.edgeInsets16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    ),
  );
}
