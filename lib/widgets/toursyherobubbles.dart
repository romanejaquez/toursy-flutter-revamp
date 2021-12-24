import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';

class ToursyHeroBubbles extends StatefulWidget {
  const ToursyHeroBubbles({Key? key}) : super(key: key);

  @override
  State<ToursyHeroBubbles> createState() => _ToursyHeroBubblesState();
}

class _ToursyHeroBubblesState extends State<ToursyHeroBubbles> with TickerProviderStateMixin {
  
  AnimationController? bubble1Anim;
  AnimationController? bubble2Anim;
  AnimationController? bubble3Anim;
  AnimationController? bubble4Anim;
  AnimationController? bubble5Anim;
  AnimationController? bubble6Anim;
  AnimationController? bubble7Anim;

  List<AnimationController>? bubbleAnims = [];

  @override 
  void initState() {
    super.initState();

    bubble1Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubble2Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubble3Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubble4Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubble5Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubble6Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubble7Anim = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000)
    );

    bubbleAnims!.add(bubble1Anim!);
    bubbleAnims!.add(bubble2Anim!);
    bubbleAnims!.add(bubble3Anim!);
    bubbleAnims!.add(bubble4Anim!);
    bubbleAnims!.add(bubble5Anim!);
    bubbleAnims!.add(bubble6Anim!);
    bubbleAnims!.add(bubble7Anim!);
  }

  @override 
  void dispose() {
    for(var ctrl in bubbleAnims!) {
      ctrl.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    if (mounted) {
      var future = Future(() {});
      for(var ctrl in bubbleAnims!) {
          future = future.then((_) {
            return Future.delayed(const Duration(milliseconds: 125), () {
              ctrl.forward();
            });
        });
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: [
          //bubble1
          Positioned(
                right: -50,
                top: -50,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble1Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble1Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: ToursyColors.secondaryGreen.withOpacity(0.5)
                  )
                ),
              ),
            ),
          ),
          
          //bubble2
          Positioned(
                right: 50,
                top: -50,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble2Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble2Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: ToursyColors.secondaryGreen.withOpacity(0.5)
                  )
                ),
              ),
            ),
          ),

          //bubble3
          Positioned(
                right: -50,
                top: 50,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble3Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble3Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: ToursyColors.secondaryGreen.withOpacity(0.8)
                  )
                ),
              ),
            ),
          ),
          
          //bubble4
          Positioned(
                right: 50,
                top: -125,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble4Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble4Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 250,
                    height: 250,
                    color: ToursyColors.secondaryGreen.withOpacity(0.125)
                  )
                ),
              ),
            ),
          ),
          
          //bubble5
          Positioned(
                right: 50,
                top: -50,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble5Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble5Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: ToursyColors.secondaryGreen.withOpacity(0.5)
                  )
                ),
              ),
            ),
          ),
          
          //bubble6
          Positioned(
                right: -60,
                top: 100,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble6Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble6Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 150,
                    height: 150,
                    color: ToursyColors.secondaryGreen.withOpacity(0.5)
                  )
                ),
              ),
            ),
          ),
          
          
          //bubble7
          Positioned(
                right: 100,
                top: 150,
                child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0)
            .animate(CurvedAnimation(parent: bubble7Anim!, curve: Curves.easeInOut)),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: bubble7Anim!, curve: Curves.easeInOut)),
              child: ClipOval(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: ToursyColors.secondaryGreen.withOpacity(0.35)
                  )
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}