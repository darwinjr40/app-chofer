import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:micros_app/env.dart';
// import 'package:uber_clone_flutter_udemy/src/utils/colors.dart' as utils;
import 'package:micros_app/presentation/widgets/widgets.dart';

class DriverTravelRequestPage extends StatefulWidget {
  const DriverTravelRequestPage({Key? key}) : super(key: key);

  @override
  _DriverTravelRequestPageState createState() => _DriverTravelRequestPageState();
}

class _DriverTravelRequestPageState extends State<DriverTravelRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _bannerClientInfo(),
          _textFromTo('Carrera falsa con calle falsa', 'Carrera falsa con calle falsa'),
          _textTimeLimit()
        ],
      ),
      bottomNavigationBar: _buttonsAction(),
    );
  }

  Widget _buttonsAction() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: BtnSolicit(
              onPressed: () {},
              text: 'Cancelar',
              color: Colors.red,
              textColor: Colors.white,
              icon: Icons.cancel_outlined,
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: BtnSolicit(
              onPressed: () {},
              text: 'Aceptar',
              color: Colors.cyan,
              textColor: Colors.white,
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textTimeLimit() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: const Text(
          '0',
        style: TextStyle(
          fontSize: 50
        ),
      ),
    );
  }

  Widget _textFromTo(String from, String to) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Recoger en',
            style: TextStyle(
              fontSize: 20
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              from,
              style: const TextStyle(
                fontSize: 17
              ),
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'LLevar a',
            style: TextStyle(
              fontSize: 20
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              from,
              style: const TextStyle(
                fontSize: 17
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bannerClientInfo() {
    return ClipPath(
      clipper: WaveClipperOne(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        color: uberCloneColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/profile.jpg'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: const Text(
                'Tu cliente',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
