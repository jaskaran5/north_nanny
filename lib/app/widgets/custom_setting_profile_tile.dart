import 'package:flutter/material.dart';
import 'package:northshore_nanny_flutter/app/widgets/custom_cache_network_image.dart';

class CustomSettingProfileTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String subtitle;
  final String img;

  const CustomSettingProfileTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 18, 17, 17),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CustomCacheNetworkImage(img: '', size: 50),
                Column(
                  children: [
                    Text(title),
                    Text(subtitle),
                  ],
                )
              ],
            ),
            const Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}
