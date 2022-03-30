import 'package:flutter/material.dart';

typedef AppRoute = Route Function(
  RouteSettings routeSettings,
);

class AppRouter {
  static AppRouter _instance = AppRouter._();

  AppRouter._();

  factory AppRouter() => _instance;

  late TabController tabController;
  GlobalKey<NavigatorState>? mainNavigatorKey = GlobalKey();
}
