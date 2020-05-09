import 'package:flutter/cupertino.dart';

class NavigationService {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  bool pop() {
    return navigatorKey.currentState.pop();
  }
}
