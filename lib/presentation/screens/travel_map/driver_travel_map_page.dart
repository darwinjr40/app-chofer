import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:micros_app/presentation/screens/travel_map/driver_travel_map_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:micros_app/presentation/widgets/btn_solicit.dart';


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

    return Scaffold(
      key: _con.key,
      body: Stack(
        children: [
          _googleMapsWidget(),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buttonUserInfo(),
                    Column(
                      children: [
                        _cardKmInfo('0'),
                        _cardMinInfo('0')
                      ],
                    ),

                    _buttonCenterPosition(),
                  ],
                ),
                Expanded(child: Container()),
                _buttonStatus()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cardKmInfo(String km) {
    return SafeArea(
        child: Container(
          width: 110,
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: const Text(
            'km',
            // '${km ?? ''} km',
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        )
    );
  }


  Widget _cardMinInfo(String min) {
    return SafeArea(
        child: Container(
          width: 110,
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: const Text(
            // '${min ?? ''} seg',
            'seg',
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        )
    );
  }

  Widget _buttonUserInfo() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonCenterPosition() {
    return GestureDetector(
      onTap: _con.centerPosition,
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          shape: const CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.location_searching,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonStatus() {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: BtnSolicit(
        onPressed: () {},
        text: 'INICIAR VIAJE',
        color: Colors.amber,
        textColor: Colors.black,
      ),
    );
  }

  Widget _googleMapsWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_con.markers.values),
    );
  }

  void refresh() {
    setState(() {});
  }
}
