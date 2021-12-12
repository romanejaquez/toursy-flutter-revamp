import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/models/bottombaritem.dart';

class ToursyBottomBarSelection extends ChangeNotifier {

  List<BottomBarItem> bottomBarItems = Utils.getBottomBarItems();
  BottomBarItem? selectedBottomBarItem;

  void onBottomBarSelected(BottomBarItem item) {
    for (var element in bottomBarItems) {
      element.isSelected = item.id == element.id;
    }
    selectedBottomBarItem = item;
    Utils.mainPageNav.currentState!.pushReplacementNamed(item.route!);
    notifyListeners();
  }
}