import 'package:flutter/material.dart';

TextFormField formfield(onchange, validater, contoller) {
  return TextFormField(
    onChanged: (value) {
      onchange;
    },
    validator: validater,
    controller: contoller,

    // maxLength: 10,

    decoration: InputDecoration(
        focusColor: Colors.green,
        labelText: 'ClientName',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300)),
        errorStyle: TextStyle(color: Colors.red.shade300),
        prefixIcon: Icon(Icons.phone),
        // suffixIcon: Icon(Icons.done),

        hintText: 'Enter the Client Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        hintStyle: TextStyle(fontSize: 13.0),
        border: OutlineInputBorder()),
  );
}
