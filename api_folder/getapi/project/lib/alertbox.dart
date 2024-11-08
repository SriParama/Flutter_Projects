import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  void showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Snackbar content'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snackbar Outside AlertDialog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('AlertDialog'),
                  content: Text('This is an AlertDialog'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showSnackbar(context);
                      },
                      child: Text('Close & Show Snackbar'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Show AlertDialog'),
        ),
      ),
    );
  }
}
