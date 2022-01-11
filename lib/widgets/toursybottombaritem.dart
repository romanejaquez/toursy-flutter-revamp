import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/models/bottombaritem.dart';

class ToursyBottomBarItem extends StatelessWidget {

  final Function? onTap;
  final BottomBarItem? bottomBarItem;

  const ToursyBottomBarItem({Key? key, this.bottomBarItem, this.onTap }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { onTap!(); },
      child: SizedBox(
        width: 80,
        height: 90,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: bottomBarItem!.isSelected! ? 0 : 1,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Icon(
                    bottomBarItem!.icon,
                    size: bottomBarItem!.size,
                    color: Colors.grey.withOpacity(0.8))
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              bottom: bottomBarItem!.isSelected! ? 0 : -80,
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Icon(
                  bottomBarItem!.icon,
                  size: bottomBarItem!.size,
                  color: ToursyColors.primaryGreen)
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}