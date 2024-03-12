import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/res/constants/assets.dart';

class TextOnImage extends StatelessWidget {
  const TextOnImage({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Assets.imagesNannyMapPin,
          scale: 0.1,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 25.0),
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
