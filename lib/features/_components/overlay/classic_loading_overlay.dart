import 'package:flutter/material.dart';

import '../../../shared/app_theme.dart';

class ClassicLoadingOverlay extends StatelessWidget {
  final ValueNotifier<OverlayEntry?> overlayEntry;
  ClassicLoadingOverlay({
    required this.overlayEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      right: 0,
      child: SafeArea(
        child: Material(
          color: Colors.black26,
          child: Center(
            child: Center(
              child: Container(
                width: 48,
                height: 48,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.transparent,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme().whiteColor),
                  strokeWidth: 3.25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(
      {required double width,
      required double height,
      EdgeInsets margin = EdgeInsets.zero,
      required String imgUrl}) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/$imgUrl',
        fit: BoxFit.cover,
      ),
    );
  }
}
