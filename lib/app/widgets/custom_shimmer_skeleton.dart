import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const SkeletonWidget(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      containersColor: const Color(0xFFEBEBF4),
      effect: ShimmerEffect(
        duration: const Duration(seconds: 2),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        begin: const Alignment(-1.0, -0.3),
        end: const Alignment(1.0, 0.3),
      ),
      textBoneBorderRadius: const TextBoneBorderRadius.fromHeightFactor(.5),
      child: child,
    );
  }
}
