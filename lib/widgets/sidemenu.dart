import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';
import 'package:toursy_flutter_revamp/services/toursybottombarselection.dart';
import 'package:toursy_flutter_revamp/widgets/sidemenuitem.dart';
import 'package:toursy_flutter_revamp/widgets/toursyalert.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(50),
      color: ToursyColors.secondaryGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(ToursyFontIcons.toursyText, color: Colors.white, size: 80),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<LoginService>(
                  builder: (context, loginService, child) {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SideMenuItem(
                          onTap: () async {
                              if (loginService.isUserLoggedIn()) {
                                Utils.mainAppNav.currentState!.pop();
                                
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return ToursyAlert(
                                      title: 'Signing Out',
                                      message: 'Are you sure you want to sign out?',
                                      onYes: () {
                                        loginService.signOut(() {
                                          ToursyBottomBarSelection bottomBarSelection = Provider.of<ToursyBottomBarSelection>(context, listen: false);
                                          bottomBarSelection.resetSelection();
                                          Utils.mainAppNav.currentState!.popUntil((route) => route.settings.name == '/welcome');
                                        });
                                      },
                                      onNo: () {
                                        Utils.mainAppNav.currentState!.pop(); 
                                      },
                                    );
                                  }
                                );
                              }
                              else {
                                var isLoggedIn = await loginService.signInWithGoogle();
                                if (isLoggedIn) {
                                  Utils.mainAppNav.currentState!.pop();
                                }
                              }
                            },
                          label: loginService.isUserLoggedIn() ? 'Sign Out' : 'Sign In with Google',
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: loginService.isUserLoggedIn(),
                          child: SideMenuItem(
                            onTap: () {
                              Utils.mainAppNav.currentState!.pop();
                              Utils.mainAppNav.currentState!.pushNamed('/profile');
                            },
                              label: 'My Profile',
                            ),
                          )
                      ]
                    );
                  },
                )
            ],
            ),
          ),
          const Icon(ToursyFontIcons.toursyLogo, color: Colors.white, size: 80)
        ],
      )
    );
  }
}