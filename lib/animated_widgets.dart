import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

class AnimatedTitle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const AnimatedTitle({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color.withOpacity(0.8),
            color,
            color.withOpacity(0.8),
          ],
        ).createShader(rect);
      },
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.blueAccent,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: child,
        ),
      ),
    );
  }
}