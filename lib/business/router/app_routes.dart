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
    MenuOption(
      route: 'gpsAccess',
      name: 'GPS Access Screen',
      screen: const GpsAccessScreen(),
      icon: Icons.gps_fixed,
    ),
    MenuOption(
      route: 'map',
      name: 'Map Screen',
      screen: const MapScreen(),
      icon: Icons.map_outlined,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'login': (BuildContext context) => const LoginScreen()});
    appRoutes
        .addAll({'loading': (BuildContext context) => const LoadingScreen()});
    appRoutes.addAll(
        {'checking': (BuildContext context) => const CheckAuthScreen()});

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    appRoutes.addAll(
        {'selectBus': (BuildContext context) => const SelectBusScreem()});
    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
