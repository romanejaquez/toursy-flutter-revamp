import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class ToursyButton extends StatelessWidget {

  String? label;
  Function? onTap;

  ToursyButton({
    Key? key,
    this.label,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: ToursyColors.primaryGreen.withOpacity(0.5)
          ),
        ]
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Material(
          color: ToursyColors.primaryGreen,
            child: InkWell(
              onTap: () {
                onTap!();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                )
              ),
            ),
          ),
        ),
      );
  }
}