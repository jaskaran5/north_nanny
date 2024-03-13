import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

class TextOnImage extends StatelessWidget {
  const TextOnImage({
    super.key,
    required this.image,
    this.color,
  });
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          Assets.imagesNannyMapPin,
          scale: 0.1,
          color: color,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: CircleAvatar(
              foregroundImage: NetworkImage(image),
              radius: 60.0,
              // backgroundImage: NetworkImage(image),
            ),
          ),
        )
      ],
    );
  }
}
