import 'package:flutter/material.dart';

import '../../shared/app_theme.dart';

//* This class helping us to create a custom text field with specific required ready properties.

class SignTextFormField extends StatefulWidget {
  final TextEditingController textController;
  final String labelText;
  final String hintText;
  final bool obscureVisibility;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color obscureIconColor;
  final double obscureIconSize;
  final String validatorEmptyMessage;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Color borderColor;
  final Color fillColor;
  final TextInputType keyboardType;
  final bool disableValidator;
  final Color hintColor;
  final double borderRadius;
  final bool isEnabled;
  final Color? textColor;
  final Color? disabledTextColor;
  final TextStyle? style;
  final String? helperText;
  final bool autovalidateMode;
  final Radius? borderRadiusTopLeft, borderRadiusBottomLeft;
  final InputBorder? customBorder;
  final int? maxLines;
  const SignTextFormField({
    Key? key,
    required this.textController,
    required this.labelText,
    required this.hintText,
    required this.obscureVisibility,
    this.borderRadiusTopLeft,
    this.borderRadiusBottomLeft,
    this.borderRadius: 50,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureIconColor: const Color(0xFF000000),
    this.obscureIconSize: 22,
    this.validatorEmptyMessage: 'This field can not be empty.',
    this.validator,
    this.fillColor: const Color(0xFF121833),
    this.borderColor: const Color(0xFF121833),
    this.hintColor: const Color(0x9AFFFFFF),
    required this.keyboardType,
    this.disableValidator: false,
    this.onChanged,
    this.textColor,
    this.disabledTextColor,
    this.style,
    this.helperText,
    this.autovalidateMode: false,
    this.customBorder,
    this.maxLines: 1,
  }) : super(key: key);

  @override
  _SignTextFormFieldState createState() => _SignTextFormFieldState();
}

class _SignTextFormFieldState extends State<SignTextFormField> {
  late bool obscureVisible;
  late bool hasFocus;

  @override
  void initState() {
    hasFocus = false;
    obscureVisible = widget.obscureVisibility;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (_hasFocus) {
        setState(() {
          hasFocus = _hasFocus;
        });
      },
      child: TextFormField(
        autovalidateMode:
            widget.autovalidateMode ? AutovalidateMode.onUserInteraction : null,
        readOnly: !widget.isEnabled,
        controller: widget.textController,
        obscureText: obscureVisible,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          helperText: widget.helperText,
          labelText: hasFocus
              ? ''
              : widget.textController.text.length > 0
                  ? ''
                  : widget.labelText,
          labelStyle: AppTheme().smallParagraphRegularText.copyWith(
                color: AppTheme().blackColor,
              ),
          helperStyle: AppTheme().smallParagraphRegularText.copyWith(
                color: Colors.transparent,
              ),
          errorStyle: AppTheme().smallParagraphRegularText.copyWith(
                color: Colors.red[400],
              ),
          hintText: widget.hintText,
          hintStyle: AppTheme().smallParagraphRegularText.apply(
                color: widget.hintColor,
              ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: widget.borderRadiusBottomLeft ??
                  Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(widget.borderRadius),
              topLeft: widget.borderRadiusTopLeft ??
                  Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: widget.borderRadiusBottomLeft ??
                  Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(widget.borderRadius),
              topLeft: widget.borderRadiusTopLeft ??
                  Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: widget.borderRadiusBottomLeft ??
                  Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(widget.borderRadius),
              topLeft: widget.borderRadiusTopLeft ??
                  Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: widget.borderRadiusBottomLeft ??
                  Radius.circular(widget.borderRadius),
              bottomRight: Radius.circular(widget.borderRadius),
              topLeft: widget.borderRadiusTopLeft ??
                  Radius.circular(widget.borderRadius),
              topRight: Radius.circular(widget.borderRadius),
            ),
          ),
          border: widget.customBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: widget.borderRadiusBottomLeft ??
                      Radius.circular(widget.borderRadius),
                  bottomRight: Radius.circular(widget.borderRadius),
                  topLeft: widget.borderRadiusTopLeft ??
                      Radius.circular(widget.borderRadius),
                  topRight: Radius.circular(widget.borderRadius),
                ),
              ),
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureVisibility
              ? InkWell(
                  onTap: () => setState(
                    () => obscureVisible = !obscureVisible,
                  ),
                  child: Icon(
                    obscureVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: widget.obscureIconColor,
                    size: widget.obscureIconSize,
                  ),
                )
              : widget.suffixIcon,
        ),
        style: widget.style ??
            AppTheme().smallParagraphRegularText.copyWith(
                color: widget.isEnabled
                    ? (widget.textColor ?? AppTheme().blackColor)
                    : (widget.disabledTextColor ?? AppTheme().blackColor)),
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        validator: widget.disableValidator
            ? null
            : widget.validator ??
                (val) {
                  if (val!.isEmpty) {
                    return widget.validatorEmptyMessage;
                  }

                  return null;
                },
      ),
    );
  }
}
