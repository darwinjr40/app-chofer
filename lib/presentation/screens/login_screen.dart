import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/presentation/widgets/widgets.dart';
import 'package:micros_app/presentation/helpers/mostrar_alerta.dart';
import 'package:micros_app/business/providers/providers.dart';
import 'package:micros_app/env.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 170,
              ),
              CardContainer(
                child: Column(
                  children: [
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 10),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const ImageCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final Color mainColor = const Color.fromARGB(255, 12, 17, 156);

  final Color labelColor = Colors.grey;

  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    loginForm.email = 'jaldin@gmail.com';
    loginForm.password = '123';
    TextEditingController _emailController =
        TextEditingController(text: 'jaldin@gmail.com');
    TextEditingController _passwordController =
        TextEditingController(text: '123');
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          //Email Input
          TextFormField(
            enabled: loginForm.isLoading ? false : true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              ),
              hintText: "ejemplo123@gmail.com",
              labelText: "Correo Electronico",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
                color: mainColor,
              ),
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no tiene formato de correo';
            },
          ),
          const SizedBox(height: 30),

          //Password Input
          TextFormField(
            enabled: loginForm.isLoading ? false : true,
            autocorrect: false,
            obscureText: _passwordVisible,
            controller: _passwordController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,
                ),
              ),
              labelText: "Contraseña",
              labelStyle: TextStyle(color: labelColor),
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: mainColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: labelColor,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            onChanged: (value) => loginForm.password = value,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: mainColor,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 70,
                vertical: 15,
              ),
              child: Text(
                loginForm.isLoading ? 'Verificando...' : 'Ingresar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            onPressed: loginForm.isLoading
                ? null
                // : () => Navigator.pushReplacementNamed(context, 'home')

                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
                    final String? errorMessage = await authService.login(
                        loginForm.email, loginForm.password);

                    if (errorMessage == null) {
                      //*Navegar a otra pantalla
                      // Navigator.pushReplacementNamed(context, 'home');
                      Navigator.pushReplacementNamed(context, 'selectBus');
                    } else {
                      //*Mostrar mensaje de Error
                      mostrarAlerta(context, 'Login incorrecto', errorMessage);
                      // NotificationsService.showSnackbar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'register'),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(primaryColor)),
            child: const Text(
              'Crear una nueva cuenta',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
