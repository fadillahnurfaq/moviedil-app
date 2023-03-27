import "package:flutter/material.dart";

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static to({required Widget page}) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  static get currentContext {
    return navigatorKey.currentContext;
  }

  static off({required Widget page}) {
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  static back() {
    Navigator.pop(currentContext);
  }

  static offAll({required Widget page}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (Route<dynamic> route) => false,
    );
  }

  static double get width {
    return MediaQuery.of(currentContext).size.width;
  }

  static double get height {
    return MediaQuery.of(currentContext).size.height;
  }
}
