import 'package:flutter/material.dart';
import 'package:zspace/features/_components/overlay/widgets/game_pause_menu.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/ships/user_ship.dart';
import '../../classic_text.dart';
import '../custom_overlay.dart';
import '../../../../shared/app_theme.dart';

class GameHealthBarOverlay extends CustomOverlay {
  static GameHealthBarOverlay? _instance;

  GameHealthBarOverlay._internal() {
    _instance = this;
  }

  factory GameHealthBarOverlay() =>
      _instance ?? GameHealthBarOverlay._internal();

  void show({
    bool addFrameCallback: false,
    bool forceOverlay = false,
    required UserShip userShip,
  }) {
    if (forceOverlay) closeCustomOverlay();
    showCustomOverlay(addFrameCallback: addFrameCallback, params: [
      userShip,
    ]);
  }

  @override
  Widget customOverlayWidget(ValueNotifier<OverlayEntry?> overlayEntry,
      {Function()? onTap, List<dynamic>? params}) {
    return _GameHealthBarWidget(
      overlayEntry: overlayEntry,
      userShip: params![0],
    );
  }
}

class _GameHealthBarWidget extends StatefulWidget {
  final ValueNotifier<OverlayEntry?> overlayEntry;
  final UserShip userShip;
  _GameHealthBarWidget({
    required this.overlayEntry,
    required this.userShip,
  });

  @override
  State<_GameHealthBarWidget> createState() => __GameHealthBarWidgetState();
}

class __GameHealthBarWidgetState extends State<_GameHealthBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppTheme().whiteColor.withOpacity(0.55),
              ),
              width: 200.0,
              height: 20.0,
              margin: EdgeInsets.symmetric(
                  horizontal: 15, vertical: kBottomNavigationBarHeight / 2),
            ),
            widget.userShip.onArmorChanged(
              (_context, armor) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.green.withOpacity(1),
                  ),
                  width: (200.0 * armor / widget.userShip.getMaxArmor()),
                  height: 20.0,
                  margin: EdgeInsets.symmetric(
                      horizontal: 15, vertical: kBottomNavigationBarHeight / 2),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
