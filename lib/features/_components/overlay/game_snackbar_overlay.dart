import 'package:flutter/material.dart';
import '../classic_text.dart';
import 'custom_overlay.dart';
import '../../../shared/app_theme.dart';

class GameSnackbarOverlay extends CustomOverlay {
  static GameSnackbarOverlay? _instance;

  GameSnackbarOverlay._internal() {
    _instance = this;
  }

  factory GameSnackbarOverlay() => _instance ?? GameSnackbarOverlay._internal();

  void show({
    bool addFrameCallback: false,
    bool forceOverlay = false,
    bool fullTap = false,
    Function()? onTap,
    required String text,
    required String buttonText,
    Color? buttonTextColor,
    Duration? removeDuration,
  }) {
    if (forceOverlay) closeCustomOverlay();
    showCustomOverlay(
        addFrameCallback: addFrameCallback,
        onTap: onTap,
        params: [text, buttonText, buttonTextColor, removeDuration, fullTap]);
  }

  @override
  Widget customOverlayWidget(ValueNotifier<OverlayEntry?> overlayEntry,
      {Function()? onTap, List<dynamic>? params}) {
    return GameSnackbarWidget(
      closeOverlay: closeCustomOverlay,
      overlayEntry: overlayEntry,
      onTap: onTap,
      text: params![0],
      buttonText: params[1],
      buttonTextColor: params[2],
      removeDuration: params[3],
      fullTap: params[4],
    );
  }
}

class GameSnackbarWidget extends StatefulWidget {
  final Function() closeOverlay;
  final Function()? onTap;
  final ValueNotifier<OverlayEntry?> overlayEntry;
  final String text;
  final String buttonText;
  final Color? buttonTextColor;
  final Duration? removeDuration;
  final bool fullTap;
  GameSnackbarWidget({
    required this.overlayEntry,
    required this.onTap,
    required this.text,
    required this.buttonText,
    required this.closeOverlay,
    this.buttonTextColor,
    this.removeDuration,
    this.fullTap: false,
  });

  @override
  State<GameSnackbarWidget> createState() => _GameSnackbarWidgetState();
}

class _GameSnackbarWidgetState extends State<GameSnackbarWidget> {
  late double _opacity;
  late Duration animationDuration;
  @override
  void initState() {
    _opacity = 1.0;
    animationDuration = Duration(milliseconds: 300);
    if (widget.removeDuration != null) removeTimer();
    super.initState();
  }

  void removeTimer() {
    Future.delayed(widget.removeDuration! - animationDuration, () {
      if (mounted)
        setState(() {
          _opacity = 0.0;
        });
      Future.delayed(animationDuration, () {
        if (mounted) widget.closeOverlay();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: animationDuration,
      opacity: _opacity,
      child: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (widget.fullTap && widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 15, vertical: kBottomNavigationBarHeight / 2),
              child: Material(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(5),
                elevation: 5.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
                        child: ClassicText(
                          text: '${widget.text}',
                          style: AppTheme()
                              .extraSmallParagraphRegularText
                              .copyWith(
                                color: Colors.white.withOpacity(0.88),
                              ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Container(
                        color: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
                        child: InkWell(
                          child: Ink(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7.5),
                            child: ClassicText(
                              text: widget.buttonText,
                              style: AppTheme()
                                  .extraSmallParagraphSemiBoldText
                                  .copyWith(
                                    color: widget.buttonTextColor ??
                                        AppTheme().primaryColor,
                                  ),
                            ),
                          ),
                          onTap: widget.onTap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
