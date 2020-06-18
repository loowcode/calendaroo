import 'package:flutter/cupertino.dart';

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  void pop() {
    return navigatorKey.currentState.pop();
  }
}
