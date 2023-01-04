import 'package:flutter/material.dart';
import 'package:micros_app/presentation/screens/travel_map/driver_travel_map_controller.dart';
import 'package:flutter/scheduler.dart';


class DriverTravelMapPage extends StatefulWidget {
  const DriverTravelMapPage({Key? key}) : super(key: key);

  @override
  DriverTravelMapPageState createState() => DriverTravelMapPageState();
}

class DriverTravelMapPageState extends State<DriverTravelMapPage> {

  final DriverTravelMapController _con = DriverTravelMapController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('PANTALLA DEL MAPA'),),
    );
  }

  void refresh() {
    setState(() {});
  }
}
