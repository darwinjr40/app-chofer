import 'package:flutter/material.dart';

import 'package:micros_app/data/models/models.dart';
import 'package:micros_app/presentation/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'checking';

  static final menuOptions = <MenuOption>[
    MenuOption(
      route: 'home',
      name: 'Home Screen',
      screen: const HomeScreen(),
      icon: Icons.home_max,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'login': (BuildContext context) => const LoginScreen()});
    appRoutes.addAll(
        {'checking': (BuildContext context) => const CheckAuthScreen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
