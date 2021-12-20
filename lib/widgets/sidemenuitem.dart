import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class SideMenuItem extends StatelessWidget {
  final String? label;
  final Function? onTap;

  const SideMenuItem({Key? key, this.label, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () { onTap!(); },
            splashColor: ToursyColors.primaryGreen.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(label!,
                  style: const TextStyle(color: Colors.white, fontSize: 18
                )
              ),
            ),
          ),
        ),
      );
  }
}