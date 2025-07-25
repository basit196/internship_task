import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.letterSpacing,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
