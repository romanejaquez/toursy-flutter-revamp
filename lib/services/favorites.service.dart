import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/services/login.service.dart';

class FavoritesService extends ChangeNotifier {

  Future<bool>? isAttractionSaved(AttractionModel attraction, BuildContext context) {

    Completer<bool> attractionSavedCompleter = Completer();
    
    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    if (loginService.isUserLoggedIn()) {
      var userDocId = loginService.loggedInUserModel!.uid;
      FirebaseFirestore.instance.collection('favorites')
      .doc(userDocId).get().then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          var savedListMap = snapshot.data() as Map<String, dynamic>;
          var savedList = savedListMap['favorites'] as List<dynamic>;
          attractionSavedCompleter.complete(savedList.contains(attraction.id));
        }
        else {
          attractionSavedCompleter.complete(false);
        }
      });
    }

    return attractionSavedCompleter.future;
  }

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

  void saveAttractionAsFavorite(AttractionModel attraction, BuildContext context, { bool add = true }) {

    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    if (loginService.isUserLoggedIn()) {
      var userDocId = loginService.loggedInUserModel!.uid;
      FirebaseFirestore.instance.collection('favorites')
      .doc(userDocId).update({
        'favorites': add ? FieldValue.arrayUnion([attraction.id]) : FieldValue.arrayRemove([attraction.id])
      }).then((value) {
        notifyListeners();
      });
    }
  }
}