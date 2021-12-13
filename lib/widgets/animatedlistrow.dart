import 'package:flutter/material.dart';

class AnimatedListRow extends StatefulWidget {

  Widget? child;
  Animation<double>? animation;
  AnimatedListRow({Key? key,  this.child, this.animation }) : super(key: key);

  @override
  State<AnimatedListRow> createState() => _AnimatedListRowState();
}

class _AnimatedListRowState extends State<AnimatedListRow> {
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
          parent: widget.animation!,
          curve: Curves.easeInOut
        )),
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0.2, 0.0),
            end: const Offset(0.0, 0.0),
          )
          .animate(CurvedAnimation(
            parent: widget.animation!,
            curve: Curves.easeInOut
          )),
          child: widget.child
        )
    );
  }
}