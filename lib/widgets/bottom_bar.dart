import 'package:flutter/material.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

Widget bottomBar(context) {
  return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
        final double halfWidth = context.size?.width ?? 0 / 2;
        final bool isLeft = details.localPosition.dx < halfWidth;

        if (isLeft) {
          print('left');
          context.openDrawers();
          // Left side action
          // Navigator.push(context, LeftPage());
        } else {
          print('right');
          // Right side action
          //  Navigator.push(context, RightPage());
        }
      },
      child: Container(
        color: Colors.transparent, // Полная прозрачность фона

        //color: Colors.transparent, // This makes the container transparent
        child: Image.asset(
          'assets/images/bottom_bar.png',
          fit: BoxFit.cover,
          color: Colors.white.withOpacity(1), // Optional: adjust image opacity
          colorBlendMode: BlendMode.modulate, // Optional: blending mode
        ),
      ));
}
