import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

class FullViewImage extends StatelessWidget {
  final String url;

  const FullViewImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            Expanded(
              child: FullScreenWidget(
                disposeLevel: DisposeLevel.High,
                child: Hero(
                  tag:
                      url, // Assuming you want to use the image URL as the Hero tag
                  child: Image.network(
                    url,
                    fit: BoxFit.fitWidth, // Fit the image to the screen
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
