import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:micros_app/business/router/app_routes.dart';
import 'package:micros_app/data/services/services.dart';

void main() {
  runApp(const AppState());
}

// ! Aqui declaro los providers para que esten lo mas alto del arbol de widgets

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

// ! Aqui declaro las routas usando el archivo app_routes y la llave de mensajeria

// * El tema de la app lo puse estatico con Light, si alguin quiere se da el tiempo y hace un personalizado

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Micros Online',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData.light(),
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}
