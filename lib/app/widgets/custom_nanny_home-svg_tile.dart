import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';

class CustomNannySvgTile extends StatelessWidget {
  const CustomNannySvgTile(
      {super.key,
      required this.assetName,
      required this.heading,
      required this.aboutHeading});
  final String assetName;
  final String heading;
  final String aboutHeading;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetName,
            height: Dimens.twentyFour,
            width: Dimens.twentyFour,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: heading,
                style: AppStyles.ub5E5F60Grey10W500,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              AppText(
                text: aboutHeading,
                style: AppStyles.ubBlack14W600,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ],
      );
}
