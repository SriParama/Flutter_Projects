import 'package:flutter/material.dart';

class ChangeValueNotifier extends ValueNotifier<int> {
  ChangeValueNotifier._shareInstance() : super(0);
  static final ChangeValueNotifier _changeIndex =
      ChangeValueNotifier._shareInstance();
  factory ChangeValueNotifier() => _changeIndex;
  int get getindex => value;
  setIndex() {
    value++;
  }
}

// class ChangeTabIndex extends ChangeNotifier {
//   int ipoTabIndex = 0;
//   int sgbTabIndex = 0;

//   ChangeTabIndex._sharedIntences();
//   static final ChangeTabIndex _tabIndex = ChangeTabIndex._sharedIntences();
//   factory ChangeTabIndex() => _tabIndex;
//   int get getIpoIndex => ipoTabIndex;
//   int get getSgbIndex => sgbTabIndex;
//   changeIpoIndex() {
//     ipoTabIndex = 0;
//     notifyListeners();
//   }
// }
