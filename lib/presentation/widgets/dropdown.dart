import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  String? labelText;
  String? value;
  int? selectedItem;
  double? width;
  List<String>? items;

  Dropdown({Key? key, this.width, required this.items, this.labelText})
      : super(key: key) {
    value = items![0];
    selectedItem = 0;
  }

  @override
  _DropdownState createState() => _DropdownState();

  int? posValue(String? newValue) {
    for (int i = 0; i < items!.length; i++) {
      if (newValue == items![i]) return i;
    }
    return -1;
  }
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    widget.width ??= size.width * 0.8;
    widget.labelText ??= '';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: widget.width,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          /*suffixIcon: icon == null
                ? null
                : Icon(
              icon,
              color: primaryColor,
            ),*/
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
        ),
        items: widget.items!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedItem = widget.posValue(newValue);
            widget.value = newValue!;
          });
        },
        value: widget.value,
        isExpanded: true,
        elevation: 16
      ),
    );
  }
}
