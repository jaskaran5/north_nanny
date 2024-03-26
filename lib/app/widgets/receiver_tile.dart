import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:northshore_nanny_flutter/app/utils/utility.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

import 'custom_receiver_chat_time_tile.dart';

class ReceiverTile extends StatelessWidget {
  const ReceiverTile({
    super.key,
    this.title,
    this.time,
    this.fileLink,
    this.fileType,
    this.onTapOnPdf,
    required this.isFile,
    this.onTapOnVideo,
    this.onTapOnImage,
    this.thumbImage,
  });
  final String? title;
  final String? time;
  final String? fileLink;
  final String? fileType;
  final String? thumbImage;

  final bool isFile;
  final VoidCallback? onTapOnPdf;
  final VoidCallback? onTapOnVideo;
  final VoidCallback? onTapOnImage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFile ? _buildFileWidget() : _buildTextWidget()
            // isFile
            //     ? CustomCacheNetworkImage(
            //         img: fileLink!, size: 100, imageRadius: 10)
            //     : Container(
            //         margin: const EdgeInsets.only(bottom: 10, right: 50),
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 18,
            //           vertical: 15,
            //         ),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(Dimens.fifteen),
            //             topRight: Radius.circular(Dimens.fifteen),
            //             bottomRight: Radius.circular(Dimens.fifteen),
            //           ),
            //         ),
            //         child: Text(
            //           title!,
            //           textAlign: TextAlign.left,
            //         ),
            //       )

            ,
            CustomReceiverChatTimeTile(
              text: Utility.formatTimeTo12Hour(time),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFileWidget() {
    if ((fileType == "jpg") || (fileType == "jpeg")) {
      return GestureDetector(
        onTap: onTapOnImage,
        child: CustomCacheNetworkImage(
          img: fileLink!,
          size: 100,
          imageRadius: 10,
        ),
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
