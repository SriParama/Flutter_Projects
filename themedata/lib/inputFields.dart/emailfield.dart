import 'package:flutter/material.dart';
import 'package:loginform/string.dart';


class Emailfield extends StatefulWidget {
 final TextEditingController controller;
  const Emailfield({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<Emailfield> createState() => _EmailfieldState();
}
class _EmailfieldState extends State<Emailfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        
        // if (value!.validEmail()) {
        //     return ' Enter the valid e-mail ';
        // }
      },
      decoration: const InputDecoration(
        label: Text('E-mail'),
        hintText: 'Help@gmail.com',
        helperText: ''
      ),
    );
  }
}