import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../shared/app_theme.dart';
import '../classic_text.dart';
import '../custom_button.dart';
import 'lock_overlay_dialog.dart';

class OverlayErrorDialog extends StatelessWidget {
  final String error;
  const OverlayErrorDialog({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                LockOverlayDialog().closeOverlay();
              },
              child: Container(
                color: Colors.black12,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: -12.0),
                child: Container()),
          ),
          Positioned.fill(
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Card(
                          elevation: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: ClassicText(
                                  text: error,
                                  style: AppTheme().paragraphRegularText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                text: 'Ok',
                                onPressed: () {
                                  LockOverlayDialog().closeOverlay();
                                },
                                options: CustomButtonOptions(
                                  width: 80,
                                  height: 24,
                                  color: Color(0xFF121833),
                                  textStyle: AppTheme()
                                      .paragraphRegularText
                                      .apply(color: Colors.white),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 10,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
