import 'package:flutter/material.dart';
import 'package:loginform/string.dart';

// ignore: camel_case_types
class passwordfield extends StatefulWidget {
final TextEditingController controller;
final  String labelname;
  const passwordfield({
    Key? key,
    required this.controller,
    required this.labelname,
    
  }) : super(key: key);


  @override
  State<passwordfield> createState() => _passwordfieldState();
}

// ignore: camel_case_types
class _passwordfieldState extends State<passwordfield> {
  bool abscurepassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value!.whitespace()) {
            return ' This is requried field';
          }
        },
        obscureText: abscurepassword,
        // keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          label: Text(widget.labelname),
          hintText: 'Password',
          helperText: '',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  abscurepassword = !abscurepassword;
                });
              },
              icon: Icon(
                  abscurepassword ? Icons.visibility : Icons.visibility_off)),
        ));
  }
}
 
