import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/services/toursybottombarselection.dart';
import 'package:toursy_flutter_revamp/widgets/toursybottombaritem.dart';

class ToursyBottomBar extends StatelessWidget {
  const ToursyBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ToursyBottomBarSelection>(
      builder: (context, bottomBarSelectionService, child) {
        return Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: ToursyColors.primaryGreen.withOpacity(0.2),
                blurRadius: 20,
                offset: Offset.zero
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomBarSelectionService.bottomBarItems.length,
            (index) {
              var bottomBarItem = bottomBarSelectionService.bottomBarItems[index];
              return ToursyBottomBarItem(
                bottomBarItem: bottomBarItem,
                onTap: () {
                  bottomBarSelectionService.onBottomBarSelected(bottomBarItem);
                },  
              );
            })
          ),
        );
      }
    );
  }
}