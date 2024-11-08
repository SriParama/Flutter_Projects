// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginform/string.dart';

class NameField extends StatefulWidget {
  final TextEditingController controller;
  const NameField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        if (!value!.validName()) {
          return ' Enter the valid name ';
        }
      },

      decoration: const InputDecoration(
        
        label: Text('Name'),
        helperText: '',
        hintText: 'John Doe',
      ),
    );
  }
}
