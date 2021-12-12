import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/services/toursymainservice.dart';

class SplashPage extends StatelessWidget {
  int? duration;
  String? goToPage;

  SplashPage({Key? key, this.duration, this.goToPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ToursyMainService toursyMainService = Provider.of<ToursyMainService>(context, listen: false);
    toursyMainService.fetchAllData(context).then((value) {
      Future.delayed(Duration(seconds: duration!), () {
        Utils.mainAppNav.currentState!.pushReplacementNamed(
          goToPage!);
      });
    });

    return const Scaffold(
      backgroundColor: ToursyColors.primaryGreen,
      body: Center(
        child: Icon(
          ToursyFontIcons.toursyLogoFull,
          color: Colors.white,
          size: 180),
      )
    );
  }
}