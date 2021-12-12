import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/pages/byactivity.dart';
import 'package:toursy_flutter_revamp/pages/byregion.dart';
import 'package:toursy_flutter_revamp/pages/map.dart';
import 'package:toursy_flutter_revamp/pages/topattractions.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursybottombar.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToursyAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Navigator(
              key: Utils.mainPageNav,
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {

                Widget page;

                switch(settings.name) {
                  case '/':
                    page = TopAttractionsPage();
                    break;
                  case '/byregion':
                    page = ByRegionPage();
                    break;
                  case '/byactivity':
                    page = ByActivityPage();
                    break;
                  case '/map':
                    page = MapPage();
                    break;
                  default: 
                    page = TopAttractionsPage();
                    break;
                }

                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => page,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                      child: SlideTransition(
                        position: Tween(begin: const Offset(0.0, 0.05), end: Offset.zero).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                        child: child,
                      )
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                );
              },
            )
          ),
          const ToursyBottomBar()
        ],
      ),
    );
  }
}