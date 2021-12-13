import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/widgets/toursybtn.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {

  AnimationController? logoController;
  AnimationController? text1Controller;
  AnimationController? text2Controller;
  AnimationController? mapController;

  List<AnimationController>? controllers = [];

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    controllers!.add(logoController!);

    text1Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    controllers!.add(text1Controller!);

    text2Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    controllers!.add(text2Controller!);

    mapController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    controllers!.add(mapController!);
  }

  @override
  void dispose() {
    logoController!.dispose();
    text1Controller!.dispose();
    text2Controller!.dispose();
    mapController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int count = 100;
    for(var ctrl in controllers!) {
      Future.delayed(Duration(milliseconds: count), () {
        ctrl.forward();
      });
      count+= count;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(CurvedAnimation(parent: logoController!, curve: Curves.easeInOut)),
                      child: Container(
                        width: 100,
                        height: 100,
                        child: const Icon(ToursyFontIcons.toursyLogo, color: Colors.white, size: 80),
                        decoration: BoxDecoration(
                          color: ToursyColors.primaryGreen,
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0.0, -0.25), end: Offset.zero)
                      .animate(CurvedAnimation(parent: text1Controller!, curve: Curves.easeInOut)),
                      child: FadeTransition(opacity: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(parent: text1Controller!, curve: Curves.easeInOut)),
                        child: const Text('Welcome to \n Toursy!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ToursyColors.primaryGreen,
                            fontSize: 30
                          )
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0.0, -0.25), end: Offset.zero)
                      .animate(CurvedAnimation(parent: text2Controller!, curve: Curves.easeInOut)),
                      child: FadeTransition(opacity: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(parent: text2Controller!, curve: Curves.easeInOut)),
                        child: const Text('Enjoy the most\nbeautiful attractions\nfrom Dominican Republic',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 20)
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(parent: mapController!, curve: Curves.easeInOut)),
                        child: const Icon(
                        ToursyFontIcons.toursyMap, 
                        color: Colors.grey, 
                        size: 50
                      )
                    ),
                    
                  ],
                ),
              ),
              ToursyButton(
                label: 'Go To Main Page',
                onTap: () {
                  Utils.mainAppNav.currentState!.pushNamed('/main');
                },
              )
            ],
          ),
        ),
      )
    );
  }
}