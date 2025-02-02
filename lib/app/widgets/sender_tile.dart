import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/res/theme/colors.dart';
import 'package:northshore_nanny_flutter/app/res/theme/styles.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/app_text.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

import '../res/theme/dimens.dart';
import 'custom_sender_chat_time_tile.dart';

class SenderTile extends StatelessWidget {
  const SenderTile({
    super.key,
    this.title,
    this.time,
    this.fileLink,
    this.fileType,
    required this.isFile,
    this.onTapOnPdf,
    this.onTapOnVideo,
    this.onTapOnImage,
    this.thumbImage,
    this.readTime,
    required this.isRead,
  });
  final String? title;
  final String? time;
  final String? readTime;
  final String? fileLink;
  final bool isFile;
  final bool isRead;
  final String? fileType;
  final String? thumbImage;

  final VoidCallback? onTapOnPdf;
  final VoidCallback? onTapOnVideo;
  final VoidCallback? onTapOnImage;

  // void generateThumbnailFromVideo() async {
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //     video:
  //         "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
  //     thumbnailPath: (await getTemporaryDirectory()).path,
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight: 64,
  //     quality: 75,
  //   );

  //   log("url:--> $fileName");
  // }

  @override
  Widget build(BuildContext context) {
    // generateThumbnailFromVideo();
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Get.width / 1.6),
                child: isFile ? _buildFileWidget() : _buildTextWidget()),
            CustomSenderChatTimeTile(
              text: readTime == 'null'
                  ? ''
                  : Utility.formatTimeTo12Hour(readTime),
              isRead: isRead,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileWidget() {
    if ((fileType == "jpg") || (fileType == "jpeg") || (fileType == "png")) {
      return GestureDetector(
        onTap: onTapOnImage,
        child: Container(
          padding: Dimens.edgeInsets4,
          decoration: BoxDecoration(
            color: AppColors.navyBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.thirteen),
              topRight: Radius.circular(Dimens.thirteen),
              bottomLeft: Radius.circular(Dimens.thirteen),
            ),
          ),
          child: CustomCacheNetworkImage(
            img: fileLink!,
            size: 100,
            imageRadius: 10,
          ),
        ),
      );
    } else if ((fileType == "pdf") || (fileType == "docx")) {
      return GestureDetector(
        onTap: onTapOnPdf,
        child: Container(
          padding: Dimens.edgeInsets4,
          decoration: BoxDecoration(
            color: AppColors.navyBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.thirteen),
              topRight: Radius.circular(Dimens.thirteen),
              bottomLeft: Radius.circular(Dimens.thirteen),
            ),
          ),
          child: const Icon(
            Icons.picture_as_pdf,
            size: 100,
          ),
        ),
      );
    } else if (fileType == "mp4") {
      //
      // Show video player widget here
      return GestureDetector(
        onTap: onTapOnVideo,
        child: Container(
          padding: Dimens.edgeInsets4,
          decoration: BoxDecoration(
            color: AppColors.navyBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.thirteen),
              topRight: Radius.circular(Dimens.thirteen),
              bottomLeft: Radius.circular(Dimens.thirteen),
            ),
          ),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                CustomCacheNetworkImage(
                  img: thumbImage!,
                  size: 100,
                  imageRadius: 10,
                ),
                const Center(
                    child: Icon(
                  Icons.slow_motion_video_outlined,
                  color: Colors.white,
                  size: 40,
                ))
              ],
            ),
          ),
        ),
      ); // Replace this with your video player widget
    } else {
      return const SizedBox();
    }
  }

  Widget _buildTextWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 0),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.fifteen),
          topRight: Radius.circular(Dimens.fifteen),
          bottomLeft: Radius.circular(Dimens.fifteen),
        ),
      ),
      child: AppText(
        text: title!,
        style: AppStyles.ubWhite14W400,
        textAlign: TextAlign.left,
      ),
    );
  }
}
