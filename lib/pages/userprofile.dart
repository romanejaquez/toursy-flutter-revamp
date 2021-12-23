import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/models/loginuser.model.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursyfavoritescount.dart';
import 'package:toursy_flutter_revamp/widgets/toursymaplocatorbutton.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with TickerProviderStateMixin {
  
  AnimationController? circle1Controller;
  AnimationController? comp1Controller;
  AnimationController? comp2Controller;
  AnimationController? comp3Controller;

  List<AnimationController>? controllers = [];

  @override
  void initState() {
    super.initState();

    circle1Controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this
    )..repeat();

    comp1Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    comp2Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    comp3Controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this
    );

    controllers!.add(circle1Controller!);
    controllers!.add(comp1Controller!);
    controllers!.add(comp2Controller!);
    controllers!.add(comp3Controller!);
  }

  Widget getTransitionWidget(Widget child, AnimationController controller) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
      .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: FadeTransition(opacity: Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
        child: child
      )
    );
  }

  @override 
  void dispose() {
    for(var ctrl in controllers!) {
      ctrl.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    LoginUserModel userModel = loginService.loggedInUserModel!;

    int count = 100;
    for(var ctrl in controllers!) {
      Future.delayed(Duration(milliseconds: count), () {
        ctrl.forward();
      });
      count+= count;
    }

    return Scaffold(
      appBar: const ToursyAppBar(showUserBadge: false),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            bottom: -200,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.0)
                .animate(CurvedAnimation(parent: circle1Controller!, curve: Curves.easeInOut)),
              child: ScaleTransition(
                alignment: Alignment.bottomCenter,
                scale: Tween<double>(begin: 1.0, end: 6.0)
                .animate(CurvedAnimation(parent: circle1Controller!, curve: Curves.easeInOut)),
                child: ClipOval(
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                      width: 200,
                      height: 200,
                      color: ToursyColors.primaryGreen.withOpacity(0.5)
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                getTransitionWidget(
                  Stack(
                    children: [
                      Transform.scale(scale: 1.15,
                        child: const ToursyMapLocatorButton()
                      ),
                      ClipOval(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            userModel.photoUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover
                          ),
                        ),
                      )
                    ],
                  ), comp1Controller!
                ),
                const SizedBox(height: 40),
                getTransitionWidget(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(userModel.displayName!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 25, color: ToursyColors.secondaryGreen, fontWeight: FontWeight.bold)
                        ),
                      ),
                      Text(userModel.email!,
                        style: const TextStyle(fontSize: 15, color: Colors.grey)
                      )
                    ],
                  ),
                  comp2Controller!
                ),
                const SizedBox(height: 40),
                getTransitionWidget(
                  const ToursyFavoritesCount(),
                  comp3Controller!
                )
              ],
            )
          )
        ],
      )
    );
  }
}