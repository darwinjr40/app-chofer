import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/data/services/services.dart';
// import 'package:uber_clone_flutter_udemy/src/models/client.dart';
// import 'package:uber_clone_flutter_udemy/src/providers/client_provider.dart';
// import 'package:uber_clone_flutter_udemy/src/utils/shared_pref.dart';

class DriverTravelRequestController {

  late BuildContext context;
  late GlobalKey<ScaffoldState> key =  GlobalKey();
  late Function refresh;
  late MapBloc mapBloc;

  // SharedPref _sharedPref;

  late String from;
  late String to;
  late String idClient;

  late Timer _timer;
  int seconds = 30;
  // ClientProvider _clientProvider;
  DriverTravelRequestController(){
    from = '';
    to = '';
    idClient = '';

  }
  void init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    mapBloc = BlocProvider.of<MapBloc>(context);
    
    // _sharedPref = new SharedPref();
    // _sharedPref.save('isNotification', 'false');

    // _clientProvider = new ClientProvider();
    try {
      Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      print('Arguments: $arguments');
      from = arguments['origin'];
      to = arguments['destination'];
      idClient = arguments['tokenClient'];
      getClientInfo();  
      startTimer();    
    } catch (error) {
      debugPrint("TRY ERROR  <DriverTravelRequestController> init:  $error");
    }
  }

  void dispose(){
    _timer.cancel();
  }
  void  startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1),  (timer){
      seconds =  seconds - 1; 
      refresh();
      if (seconds == 0) {
        cancelTravel();
      }
    });
  }
  void acceptTravel() {
    try {
      Map<String, String> data = {
        // 'idDriver': _authProvider.getUser().uid,
        'idDriver': mapBloc.state.driver!.id.toString(),
        'status': 'accepted'
      };      
      TravelInfoService.update(data, idClient);
      // Navigator.pushNamedAndRemoveUntil(context, 'driver/travel/map', (route) => false);      
      Navigator.pushNamed(context,'drive/travel/map' );

    } catch (error) {
      debugPrint('ERROR catch <DriverTravelRequestController> acceptTravel ${error.toString()}');
    }
  }

   void cancelTravel() {
    try {
      Map<String, String> data = {
        'status': 'no_accepted'
      };      
      TravelInfoService.update(data, idClient);
      Navigator.pushNamedAndRemoveUntil(context, 'loading', (route) => false);      
      // Navigator.pushNamedAndRemoveUntil(context, 'driver/travel/map', (route) => false);      
      // Navigator.pushNamed(context,'drive/travel/map' );
    } catch (error) {
      debugPrint('ERROR catch <DriverTravelRequestController> cancelTravel ${error.toString()}');
    }
  }
  void getClientInfo() async {
    // client = await _clientProvider.getById(idClient);
    // print('Client: ${client.toJson()}');
    refresh();
  }

}