import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';
import 'package:northshore_nanny_flutter/app/res/theme/dimens.dart';
import 'package:shimmer/shimmer.dart';

class CustomCacheNetworkWidget extends StatelessWidget {
  final String image;
  const CustomCacheNetworkWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (image.isNotEmpty)
          CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: Dimens.hundred,
              width: Dimens.eightySix,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.ten),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: Dimens.hundred,
                width: Dimens.eightySix,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.ten),
                  color: Colors.grey[300],
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        if (image.isEmpty)
          Container(
            height: Dimens.hundred,
            width: Dimens.eightySix,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.ten),
            ),
            child: Center(
              child: Image.asset(
                Assets.imagesUserAvatar, // Replace with your asset image path
                height: Dimens.hundred,
                width: Dimens.eightySix,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}
