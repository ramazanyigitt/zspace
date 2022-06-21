import 'package:flutter/material.dart';
import 'package:zspace/features/_components/overlay/widgets/game_pause_menu.dart';
import '../../classic_text.dart';
import '../custom_overlay.dart';
import '../../../../shared/app_theme.dart';

class GamePauseButtonOverlay extends CustomOverlay {
  static GamePauseButtonOverlay? _instance;

  GamePauseButtonOverlay._internal() {
    _instance = this;
  }

  factory GamePauseButtonOverlay() =>
      _instance ?? GamePauseButtonOverlay._internal();

  void show({
    bool addFrameCallback: false,
    bool forceOverlay = false,
    bool fullTap = false,
    Function()? onTap,
    Function()? onClickResume,
    Function()? onClickMainMenu,
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
          onClickResume,
          onClickMainMenu,
        ]);
  }

  @override
  Widget customOverlayWidget(ValueNotifier<OverlayEntry?> overlayEntry,
      {Function()? onTap, List<dynamic>? params}) {
    return GamePauseButtonWidget(
      closeOverlay: closeCustomOverlay,
      overlayEntry: overlayEntry,
      onTap: onTap,
      text: params![0],
      buttonText: params[1],
      buttonTextColor: params[2],
      removeDuration: params[3],
      fullTap: params[4],
      onClickResume: params[5],
      onClickMainMenu: params[6],
    );
  }
}

class GamePauseButtonWidget extends StatefulWidget {
  final Function() closeOverlay;
  final Function()? onTap, onClickResume, onClickMainMenu;
  final ValueNotifier<OverlayEntry?> overlayEntry;
  final String text;
  final String buttonText;
  final Color? buttonTextColor;
  final Duration? removeDuration;
  final bool fullTap;
  GamePauseButtonWidget({
    required this.overlayEntry,
    required this.onTap,
    required this.onClickResume,
    required this.onClickMainMenu,
    required this.text,
    required this.buttonText,
    required this.closeOverlay,
    this.buttonTextColor,
    this.removeDuration,
    this.fullTap: false,
  });

  @override
  State<GamePauseButtonWidget> createState() => _GamePauseButtonWidgetState();
}

class _GamePauseButtonWidgetState extends State<GamePauseButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 15, vertical: kBottomNavigationBarHeight / 2),
          child: Material(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(5),
            elevation: 5.0,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                widget.onTap!();
                GamePauseMenu().show(
                  forceOverlay: true,
                  text: '',
                  buttonText: '',
                  onTap: () {
                    widget.onClickMainMenu!();
                  },
                  onClickResume: () {
                    widget.onClickResume!();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
