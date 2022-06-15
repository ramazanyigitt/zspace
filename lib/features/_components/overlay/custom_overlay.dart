import 'package:flutter/material.dart';
import '../../../core/utils/router/app_router.dart';

import 'classic_loading_overlay.dart';

//* This custom service is a base service for new services.
//* To provide easy use applications's main overlay to show dialogs top of ui.

abstract class CustomOverlay {
  bool haveOverlay = false;
  final ValueNotifier<OverlayEntry?> _overlayEntry = ValueNotifier(null);

  Widget customOverlayWidget(ValueNotifier<OverlayEntry?> _overlayEntry,
      {Function()? onTap, List<dynamic>? params}) {
    return ClassicLoadingOverlay(
      overlayEntry: _overlayEntry,
    );
  }

  void showCustomOverlay(
      {bool addFrameCallback: false,
      Function()? onTap,
      List<dynamic>? params}) {
    if (haveOverlay) return;

    if (addFrameCallback) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        showCustomOverlay(onTap: onTap, params: params);
      });
      return;
    }

    OverlayState? overlayState =
        AppRouter().mainNavigatorKey!.currentState?.overlay;
    if (overlayState == null) return;

    final _myoverlayEntry = OverlayEntry(
        builder: (_) =>
            customOverlayWidget(_overlayEntry, onTap: onTap, params: params));
    _overlayEntry.value = _myoverlayEntry;

    overlayState.insert(_overlayEntry.value!);
    haveOverlay = true;
  }

  void closeCustomOverlay() {
    if (_overlayEntry.value == null) return;
    haveOverlay = false;
    _overlayEntry.value!.remove();
    _overlayEntry.value = null;
  }
}
