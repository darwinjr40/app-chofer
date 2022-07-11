import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micros_app/env.dart';

class DateField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const DateField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.icon = Icons.calendar_today,
      this.onSaved,
      this.validator,
      required this.controller})
      : super(key: key);

  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        child: TextFormField(
            onTap: () => _selectDate(context),
            readOnly: true,
            validator: widget.validator,
            onSaved: widget.onSaved,
            enabled: true,
            controller: widget.controller,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              suffixIcon: Icon(
                widget.icon,
                color: primaryColor,
              ),
              labelText: widget.labelText,
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
            )));
  }

  Future _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
