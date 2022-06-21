import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../classic_text.dart';
import '../custom_overlay.dart';
import '../../../../shared/app_theme.dart';

class GamePauseMenu extends CustomOverlay {
  static GamePauseMenu? _instance;

  GamePauseMenu._internal() {
    _instance = this;
  }

  factory GamePauseMenu() => _instance ?? GamePauseMenu._internal();

  void show({
    bool addFrameCallback: false,
    bool forceOverlay = false,
    bool fullTap = false,
    Function()? onTap,
    Function()? onClickResume,
    required String text,
    required String buttonText,
    Color? buttonTextColor,
    Duration? removeDuration,
  }) {
    if (forceOverlay) closeCustomOverlay();
    showCustomOverlay(
        addFrameCallback: addFrameCallback,
        onTap: onTap,
        params: [
          text,
          buttonText,
          buttonTextColor,
          removeDuration,
          fullTap,
          onClickResume
        ]);
  }

  @override
  Widget customOverlayWidget(ValueNotifier<OverlayEntry?> overlayEntry,
      {Function()? onTap, List<dynamic>? params}) {
    return GamePauseMenuWidget(
      closeOverlay: closeCustomOverlay,
      overlayEntry: overlayEntry,
      onTap: onTap,
      text: params![0],
      buttonText: params[1],
      buttonTextColor: params[2],
      removeDuration: params[3],
      fullTap: params[4],
      onClickResume: params[5],
    );
  }
}

class GamePauseMenuWidget extends StatefulWidget {
  final Function() closeOverlay;
  final Function()? onTap, onClickResume;
  final ValueNotifier<OverlayEntry?> overlayEntry;
  final String text;
  final String buttonText;
  final Color? buttonTextColor;
  final Duration? removeDuration;
  final bool fullTap;
  GamePauseMenuWidget({
    required this.overlayEntry,
    required this.onTap,
    required this.onClickResume,
    required this.text,
    required this.buttonText,
    required this.closeOverlay,
    this.buttonTextColor,
    this.removeDuration,
    this.fullTap: false,
  });

  @override
  State<GamePauseMenuWidget> createState() => _GamePauseMenuWidgetState();
}

class _GamePauseMenuWidgetState extends State<GamePauseMenuWidget> {
  late double _opacity;
  late Duration animationDuration;
  @override
  void initState() {
    _opacity = 1.0;
    animationDuration = Duration(milliseconds: 300);
    super.initState();
  }

  void removeTimer() {
    if (mounted)
      setState(() {
        _opacity = 0.0;
      });
    Future.delayed(animationDuration, () {
      if (mounted) widget.closeOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: animationDuration,
      opacity: _opacity,
      child: GestureDetector(
        onTap: () {
          widget.onClickResume!();
          removeTimer();
        },
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: Colors.black26,
          child: Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Material(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(5),
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Ink(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                            child: ClassicText(
                              text: 'Resume',
                              style: AppTheme().paragraphSemiBoldText.copyWith(
                                    color: Colors.white.withOpacity(0.88),
                                  ),
                            ),
                          ),
                          onTap: () {
                            widget.onClickResume!();
                            removeTimer();
                          },
                        ),
                        InkWell(
                          child: Ink(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                            child: ClassicText(
                              text: 'Main menu',
                              style: AppTheme().paragraphSemiBoldText.copyWith(
                                    color: Colors.white.withOpacity(0.88),
                                  ),
                            ),
                          ),
                          onTap: () {
                            removeTimer();
                            widget.onTap!();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
