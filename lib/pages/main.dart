import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/pages/byactivity.dart';
import 'package:toursy_flutter_revamp/pages/byregion.dart';
import 'package:toursy_flutter_revamp/pages/favorites.dart';
import 'package:toursy_flutter_revamp/pages/topattractions.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/services/toursybottombarselection.dart';
import 'package:toursy_flutter_revamp/widgets/sidemenu.dart';
import 'package:toursy_flutter_revamp/widgets/toursyappbar.dart';
import 'package:toursy_flutter_revamp/widgets/toursybottombar.dart';
import 'package:toursy_flutter_revamp/widgets/toursymaplocatorbutton.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  
  AnimationController? toursyLocatorAnim;

  @override 
  void initState() {
    super.initState();

    toursyLocatorAnim = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this);
  }

  @override 
  void dispose() {
    toursyLocatorAnim!.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    AttractionSelectionService attractionSelectionService = Provider.of<AttractionSelectionService>(context, listen: false);
    ToursyBottomBarSelection toursyBottomBarSelection = Provider.of<ToursyBottomBarSelection>(context, listen: false);

    Future.delayed(const Duration(milliseconds: 1000), () {
      toursyLocatorAnim!.forward();
    });

    return Stack(
      children: [
        Scaffold(
          floatingActionButton: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0,0.50), 
              end: const Offset(0.0, 0.15))
              .animate(CurvedAnimation(parent: toursyLocatorAnim!, curve: Curves.elasticInOut)),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 150, right: 20),
                child: ToursyMapLocatorButton(
                  onTap: () {
                    attractionSelectionService.resetViewOnMap();
                    Utils.mainAppNav.currentState!.pushNamed('/map');
                  },
                ),
              ),
            ),
          ),
          bottomNavigationBar: const ToursyBottomBar(),
          drawer: const Drawer(child: SideMenu()),
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
                        page = const TopAttractionsPage();
                        break;
                      case '/byregion':
                        page = ByRegionPage();
                        break;
                      case '/byactivity':
                        page = ByActivityPage();
                        break;
                      case '/favorites':
                        page = const FavoritesPage();
                        break;
                      default: 
                        page = const TopAttractionsPage();
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
            ],
          ),
        ),
        
      ],
    );
  }
}