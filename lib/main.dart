import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/business/router/app_routes.dart';
import 'package:micros_app/data/services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(
    // ! Declaro los Bloc que se pueden usar en toda la app
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(
            create: (context) =>
                MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(create: (context) => VehicleBloc()),
      ],
      child: const AppState(),
    ),
  );
}

// ! Aqui declaro los providers para que esten lo mas alto del arbol de widgets

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => RecorridoService()),
        ChangeNotifierProvider(create: (_) => VehicleService()),
      ],
      child: const MyApp(),
    );
  }
}

// ! Aqui declaro las routas usando el archivo app_routes y la llave de mensajeria

// * El tema de la app lo puse estatico con Light, si alguin quiere se da el tiempo y hace un personalizado

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =  GlobalKey<ScaffoldMessengerState>();
    
  @override
  void initState() {
    super.initState();
  // Context!
      PushNotificationService.messagesStream.listen((message) { 
        // print('MyApp: $message');
        navigatorKey.currentState?.pushNamed('message', arguments: message);        
        final snackBar = SnackBar(content: Text(message));
        messengerKey.currentState?.showSnackBar(snackBar);
      }); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Micros Online',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeData.light(),
      // scaffoldMessengerKey: NotificationsService.messengerKey,
      scaffoldMessengerKey: messengerKey, // Snacks
      navigatorKey: navigatorKey, // Navegar
    );
  }
}
