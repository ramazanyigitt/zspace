import 'package:flutter/material.dart';

import '../../shared/app_theme.dart';
import 'classic_text.dart';
import 'sign_text_form_field.dart';

//* An improved text field for showing errors with default animations and uses easily.

class FieldBuilderAuto extends StatelessWidget {
  final TextEditingController controller;
  final String text, hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final EdgeInsets margin;
  final Widget? suffixIcon, rightWidget;
  final bool isEnabled;
  final Color? textColor, disabledTextColor;
  final TextStyle? titleStyle, style;
  final EdgeInsets textPadding;
  final Function(String?)? onChanged;
  final String? helperText;
  final bool autovalidateMode;
  final bool obscureVisibility;
  final int? maxLines;
  final Color fillColor, borderColor;
  final Color obscureIconColor;

  const FieldBuilderAuto({
    Key? key,
    required this.controller,
    required this.text,
    required this.hint,
    this.validator,
    this.keyboardType: TextInputType.text,
    this.margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    this.textPadding: const EdgeInsets.only(bottom: 5, left: 5),
    this.suffixIcon,
    this.rightWidget,
    this.isEnabled = true,
    this.textColor,
    this.disabledTextColor,
    this.titleStyle,
    this.style,
    this.onChanged,
    this.helperText,
    this.autovalidateMode: false,
    this.obscureVisibility: false,
    this.maxLines: 1,
    this.fillColor: Colors.white,
    this.borderColor: Colors.black,
    this.obscureIconColor: const Color(0xFF000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (text != '')
            Container(
              padding: textPadding,
              child: ClassicText(
                text: text,
                style: titleStyle ?? AppTheme().buttonText.copyWith(),
              ),
            ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: SignTextFormField(
                    textController: controller,
                    labelText: '',
                    hintText: hint,
                    obscureVisibility: obscureVisibility,
                    obscureIconColor: obscureIconColor,
                    keyboardType: keyboardType,
                    borderColor: borderColor,
                    fillColor: fillColor,
                    hintColor: Colors.black,
                    borderRadius: 8,
                    validator: validator,
                    suffixIcon: suffixIcon,
                    isEnabled: isEnabled,
                    textColor: textColor,
                    disabledTextColor: disabledTextColor,
                    style: style,
                    onChanged: onChanged,
                    helperText: helperText,
                    autovalidateMode: autovalidateMode,
                    maxLines: maxLines,
                  ),
                ),
                if (rightWidget != null) rightWidget!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
