import 'package:flutter/material.dart';

class DriverTravelMapController {

  late BuildContext context;
  late GlobalKey<ScaffoldState> key =  GlobalKey();
  late Function refresh;


  void init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

}