import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/singnup.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  String _value = '';

  // String Gender(){
  //   return _value;
  // }
  setUserdetials() async {
    final SharedPreferences Prefers = await SharedPreferences.getInstance();

    Prefers.setString('GenderValue', _value);
   
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio(
              value: 'Male',
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value!;
                    setUserdetials() ;
                });
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Male')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'Female',
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value!;
                    setUserdetials() ;
                });
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Female')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 'Others',
              groupValue: _value,
              onChanged: (value) {
                setState(() {
                  _value = value!;
                    setUserdetials() ;
                });
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text('Others')
          ],
        )
      ],
    );
  }
}
