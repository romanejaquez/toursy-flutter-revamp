import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';

class FavoritesService {


  DocumentReference? getAttractionListAsRef(BuildContext context) {

    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    if (loginService.isUserLoggedIn()) {
      var userDocId = loginService.loggedInUserModel!.uid;
      final attractionsListRef = FirebaseFirestore.instance.collection('favorites')
      .doc(userDocId);

      return attractionsListRef;
    }

    return null;
  }
}