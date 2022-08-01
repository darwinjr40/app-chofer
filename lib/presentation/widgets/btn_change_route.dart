import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/blocs.dart';

class BtnChangeRoute extends StatelessWidget {
  const BtnChangeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.repeat_on_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            mapBloc.add(OnshowVehicleRoute());
          },
        ),
      ),
    );
  }
}
