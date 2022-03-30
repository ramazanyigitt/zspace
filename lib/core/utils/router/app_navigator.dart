import 'package:flutter/material.dart';

class AppNavigator {
  static Future<T> push<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => child,
    ));
    return result;
  }

  static Future<T> pushWithFadeIn<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => child,
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.3;
          const end = 1.0;
          const curve = Curves.ease;

          final tween = Tween<double>(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return FadeTransition(
            opacity: tween.animate(curvedAnimation),
            child: child,
          );
        },
      ),
    );
    return result;
  }

  static Future<T> pushWithOutAnim<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => child,
        transitionDuration: Duration.zero,
      ),
    );
    return result;
  }

  static Future<T> pushReplacement<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result =
        await Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => child,
    ));
    return result;
  }

  static Future<T> pushAndRemoveUntil<T>({
    required BuildContext context,
    required Widget child,
  }) async {
    final result = await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => child,
        ),
        (route) => false);
    return result;
  }
}
