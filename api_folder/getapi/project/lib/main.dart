/* import 'package:flutter/material.dart';
import 'package:project/apipractice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ), 
      home: GetExcersice(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() { 
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
        title: Text(widget.title),
      ),
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<ContainerWidget> containers = [];
//   @override
//   void initState() {
//     super.initState();
//     containers.add(ContainerWidget(
//       removeContainer: removeContainer,
//     ));
//   }

//   void addContainer() {
//     if (containers.length < 3) {
//       setState(() {
//         containers.add(ContainerWidget(
//           removeContainer: removeContainer,
//         ));
//       });
//     }
//   }

//   void removeContainer(int index) {
//     if (containers.length > 1) {
//       setState(() {
//         containers.removeAt(index);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dynamic Containers Example'),
//       ),
//       body: ListView(
//         children: containers
//             .asMap()
//             .entries
//             .map(
//               (entry) => Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: entry.value,
//               ),
//             )
//             .toList(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           addContainer();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class ContainerWidget extends StatelessWidget {
//   final Function(int) removeContainer;

//   ContainerWidget({required this.removeContainer});
//   List<ContainerWidget> containers = [];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue, width: 2.0),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         children: [
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Text Field 1'),
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Text Field 2'),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Checkbox'),
//               IconButton(
//                 icon: Icon(Icons.delete),
//                 onPressed: () {
//                   final state =
//                       context.findAncestorStateOfType<_MyHomePageState>();
//                   state?.removeContainer(containers.indexOf(this));
//                 },
//               ),
//             ],
//           ),
//           Checkbox(
//             value: false,
//             onChanged: (value) {
//               // Handle checkbox state here
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bidContainerWidget> containers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> priceControllers = [];
  List<TextEditingController> totalControllers = [];

  double highestTotal = 0.0;

  @override
  void initState() {
    super.initState();

    containers.add(bidContainerWidget(
      index: 0,
      removeContainer: removeContainer,
      calculateHighestTotal: calculateHighestTotal,
    ));
  }

  void addContainer() {
    if (containers.length < 3) {
      setState(() {
        containers.add(bidContainerWidget(
          index: containers.length,
          removeContainer: removeContainer,
          calculateHighestTotal: calculateHighestTotal,
        ));
      });
    }
  }

  void removeContainer(int index) {
    if (containers.length > 1) {
      setState(() {
        // Clear the text from the controllers instead of disposing them
        containers[index].clearControllers();
        containers.removeAt(index);

        // Update the indices of the remaining containers
        for (int i = index; i < containers.length; i++) {
          containers[i].updateIndex(i);
        }

        calculateHighestTotal();
      });
    }
    // else if (containers.length == 1) {
    //   // If only one container is left, clear its text controllers instead of removing it
    //   containers[0].clearControllers();
    // }
  }

  Color? highestColor;
  void calculateHighestTotal() {
    double highest = 0.0;
    for (var container in containers) {
      double total = double.tryParse(container.totalController.text) ?? 0.0;
      if (total > highest) {
        highest = total;
        setState(() {
          if (highest <= 200000) {
            highestColor = Colors.green;
          } else {
            highestColor = Colors.red;
          }
        });
      }
    }
    setState(() {
      highestTotal = highest;
    });
  }

  void resetCheckbox() {
    bool checkbox = false;
    setState(() {
      checkbox = false; // Reset the checkbox to false
    });
  }

  List bidList = [];
  Map qpvalues = {};
  void printControllerValues() {
    int count = 1;
    bidList.clear();

    for (var container in containers) {
      final quantityController = container.quantityController;
      final priceController = container.priceController;
      final totalController = container.totalController;

      if (quantityController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        qpvalues['quantity$count'] = quantityController.text;
        qpvalues['price$count'] = priceController.text;
        count++;
        bidList.add(qpvalues);
        qpvalues = {};
      }

      // Clear the controllers for this container
      quantityController.clear();
      priceController.clear();
      totalController.clear();
    }
    print(bidList);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (containers.isEmpty) {
      containers.add(bidContainerWidget(
        index: 0,
        removeContainer: removeContainer,
        calculateHighestTotal: calculateHighestTotal,

        // Pass the callback
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Containers Example'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 600,
                child: ListView(
                  children: containers
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: entry.value,
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                height: 40.0,
                color: Colors.grey.shade300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Amount payable: '),
                    Text(
                      '$highestTotal',
                      style: TextStyle(
                          color: highestColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addContainer();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Validation passed, proceed with posting data
                  if (highestTotal <= 200000.00) {
                    printControllerValues();
                    resetCheckbox();

                    setState(() {
                      highestTotal = 0.0;
                    });
                  } else {
                    print('Not valid');
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
