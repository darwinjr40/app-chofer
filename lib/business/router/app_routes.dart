import 'package:flutter/material.dart';

import 'package:micros_app/data/models/models.dart';
import 'package:micros_app/presentation/screens/screens.dart';
import 'package:micros_app/presentation/views/status_view.dart';

class AppRoutes {
  // static const initialRoute = 'drive/travel/map';

  static const initialRoute = 'login';
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
        {'selectBus': (BuildContext context) => const SelectBusScreen()});
    appRoutes.addAll({
      'selectVehicle': (BuildContext context) => const SelectVehicleScreen()
    });
    appRoutes
        .addAll({'register': (BuildContext context) => const RegisterScreen()});
    appRoutes.addAll({'status': (BuildContext context) => const StatusView()});
    appRoutes.addAll({'drive/travel/request': (BuildContext context) => const DriverTravelRequestPage()});
    appRoutes.addAll({'drive/travel/map': (BuildContext context) => const DriverTravelMapPage()});

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
