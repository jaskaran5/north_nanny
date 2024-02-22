import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String img;
  final double size;
  const CustomCacheNetworkImage({
    super.key,
    required this.img,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    log("image value is:------>>>. $img");
    return ((img == '') || (img == '-') || (img.isEmpty))
        ? CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: size / 2,
            backgroundImage: const AssetImage('assets/images/user_avatar.png'),
          )
        : CachedNetworkImage(
            imageUrl: img,
            imageBuilder: (context, imageProvider) => Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) {
              if (downloadProgress.progress != null) {
                var percent = (downloadProgress.progress!) * 100;

                log("Download percentage is :${percent.toInt()}");
              } else {}
              log("DOWNLOAD PROGRESS IS:-->> ${downloadProgress.progress}");
              // log("DOWNLOAD PROGRESS IS:-->> " + progress.toString());

              return CircularProgressIndicator(
                value: downloadProgress.progress,
              );

              // return CircularPercentIndicator(
              //   animation: true,
              //   radius: size / 2,
              //   lineWidth: 5.0,
              //   percent: (downloadProgress.progress != null)
              //       ? (downloadProgress.progress)!
              //       : 1.0,
              //   center: Text(
              //     downloadProgress.progress != null
              //         ? (((downloadProgress.progress!) * 100)
              //                 .toInt()
              //                 .toString() +
              //             '%')
              //         : '',
              //     style: const TextStyle(color: blackColor),
              //   ),
              //   progressColor: Colors.green,
              // );
              // Stack(
              //   children: [

              //     CircularProgressIndicator(
              //       strokeWidth: 8.0,
              //       value: downloadProgress.progress,
              //     ),
              //     Text(downloadProgress.progress != null
              //         ? (((downloadProgress.progress!) * 100)
              //                 .toInt()
              //                 .toString() +
              //             '%')
              //         : '')
              //   ],
              // );
            },
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}
