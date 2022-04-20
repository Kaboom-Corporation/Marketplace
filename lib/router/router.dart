import 'package:flutter/material.dart';
import 'package:marketplace/pages/landing_page.dart';
import 'package:marketplace/router/purchaser_rouer.dart';

const String purchaserPath = '/purchaser';

Route<dynamic>? routGenerator(RouteSettings settings) {
  if (settings.name == null) {
    return MaterialPageRoute(builder: (_) => const LandingPage(), settings: const RouteSettings(name: '/'));
  }
  if (settings.name!.split('/')[1] == 'purchaser') {
    return purchaserRoutGenerator(settings);
  }

  return MaterialPageRoute(builder: (_) => const LandingPage(), settings: const RouteSettings(name: '/'));
}

class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutExpo,
      ),
      child: child,
    );
  }
}
