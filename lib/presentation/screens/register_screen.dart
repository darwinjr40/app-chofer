import 'package:flutter/material.dart';
import 'package:micros_app/env.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String names;
  late String lastNames;
  late String email;
  late String password;
  late String passwordConf;
  late String birthday;
  late String ci;
  late String cellphone;
  late String address;
  late final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController birthController = TextEditingController();
  bool registrando = false;
  Dropdown dropSex = Dropdown(items: const ['Masculino', 'Femenino', 'Otro']);
  Dropdown dropCategory = Dropdown(items: const ['Licencia A', 'Licencia B', 'Licencia C']);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    size = const Size(10, 20);
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Registrarse", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              SizedBox(height: size.height * 0.5),
              SizedBox(
                  height: size.height* 5,
                  child: Image.asset(
                    "assets/micro.png",
                  ),
              ),
              _content(),
              Button(
                    text: 'Registrarse',
                    press: () {
                      // registrar(context);
                    })    
            ],
          )
          ),
        ),
      ),
    );
  }

   Widget _content() {
    return Column(
      children: [
        InputField(
          onSaved: (value) => names = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca sus nombres' : null,
          icon: Icons.text_fields,
          hintText: 'Ejm: Mateo',
          labelText: 'Nombres',
        ),
        InputField(
          onSaved: (value) => lastNames = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca sus apellidos' : null,
          icon: Icons.text_fields,
          labelText: "Apellidos",
          hintText: 'Ejm: Vasquez Montaño',
        ),
        InputField(
          onSaved: (value) => ci = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca un CI valido' : null,
          icon: Icons.account_box,
          keyboardType: TextInputType.number,
          hintText: 'Ejm: 11332980',
          labelText: 'CI',
        ),
        InputField(
          onSaved: (value) => cellphone = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca una numero valido' : null,
          icon: Icons.phone,
          labelText: 'Numero Celular',
          keyboardType: TextInputType.phone,
          hintText: 'Ejm: 75235120',
        ),
        InputField(
          labelText: 'Direccion domicilio',
          hintText: 'Ejm: Av Banzer Calle 4 Norte',
          maxLines: 3,
          icon: Icons.home_work,
          onSaved: (value) => address = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca una direccion' : null,
        ),
        DateField(
          controller: birthController,
          onSaved: (value) => birthday = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca una fecha valida' : null,
          hintText: '01/01/2001',
          labelText: 'Fecha de nacimiento',
        ),
        dropSex,
        dropCategory,
        InputField(
          onSaved: (value) => email = value!,
          validator: (value) =>
              value!.isEmpty ? 'Por favor introduzca una correo valido' : null,
          icon: Icons.alternate_email,
          keyboardType: TextInputType.emailAddress,
          hintText: 'Ejm: email@gmail.com',
          labelText: 'Correo Electronico',
        ),
        PasswordField(
          onSaved: (value) => password = value!,
          validator: (value) =>
              value!.isEmpty ? 'Introduzca una contraseña' : null,
        ),
        PasswordField(
          labelText: "Confirmar contraseña",
          hintText: "Confirmar contraseña",
          onSaved: (value) => passwordConf = value!,
          validator: (value) => value!.isEmpty
              ? 'Introduzca la confirmacion de la contraseña'
              : null,
        ),
      ],
    );
  }

}
