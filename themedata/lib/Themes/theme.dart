import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Color.fromARGB(255, 245, 12, 12);
  Color darkprimarycolor = Color.fromARGB(255, 60, 255, 0);

  static ThemeData lighttheme = ThemeData(
    primarySwatch: Colors.yellow,
    brightness: Brightness.light,
    inputDecorationTheme: ThemeClass().theme(),

// colorScheme: ColorScheme(brightness: Brightness.light, primary:ThemeClass().lightPrimaryColor, onPrimary: Colors.black, secondary: Colors.white38, onSecondary: Colors.red, error: Colors.red, onError: Colors.redAccent, background: Colors.grey.shade600, onBackground: Colors.white24, surface: Colors.green.shade100, onSurface: Colors.lightGreen.shade300)

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     elevation: 10.0,
    //     minimumSize: Size(double.infinity,60.0),

    //     // maximumSize: Size(40, 60),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(50),
    //         side: const BorderSide(color: Colors.black, width: 1.5)),
    //         textStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,)
    //         ,foregroundColor: Color(0xFFF12a321),// text color
    //   ),
    // ),
  );
  static ThemeData Darktheme = ThemeData(
      primarySwatch: Colors.red,
      brightness: Brightness.dark,
      inputDecorationTheme: ThemeClass().theme());

  TextStyle _textStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  OutlineInputBorder _inputborder(Color color) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 2.0, color: color));
  }

  InputDecorationTheme theme() => InputDecorationTheme(
        disabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(width: 1.5)),
        contentPadding: const EdgeInsets.all(10.0),
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: const BoxConstraints(maxWidth: 150.0),
        enabledBorder: _inputborder(Colors.blueGrey),
        errorBorder: _inputborder(Colors.red),
        focusedBorder: _inputborder(Colors.amber),
        // border: _inputborder(const Color.fromARGB(255, 156, 156, 151)),
        // focusedErrorBorder: _inputborder(Colors.yellow),
        // disabledBorder: _inputborder(Colors.grey.shade600),
        suffixIconColor: Colors.lightBlueAccent,
        suffixStyle: _textStyle(Colors.black),
        counterStyle: _textStyle(Colors.grey, size: 12),
        floatingLabelStyle: _textStyle(Colors.orangeAccent),
        errorStyle: _textStyle(Colors.red, size: 12.0),
        helperStyle: _textStyle(Colors.red),
        hintStyle: _textStyle(Colors.orange),
        labelStyle:
            _textStyle(const Color.fromARGB(255, 241, 109, 109), size: 20.0),
      );
}

ThemeClass _themeClass = ThemeClass();
