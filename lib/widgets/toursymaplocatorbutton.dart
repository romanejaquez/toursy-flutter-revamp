import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';

class ToursyMapLocatorButton extends StatefulWidget {
  final Function? onTap;
  final IconData? icon;
  const ToursyMapLocatorButton({Key? key, this.onTap, this.icon = ToursyFontIcons.toursyPaperMap }) : super(key: key);

  @override
  State<ToursyMapLocatorButton> createState() => _ToursyMapLocatorButtonState();
}

class _ToursyMapLocatorButtonState extends State<ToursyMapLocatorButton> with SingleTickerProviderStateMixin {

  AnimationController? glowingController;

  @override
  void initState() {
    super.initState();

    glowingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this)..repeat(reverse: false);
  }

  @override 
  void dispose() {
    glowingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { widget.onTap!(); },
      child: Stack(
        children: [
          FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0)
            .animate(CurvedAnimation(parent: glowingController!, curve: Curves.easeInOut)),
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 2.0)
                .animate(CurvedAnimation(parent: glowingController!, curve: Curves.easeInOut)),
              child: ClipOval(
                child: Container(
                  color: ToursyColors.primaryGreen,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ToursyColors.primaryGreen,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: Offset.zero,
                        color: ToursyColors.secondaryGreen.withOpacity(0.8)
                      )
                    ]
                  ),
                  width: 80,
                  height: 80,
                ),
                Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(widget.icon!, size: 50, color: Colors.white),
                  ),
                )
              ]
            ),
          )
        ]
      ),
    );
  }
}