import 'package:flutter/material.dart';

import '../../shared/app_theme.dart';
import 'custom_button.dart';

class ThemeButton extends StatelessWidget {
  final String? text;
  final Function() onTap;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? elevation;
  final EdgeInsets margin;
  final Widget? child;
  final bool isEnabled;
  final double width, height;
  final Color? textColor;
  final TextStyle? textStyle;
  const ThemeButton({
    Key? key,
    this.text,
    this.child,
    required this.onTap,
    this.margin = const EdgeInsets.all(5),
    this.borderRadius,
    this.color,
    this.elevation: 3,
    this.isEnabled: true,
    this.width: 200,
    this.height: 50,
    this.textColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CustomButton(
        onPressed: onTap,
        text: text,
        child: child,
        options: CustomButtonOptions(
          width: width,
          height: height,
          color: color ?? AppTheme().darkPrimaryColor,
          textStyle: textStyle ??
              AppTheme().paragraphRegularText.apply(
                    color: textColor ?? Colors.white,
                  ),
          elevation: elevation,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: 8,
          borderRadiusCustom: borderRadius,
          highlightColor: isEnabled ? null : Colors.transparent,
          splashColor: isEnabled ? null : Colors.transparent,
        ),
      ),
    );
  }
}
