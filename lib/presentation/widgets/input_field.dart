import 'package:flutter/material.dart';
import 'package:micros_app/env.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  late String? hintText;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  late IconData? icon;
  late double? width;
  late int? maxLines;
  late String? initialValue;
  late bool? enabled;

  InputField(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.initialValue,
      this.icon,
      this.enabled,
      this.onChanged,
      this.controller,
      this.onSaved,
      this.validator,
      this.width,
      this.maxLines,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    width ??= size.width * 0.8;
    initialValue ??= '';
    maxLines ??= 1;
    enabled ??= true;
    hintText ??= '';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: width,
      child: TextFormField(
        enabled: enabled,
        initialValue: initialValue,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
        controller: controller,
        onChanged: onChanged,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          suffixIcon: icon == null
              ? null
              : Icon(
                  icon,
                  color: primaryColor,
                ),
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
