import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> a = ['IND', 'EMP', 'SRHO'];
  List<bool> _checkedItems = List.generate(3, (index) => false);

  void showModelBottomSheet() {
    showModalBottomSheet(
      // backgroundColor: Colors.red,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // itemExtent: 80,
                // padding: EdgeInsets.all(20),
                itemCount: a.length + 1,
                itemBuilder: (context, index) {
                  if (index < a.length) {
                    // ass = Axis.horizontal ;
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200.withOpacity(0.9),
                                offset: const Offset(
                                  5.0,
                                  5.0,
                                ),
                                blurRadius: 20.0,
                                spreadRadius: 10.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(
                                  0.0,
                                  0.0,
                                ),
                                blurRadius: 0.0,
                                spreadRadius: 5.0,
                              ), //BoxShadow
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: isChecked(index),
                                onChanged: (value) {
                                  setState(() {
                                    setChecked(index, value ?? false);
                                  });
                                },
                              ),
                              Text(a[index]),
                            ],
                          ),
                        ),
                      ],
                    );

                    // ListTile(
                    //   title: Text(a[index]),
                    //   trailing: Checkbox(
                    //     value: isChecked(index),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         setChecked(index, value ?? false);
                    //       });
                    //     },
                    //   ),
                    // );
                  } else {
                    return FloatingActionButton.small(
                      onPressed: () {
                        navigateToNextPage();
                      },
                      child: Icon(Icons.navigate_next),
                    );

                    // ElevatedButton(
                    //     onPressed: () {
                    //       navigateToNextPage();
                    //     },
                    //     child: Text('submit'));
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  bool isChecked(int index) {
    return index >= 0 && index < _checkedItems.length
        ? _checkedItems[index]
        : false;
  }

  void setChecked(int index, bool value) {
    setState(() {
      if (index >= 0 && index < _checkedItems.length) {
        _checkedItems[index] = value;
      }
    });
  }

  void navigateToNextPage() {
    List<String> selectedItems = [];
    for (int i = 0; i < a.length; i++) {
      if (isChecked(i)) {
        selectedItems.add(a[i]);
      }
    }

    // Navigate to the next page with selected items
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(selectedItems: selectedItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModelBottomSheet();
          },
          child: Text('Add Tab'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToNextPage();
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  final List<String> selectedItems;

  NextPage({required this.selectedItems});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.selectedItems.length,
        vsync: this); // Adjust the length based on the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
        bottom: TabBar(
          controller: _tabController,
          tabs: widget.selectedItems.map((item) => Tab(text: item)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.selectedItems.map((item) {
          return Center(
            child: Text('$item Content'),
          );
        }).toList(),
      ),
    );
  }
}



// class TabBarpage extends StatefulWidget {
//   @override
//   _TabBarpageState createState() => _TabBarpageState(required this.selectedItems);
// }

// class _TabBarpageState extends State<TabBarpage> with SingleTickerProviderStateMixin {
  
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this); // Adjust the length based on the number of tabs
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TabBar Example'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Tab 1'),
//             Tab(text: 'Tab 2'),
//             Tab(text: 'Tab 3'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Content for Tab 1
//           Center(
//             child: Text('Tab 1 Content'),
//           ),
//           // Content for Tab 2
//           Center(
//             child: Text('Tab 2 Content'),
//           ),
//           // Content for Tab 3
//           Center(
//             child: Text('Tab 3 Content'),
//           ),
//         ],
//       ),
//     );
//   }
// }
