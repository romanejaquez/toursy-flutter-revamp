import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/pages/attraction.dart';
import 'package:toursy_flutter_revamp/pages/attractions.dart';
import 'package:toursy_flutter_revamp/pages/main.dart';
import 'package:toursy_flutter_revamp/pages/map.dart';
import 'package:toursy_flutter_revamp/pages/splash.dart';
import 'package:toursy_flutter_revamp/pages/welcome.dart';
import 'package:toursy_flutter_revamp/services/attractioncategoryselectionservice.dart';
import 'package:toursy_flutter_revamp/services/attractionselectionservice.dart';
import 'package:toursy_flutter_revamp/services/byactivityservice.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';
import 'package:toursy_flutter_revamp/services/regionaldataservice.dart';
import 'package:toursy_flutter_revamp/services/topattractionsservice.dart';
import 'package:toursy_flutter_revamp/services/toursybottombarselection.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ToursyBottomBarSelection(),
        ),
        Provider(
          create: (_) => TopAttractionsService()
        ),
        Provider(
          create: (_) => ByActivityService()
        ),
        Provider(
          create: (_) => RegionalDataService()
        ),
        Provider(
          create: (_) => ToursyMainService()
        ),
        Provider(
          create: (_) => AttractionCategorySelectionService()
        ),
        Provider(
          create: (_) => AttractionSelectionService()
        ),
        ChangeNotifierProvider(
          create: (_) => LoginService()
        )
      ],
      child: const ToursyApp(),
    )
  );
}

class ToursyApp extends StatelessWidget {
  const ToursyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Raleway'),
      navigatorKey: Utils.mainAppNav,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(duration: 3, goToPage: '/welcome'),
        '/welcome': (context) => const WelcomePage(),
        '/main': (context) => const MainPage(),
        '/attractions': (context) => const AttractionsPage(),
        '/attraction': (context) => const AttractionPage(),
        '/map': (context) => MapPage()
      }
    );
  }

}
