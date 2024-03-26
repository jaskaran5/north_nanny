
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
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
  });
  final String? title;
  final String? time;
  final String? fileLink;
  final bool isFile;
  final String? fileType;
  final VoidCallback? onTapOnPdf;
  final VoidCallback? onTapOnVideo;

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
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxWidth: Get.width / 1.6),
                child: isFile ? _buildFileWidget() : _buildTextWidget()
                // ? CustomCacheNetworkImage(
                //     img: fileLink!, size: 100, imageRadius: 10)
                // : Container(
                //     margin: const EdgeInsets.only(bottom: 10),
                //     // margin: const EdgeInsets.only(bottom: 38, left: 50),
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 18,
                //       vertical: 15,
                //     ),
                //     decoration: BoxDecoration(
                //       color: AppColors.trackerBackgroundColor,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(Dimens.fifteen),
                //         topRight: Radius.circular(Dimens.fifteen),
                //         bottomLeft: Radius.circular(Dimens.fifteen),
                //       ),
                //     ),
                //     child: Text(
                //       title!,
                //       style: const TextStyle(color: Colors.white),
                //       textAlign: TextAlign.left,
                //     ),
                //   ),

                ),
            CustomSenderChatTimeTile(
              text: Utility.formatTimeTo12Hour(time),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFileWidget() {
    if ((fileType == "jpg") || (fileType == "jpeg") || (fileType == "png")) {
      return CustomCacheNetworkImage(
        img: fileLink!,
        size: 100,
        imageRadius: 10,
      );
    } else if ((fileType == "pdf") || (fileType == "docx")) {
      return GestureDetector(
        onTap: onTapOnPdf,
        child: const Icon(
          Icons.picture_as_pdf,
          size: 100,
        ),
      );
    } else if (fileType == "mp4") {
      // Show video player widget here
      return GestureDetector(
        onTap: onTapOnVideo,
        child: const SizedBox(
          child: Icon(Icons.video_call),
        ),
      ); // Replace this with your video player widget
    } else {
      return const SizedBox();
    }
  }

  Widget _buildTextWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 50),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.fifteen),
          topRight: Radius.circular(Dimens.fifteen),
          bottomRight: Radius.circular(Dimens.fifteen),
        ),
      ),
      child: Text(
        title!,
        textAlign: TextAlign.left,
      ),
    );
  }
}
