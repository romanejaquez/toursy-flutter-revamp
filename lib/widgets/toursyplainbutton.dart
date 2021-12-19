import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class ToursyPlainButton extends StatelessWidget {
  Function? onTap;
  String? label;
  
  ToursyPlainButton({Key? key, this.onTap, this.label }) : super(key: key);

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
            padding: const EdgeInsets.all(20),
            child: Text(label!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: ToursyColors.primaryGreen)
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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