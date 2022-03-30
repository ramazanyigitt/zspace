import 'package:flutter/material.dart';

class ClassicText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  const ClassicText({
    Key? key,
    required this.text,
    required this.style,
    this.textAlign: TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
