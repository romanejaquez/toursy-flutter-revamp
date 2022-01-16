import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class ToursyButton extends StatefulWidget {

  final String? label;
  final Function? onTap;

  const ToursyButton({
    Key? key,
    this.label,
    this.onTap
  }) : super(key: key);

  @override
  State<ToursyButton> createState() => _ToursyButtonState();
}

class _ToursyButtonState extends State<ToursyButton> {

  Timer? glowingTimer;
  bool? isBlurred = false;

  @override
  void dispose() {
    glowingTimer!.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    glowingTimer = Timer(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          isBlurred = !isBlurred!;
        });
      }
    });

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: isBlurred! ? 10 : 5,
            color: ToursyColors.primaryGreen
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
                widget.onTap!();
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(widget.label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              ),
            ),
          ),
        ),
      );
  }
}