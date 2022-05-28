import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonOptions {
  const CustomButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.highlightColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
    this.borderRadiusCustom,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
  final BorderRadius? borderRadiusCustom;
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.child,
    this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
  }) : super(key: key);

  final String? text;
  final Widget? child, icon;
  final IconData? iconData;
  final VoidCallback onPressed;
  final CustomButtonOptions options;

  @override
  Widget build(BuildContext context) {
    var textWidget;
    if (child != null) {
      textWidget = child;
    } else if (text != null) {
      textWidget = AutoSizeText(
        text!,
        style: options.textStyle,
        maxLines: 1,
      );
    }
    if (icon != null || iconData != null) {
      return Container(
        height: options.height,
        width: options.width,
        child: RaisedButton.icon(
          icon: Padding(
            padding: options.iconPadding ?? EdgeInsets.zero,
            child: icon ??
                FaIcon(
                  iconData,
                  size: options.iconSize,
                  color: options.iconColor ??
                      options.textStyle!.color ??
                      Colors.white,
                ),
          ),
          label: textWidget,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: options.borderRadiusCustom ??
                BorderRadius.circular(options.borderRadius ?? 0),
            side: options.borderSide ?? BorderSide.none,
          ),
          color: options.color ?? Colors.white,
          colorBrightness: ThemeData.estimateBrightnessForColor(
              options.color ?? Colors.white),
          textColor: options.textStyle!.color ?? Colors.white,
          disabledColor: options.disabledColor,
          disabledTextColor: options.disabledTextColor,
          elevation: options.elevation,
          splashColor: options.splashColor,
          highlightColor: options.highlightColor,
        ),
      );
    }

    return Container(
      height: options.height,
      width: options.width,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: options.borderRadiusCustom ??
              BorderRadius.circular(options.borderRadius ?? 28),
          side: options.borderSide ?? BorderSide.none,
        ),
        textColor: options.textStyle!.color ?? Colors.white,
        color: options.color,
        splashColor: options.splashColor,
        highlightColor: options.highlightColor,
        colorBrightness:
            ThemeData.estimateBrightnessForColor(options.color ?? Colors.white),
        disabledColor: options.disabledColor,
        disabledTextColor: options.disabledTextColor,
        padding: options.padding,
        elevation: options.elevation,
        highlightElevation: options.splashColor != null ? 0 : null,
        child: textWidget,
      ),
    );
  }
}
