import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';

class CustomReceiverChatTimeTile extends StatelessWidget {
  final String text;
  const CustomReceiverChatTimeTile({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.ub8F94AE10W400,
    );
  }
}
