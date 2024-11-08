import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkboxfield extends StatefulWidget {
  const Checkboxfield({super.key});

  @override
  State<Checkboxfield> createState() => _CheckboxfieldState();
}

class _CheckboxfieldState extends State<Checkboxfield> {
  bool tamil = false;
  bool English = false;
  bool Hindi = false;
  bool Others = false;
  List<String> Selectecd = [];
 

 void setlanguages()async{
  final SharedPreferences Prefers = await SharedPreferences.getInstance();

    Prefers.setStringList('languages', Selectecd);
 }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckboxListTile(
          value: tamil,
          onChanged: (value) {
            setState(() {
              tamil = value!;
              if (value == true) {
                Selectecd.add('tamil');
              } else {
                Selectecd.remove('tamil');
              }
              setlanguages();
           
            });
          },
          title: Text('Tamil'),
        ),
        CheckboxListTile(
          value: English,
          onChanged: (value) {
            setState(() {
              English = value!;
              if (value == true) {
                Selectecd.add('English');
              } else {
                Selectecd.remove('English');
              }
              setlanguages();
              
            });
          },
          title: Text('English'),
        ),
        CheckboxListTile(
          value: Hindi,
          onChanged: (value) {
            setState(() {
              Hindi = value!;
              if (value == true) {
                Selectecd.add('Hindi');
              } else {
                Selectecd.remove('Hindi');
              }
              setlanguages();
            });
          },
          title: Text('Hindi'),
        ),
        CheckboxListTile(
          value: Others,
          onChanged: (value) {
            setState(() {
              Others = value!;
              if (value == true) {
                Selectecd.add('others');
              } else {
                Selectecd.remove('others');
              }
              setlanguages();
            });
          },
          title: Text('Others'),
        )
      ],
    );
  }
}
