import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';

class ToursyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ToursyAppBar({Key? key}) : super(key: key);

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
      iconTheme: const IconThemeData(color: ToursyColors.primaryGreen),
      centerTitle: true,
      title: const Icon(ToursyFontIcons.toursyText,
        color: ToursyColors.primaryGreen, size: 80
      ),
    );
  }
}