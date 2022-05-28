import 'package:flutter/material.dart';

import '../../../core/utils/router/app_router.dart';

bool _haveOverlay = false;

class LockOverlayDialog {
  static LockOverlayDialog? _instance;
  final ValueNotifier<OverlayEntry?> _overlayEntry = ValueNotifier(null);

  LockOverlayDialog._internal() {
    _instance = this;
  }

  factory LockOverlayDialog() => _instance ?? LockOverlayDialog._internal();

  void showCustomOverlay({
    bool forceOverlay = false,
    required Widget child,
  }) {
    if (forceOverlay) closeOverlay();
    if (_haveOverlay) return;
    OverlayState? overlayState =
        AppRouter().mainNavigatorKey!.currentState?.overlay;
    if (overlayState == null) return;

    final _myoverlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return child;
      },
    );
    _overlayEntry.value = _myoverlayEntry;

    overlayState.insert(_overlayEntry.value!);
    _haveOverlay = true;
  }

  closeOverlay() {
    if (_overlayEntry.value == null) return;
    _haveOverlay = false;
    _overlayEntry.value!.remove();
    _overlayEntry.value = null;
  }
}
