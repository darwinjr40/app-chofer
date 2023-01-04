import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';

class DriverTravelCalificationPage extends StatefulWidget {
  const DriverTravelCalificationPage({Key? key}) : super(key: key);

  @override
  DriverTravelCalificationPageState createState() => DriverTravelCalificationPageState();
}

class DriverTravelCalificationPageState extends State<DriverTravelCalificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buttonCalificate(),
      body: Column(
        children: [
          _bannerPriceInfo(),
          _listTileTravelInfo('Desde', 'Cr falsa con calle Falsa', Icons.location_on),
          _listTileTravelInfo('Hasta', 'Cr falsa con calle Falsa', Icons.directions_subway),
          const SizedBox(height: 30),
          _textCalificateYourDriver(),
          const SizedBox(height: 15),
          _ratingBar()
        ],
      ),
    );
  }

  Widget _buttonCalificate() {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(30),
      child: BtnSolicit(
        onPressed: () {
          // Navigator.pushNamed(context, 'map');
          Navigator.pushNamed(context, 'map');
        },
        text: 'CALIFICAR',
        color: Colors.black,
      ),
    );
  }

  Widget _ratingBar() {
    return Center(
      child: RatingBar.builder(
          // ignore: prefer_const_constructors
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.black,
          ),
          itemCount: 5,
          initialRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          unratedColor: Colors.grey[300],
          onRatingUpdate: (rating) {
            print('RATING: $rating');
          }
      ),
    );
  }
  
  Widget _textCalificateYourDriver() {
    return const Text(
      'CALIFICA A TU CLIENTE',
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }

  Widget _listTileTravelInfo(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14
          ),
          maxLines: 1,
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14
          ),
          maxLines: 2,
        ),
        leading: Icon(icon, color: Colors.grey,),
      ),
    );
  }

  Widget _bannerPriceInfo() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 280,
        width: double.infinity,
        color: Colors.black38,
        child: SafeArea(
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.grey[800], size: 100),
              const SizedBox(height: 20),
              const Text(
                'TU VIAJE HA FINALIZADO',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Valor del viaje',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '0\$',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight:FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
