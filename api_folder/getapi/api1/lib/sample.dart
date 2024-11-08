import 'package:flutter/material.dart';


class app extends StatefulWidget {
  const app({super.key});

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Social Media'),
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.notifications)],
      ),
      


      body: SafeArea(child: Column(children: [
        ListView(children: [
          Row(children: [
            Text('data')
            
          ],)
        ],)



        
      ],))
     
    


    );
  }
}