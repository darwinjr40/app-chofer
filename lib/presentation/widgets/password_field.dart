import 'package:flutter/material.dart';
import 'package:micros_app/env.dart';

// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  late String? hintText;
  late String? labelText;
  late double? width;

  PasswordField(
      {Key? key,
      this.labelText,
      this.hintText,
      this.width,
      this.onChanged,
      this.controller,
      this.onSaved,
      this.validator})
      : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _mostrar = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.width ??= size.width * 0.8;
    widget.hintText ??= 'Contraseña';
    widget.labelText ??= 'Contraseña';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: widget.width,
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: !_mostrar,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          /*icon: const Icon(
            Icons.lock,
            color: Colors.red,
          ),*/
          suffixIcon: IconButton(
            icon: Icon(!_mostrar ? Icons.visibility : Icons.visibility_off,
                color: primaryColor),
            onPressed: () {
              setState(() {
                _mostrar = !_mostrar;
              });
            },
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
