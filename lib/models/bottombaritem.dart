import 'package:flutter/material.dart';

class BottomBarItem {
  String? id;
  IconData? icon;
  bool? isSelected;
  Color? color;
  String? route;
  bool? showIfLoggedIn;
  bool? showNormal;
  double? size;

  BottomBarItem({ this.id, this.icon, this.isSelected, this.color, this.route, this.showIfLoggedIn, this.showNormal, this.size });
}