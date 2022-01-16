import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class ToursyPlainButton extends StatelessWidget {
  Function? onTap;
  String? label;
  IconData? icon;
  
  ToursyPlainButton({Key? key, this.onTap, this.label, this.icon }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        bottomRight: Radius.circular(30)
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () { onTap!(); },
          splashColor: ToursyColors.primaryGreen.withOpacity(0.1),
          highlightColor: ToursyColors.secondaryGreen.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Icon(icon!, size: 35, color: ToursyColors.primaryGreen),
                ),
                Text(label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: ToursyColors.primaryGreen)
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)
              ),
              border: Border.all(
                color: ToursyColors.primaryGreen.withOpacity(0.5),
                          width: 5
                        )
                      ),
                    ),
                  ),
                ),
              );
  }
}