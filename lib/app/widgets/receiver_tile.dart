import 'package:flutter/material.dart';

class ReceiverTile extends StatelessWidget {
  const ReceiverTile({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 38, right: 50),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          title!,
          textAlign: TextAlign.left,
          // style: titleStyle
          //     .copyWith(
          //       fontSize: 16,
          //       color: blackColor,
          //     )
          //     .usePoppinsW5Font(),
        ),
      ),
    );
  }
}
