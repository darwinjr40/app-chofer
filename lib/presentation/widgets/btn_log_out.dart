import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_app/data/blocs/blocs.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/env.dart';
// import 'package:micros_app/presentation/screens/screens.dart';
import 'package:provider/provider.dart';

class BtnLogOut extends StatelessWidget {
  final Function stopTimer;
  // , required this.stopTimer
  const BtnLogOut({Key? key, required this.stopTimer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context, listen: false);
    bool sw = service.isActive;
    
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: CircleAvatar(
        backgroundColor: (sw) ?  Colors.red.withOpacity(0.9) : Colors.black,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            if (sw) {
              debugPrint('GetContainerT');
              service.setActive(false);
              showLoguotDialog(context, service, stopTimer);
              debugPrint('GetContainerT1');              
            } else {
              debugPrint('GetContainerfalse-------------');
              service.loguot();
              locationBloc.add(OnStopFollowingUser());
              // stopFollowingUser
              Navigator.pushReplacementNamed(context, 'login');
              debugPrint('GetContainerfalse1-------------');
            }
          },
        ),
      ),
    );
  }
}


void showLoguotDialog(
    BuildContext context, AuthService service, Function stopTimer) {
  final _textController = TextEditingController();
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text('TERMINAR VIAJE'),
            content: SizedBox(
              width: 230,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Center(
                    child: Text('Describa por que desea terminar el viaje'),
                  ),
                  TextField(
                    // controller: _textController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0.0))),
                    ),
                    onSubmitted: (value) {},
                    onChanged: (value) => _textController.text = value,
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CANCELAR'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {
                  stopTimer();
                  DriversService.inService(
                      vehicleId: service.vehiculo.id,
                      userId: service.user.id,
                      isLogin: 0,
                      message: _textController.text);
                  service.loguot();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: const Text('ENVIAR'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
              ),
            ],
          ));
}
