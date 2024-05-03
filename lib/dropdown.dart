import 'package:flutter/material.dart';

class dropdown extends StatefulWidget {
  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  String dropDownValue = 'one';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: DropdownButton(
        value: dropDownValue,
        icon: Icon(Icons.arrow_drop_down),
        onChanged: (Newvalue) {
          setState(() {
            dropDownValue = Newvalue!;
          });
        },
        items: [
          DropdownMenuItem(
            value: 'one',
            child: Text('one'),
          ),
          DropdownMenuItem(
            value: 'two',
            child: Text('two'),
          ),
          DropdownMenuItem(
            value: 'three',
            child: Text('three'),
          )
        ],
      )),
    );
  }
}
