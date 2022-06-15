import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../shared/app_theme.dart';
import '../../local_image_box.dart';
import '../../theme_button.dart';
import '../lock_overlay_dialog.dart';

/// A dialog that asks the user to access location.
/// Using this with overlay service.
/// Also can be customized with parameters for custom use.
class CustomDialog extends StatefulWidget {
  final String titleText, button1Text, button2Text, descriptionText;
  final String? image;
  final Function()? onButton1Tap, onButton2Tap, onResume, onClickOutside;
  final bool disableCancelButton;
  const CustomDialog({
    Key? key,
    this.titleText = 'Information',
    this.descriptionText = 'We need your location to verify your videos.',
    this.button1Text = '',
    this.button2Text = '',
    this.onButton1Tap,
    this.onButton2Tap,
    this.onResume,
    this.onClickOutside,
    this.image,
    this.disableCancelButton: false,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with WidgetsBindingObserver {
  late bool _isResumed;
  @override
  void initState() {
    _isResumed = true;
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('App state changed to $state');
    if (state == AppLifecycleState.resumed) {
      log('On resume to app');
      if (_isResumed == false && widget.onResume != null) widget.onResume!();
      _isResumed = true;
    } else if (state == AppLifecycleState.paused) {
      log('On pause to app');
      _isResumed = false;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onClickOutside != null) widget.onClickOutside!();
        LockOverlayDialog().closeOverlay();
      },
      child: Material(
        color: AppTheme().blackColor.withOpacity(0.55),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.titleText,
                      style: AppTheme().paragraphSemiBoldText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.descriptionText,
                      style: AppTheme().smallParagraphRegularText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  if (widget.image != null)
                    SizedBox(
                      height: 10,
                    ),
                  if (widget.image != null)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: LocalImageBox(
                        width: 128,
                        height: 128,
                        imgUrl: widget.image!,
                      ),
                    ),
                  SizedBox(
                    height: 25,
                  ),
                  ThemeButton(
                    height: 42,
                    onTap: () {
                      if (widget.onButton1Tap != null) widget.onButton1Tap!();
                      //LockOverlayDialog().closeOverlay();
                    },
                    text: widget.button1Text,
                  ),
                  if (widget.disableCancelButton)
                    SizedBox(
                      height: 5,
                    ),
                  if (widget.disableCancelButton == false)
                    ThemeButton(
                      height: 42,
                      color: Colors.white,
                      textColor: Colors.black,
                      isEnabled: false,
                      elevation: 0,
                      onTap: () {
                        if (widget.onButton2Tap != null) widget.onButton2Tap!();
                        //LockOverlayDialog().closeOverlay();
                      },
                      text: widget.button2Text,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
