import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/app_theme.dart';
import 'classic_text.dart';
import 'sign_text_form_field.dart';

class FieldBuilder extends StatelessWidget {
  final TextEditingController controller;
  final String text, hint;
  final ValueNotifier<String?> notifier;
  final Function() validator;
  final TextInputType keyboardType;
  final EdgeInsets margin;
  final EdgeInsets fieldPadding;
  final Widget? rightWidget, leftWidget, suffixIcon;
  final TextStyle? titleStyle, style;
  final EdgeInsets textPadding;
  final Function(String?)? onChanged;
  final bool isEnabled;
  final Color? textColor, disabledTextColor;
  final bool showErrorOnlyIfTrue;
  final bool disableValidator;
  final bool disableDecoration;
  final Radius? borderRadiusTopLeft, borderRadiusBottomLeft;

  const FieldBuilder({
    Key? key,
    required this.controller,
    required this.text,
    required this.hint,
    required this.notifier,
    required this.validator,
    this.keyboardType: TextInputType.text,
    this.margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    this.textPadding: const EdgeInsets.only(bottom: 5, left: 5),
    this.fieldPadding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    this.rightWidget,
    this.leftWidget,
    this.suffixIcon,
    this.titleStyle,
    this.style,
    this.onChanged,
    this.isEnabled: true,
    this.textColor,
    this.disabledTextColor,
    this.showErrorOnlyIfTrue: false,
    this.disableValidator: false,
    this.disableDecoration: false,
    this.borderRadiusBottomLeft,
    this.borderRadiusTopLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (text != '')
            Container(
              padding: textPadding,
              child: ClassicText(
                text: text,
                style: titleStyle ??
                    AppTheme().extraSmallParagraphMediumText.copyWith(),
              ),
            ),
          IntrinsicHeight(
            child: Row(
              children: [
                if (leftWidget != null) leftWidget!,
                Expanded(
                  child: Container(
                    padding: fieldPadding,
                    decoration: disableDecoration
                        ? null
                        : BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                    child: SignTextFormField(
                      textController: controller,
                      autovalidateMode: true,
                      labelText: '',
                      hintText: hint,
                      obscureVisibility: false,
                      keyboardType: keyboardType,
                      borderColor: Colors.transparent,
                      fillColor: Colors.white,
                      hintColor: Colors.black,
                      borderRadius: 8,
                      disableValidator: disableValidator,
                      onChanged: (text) {
                        if (onChanged != null) onChanged!(text);
                        validator();
                      },
                      validatorEmptyMessage: 'Can not be empty',
                      suffixIcon: suffixIcon,
                      style: style,
                      isEnabled: isEnabled,
                      disabledTextColor: disabledTextColor,
                      textColor: textColor,
                      borderRadiusBottomLeft: borderRadiusBottomLeft,
                      borderRadiusTopLeft: borderRadiusTopLeft,
                    ),
                  ),
                ),
                if (rightWidget != null) rightWidget!,
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, String? error, child) {
              if (showErrorOnlyIfTrue && error == null) return Container();
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 200),
                builder: (BuildContext context, double size, Widget? child) {
                  return Opacity(
                    opacity: size,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        (1.0 - size) * -2.0,
                      ),
                      child: /*Transform.scale(
                        scale: size,
                        child: */
                          Container(
                        padding: EdgeInsets.only(bottom: 5, left: 11.w, top: 5),
                        child: ClassicText(
                          text: error ?? '',
                          style:
                              AppTheme().extraSmallParagraphMediumText.copyWith(
                                    color: Colors.red[400],
                                  ),
                        ),
                      ),
                      //),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
