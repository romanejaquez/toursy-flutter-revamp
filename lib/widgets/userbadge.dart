import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/helpers/utils.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';

class UserBadge extends StatelessWidget {
  const UserBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginService>(
      builder: (context, loginService, child) {
        return loginService.isUserLoggedIn() ? 
        GestureDetector(
          onTap: () {
            Utils.mainAppNav.currentState!.pushNamed('/profile');
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: Transform.scale(
              scale: 0.8,
              child: ClipOval(
                child: SizedBox(
                  child: Image.network(
                    loginService.loggedInUserModel!.photoUrl!,
                    width: 55,
                    height: 45,
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
          ),
        )
        : const SizedBox();
      },
    );
  }
}