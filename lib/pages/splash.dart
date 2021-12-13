import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';

class SplashPage extends StatefulWidget {
  int? duration;
  String? goToPage;

  SplashPage({Key? key, this.duration, this.goToPage}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController? textController;
  AnimationController? circle1Controller;
  AnimationController? circle2Controller;
  AnimationController? logoController;

  @override
  void initState() {
    super.initState();

    textController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this
    )..repeat(reverse: true);

    circle1Controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this
    )..forward();

    circle2Controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this
    );

    logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this
    )..forward();
  }

  @override
  void dispose() {
    textController!.dispose();
    logoController!.dispose();
    circle1Controller!.dispose();
    circle2Controller!.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    ToursyMainService toursyMainService = Provider.of<ToursyMainService>(context, listen: false);
    
    toursyMainService.fetchAllData(context).then((value) {
      Future.delayed(Duration(seconds: widget.duration!), () {
        Utils.mainAppNav.currentState!.pushReplacementNamed(
          widget.goToPage!);
      });
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      circle2Controller!.forward();
    });

    return Scaffold(
      backgroundColor: ToursyColors.primaryGreen,
      body: Stack(
        children: [
          Positioned(
            bottom: -200,
            left: 0,
            right: 0,
            child: ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: Tween<double>(begin: 1.0, end: 6.0)
              .animate(CurvedAnimation(parent: circle1Controller!, curve: Curves.easeInOut)),
              child: ClipOval(
                child: Container(
                  width: 200,
                  height: 200,
                  color: ToursyColors.secondaryGreen.withOpacity(0.5)
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -200,
            left: 0,
            right: 0,
            child: ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: Tween<double>(begin: 1.0, end: 6.0)
              .animate(CurvedAnimation(parent: circle2Controller!, curve: Curves.easeInOut)),
              child: ClipOval(
                child: Container(
                  width: 200,
                  height: 200,
                  color: ToursyColors.secondaryGreen
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(CurvedAnimation(parent: logoController!, curve: Curves.easeInOut)),
                    child: const Icon(
                      ToursyFontIcons.toursyLogoFull,
                      color: Colors.white,
                      size: 180
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: Tween<double>(begin: 1.0, end: 0.0)
                  .animate(CurvedAnimation(parent: textController!, curve: Curves.easeInOut)),
                  child: const Text('Fetching amazing\ntouristic data. Hang on!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)
                  ),
                ),
                const SizedBox(height: 100)
              ]
            )
          )
        ],
      )
    );
  }
}