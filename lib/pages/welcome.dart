import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/widgets/toursybtn.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Container(
                        width: 100,
                        height: 100,
                        child: const Icon(ToursyFontIcons.toursyLogo, color: Colors.white, size: 80),
                        decoration: BoxDecoration(
                          color: ToursyColors.primaryGreen,
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Welcome to \n Toursy!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ToursyColors.primaryGreen,
                          fontSize: 30
                        )
                      ),
                      const SizedBox(height: 20),
                      const Text('Enjoy the most\nbeautiful attractions\nfrom Dominican Republic',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 20)
                      ),
                      const SizedBox(height: 10),
                      const Icon(ToursyFontIcons.toursyMap, color: Colors.grey, size: 50),
                      
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