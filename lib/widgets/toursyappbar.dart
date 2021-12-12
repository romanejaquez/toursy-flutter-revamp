import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';

class ToursyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color? themeColor;
  const ToursyAppBar({Key? key, this.themeColor = ToursyColors.primaryGreen}) : super(key: key);

  @override
  _ToursyAppBarState createState() => _ToursyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _ToursyAppBarState extends State<ToursyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: widget.themeColor),
      centerTitle: true,
      title: Icon(ToursyFontIcons.toursyText,
        color: widget.themeColor, size: 80
      ),
    );
  }
}