import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/models/loginuser.model.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursymaplocatorbutton.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  
  AnimationController? circle1Controller;

  @override
  void initState() {
    super.initState();

    circle1Controller = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this
    )..repeat();
  }

  @override 
  void dispose() {
    circle1Controller!.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    LoginUserModel userModel = loginService.loggedInUserModel!;

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
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(userModel.displayName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25, color: ToursyColors.secondaryGreen, fontWeight: FontWeight.bold)
                  ),
                ),
                Text(userModel.email!,
                  style: const TextStyle(fontSize: 15, color: Colors.grey)
                ),
                const SizedBox(height: 40),
                Icon(ToursyFontIcons.toursyLogo, color: Colors.grey.withOpacity(0.2), size: 60),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 200,
                  height: 200,
                  child: Text('You don\'t have any favorite attractions yet!', 
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey)
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }
}