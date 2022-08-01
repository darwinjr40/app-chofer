import 'package:flutter/material.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/env.dart';
import 'package:micros_app/presentation/screens/screens.dart';
import 'package:provider/provider.dart';

class BtnLogOut extends StatelessWidget {
  final Function stopTimer;
  const BtnLogOut({Key? key, required this.stopTimer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);
    if (service.isActive) {
      return GetContainerT(
        stopTimer: stopTimer,
        service: service,
      );
    } else {
      return GetContainerfalse(
        service: service,
      );
    }
  }
}

class GetContainerfalse extends StatelessWidget {
  const GetContainerfalse({
    Key? key,
    required this.service,
  }) : super(key: key);

  final AuthService service;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: CircleAvatar(
        backgroundColor: Colors.black,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
            service.loguot();
          },
        ),
      ),
    );
  }
}

class GetContainerT extends StatelessWidget {
  final Function stopTimer;
  final AuthService service;

  const GetContainerT({
    Key? key,
    required this.stopTimer,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: CircleAvatar(
        backgroundColor: Colors.red.withOpacity(0.9),
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            service.setActive();
            showLoguotDialog(context, service, stopTimer);
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
                child: const Text('ENVIAR'),
              ),
            ],
          ));
}
