import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toursy_flutter_revamp/helpers/toursycolors.dart';
import 'package:toursy_flutter_revamp/helpers/toursyfont.dart';
import 'package:toursy_flutter_revamp/models/activitydata.model.dart';
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncard.model.dart';
import 'package:toursy_flutter_revamp/models/attractioncategoryselection.model.dart';
import 'package:toursy_flutter_revamp/models/bottombaritem.dart';
import 'package:toursy_flutter_revamp/models/regionaldata.model.dart';

class Utils {
  static GlobalKey<NavigatorState> mainPageNav = GlobalKey();
  static GlobalKey<NavigatorState> mainAppNav = GlobalKey();

  static List<BottomBarItem> getBottomBarItems() {
    return [
      BottomBarItem(
        id: 'toprated',
        icon: ToursyFontIcons.toursyTopRated,
        isSelected: true,
        route: '/',
        showIfLoggedIn: false
      ),
      BottomBarItem(
        id: 'byregion',
        icon: ToursyFontIcons.toursyMap,
        isSelected: false,
        route: '/byregion',
        showIfLoggedIn: false
      ),
      BottomBarItem(
        id: 'byactivity',
        icon: ToursyFontIcons.toursyWalk,
        isSelected: false,
        route: '/byactivity',
        showIfLoggedIn: false
      ),
      BottomBarItem(
        id: 'map',
        icon: ToursyFontIcons.toursyPaperMap,
        isSelected: false,
        route: '/map',
        showIfLoggedIn: true
      )
    ];
  }

  static List<AttractionCardModel> mapAttractionModelToAttractionCards(List<AttractionModel> attractionModels) {
    return attractionModels.map(
      (AttractionModel a) => AttractionCardModel(
        id: a.id,
        img: a.img,
        title: a.name,
        subTitle: a.province
      )).toList();
  }

  static List<AttractionCardModel> mapActivityDataModelToAttractionCards(List<ActivityDataModel> activities) {
      return activities.map(
        (ActivityDataModel a) => AttractionCardModel(
          id: a.id,
          img: a.img,
          title: a.name,
          subTitle: '${a.attractions!.length} attractions'
        )).toList();
  }

  static List<AttractionCardModel> mapRegionalDataModelToAttractionCards(List<RegionalDataModel> regionalDataModelList) {
      return regionalDataModelList.map(
        (RegionalDataModel r) => AttractionCardModel(
          id: r.id,
          img: r.img,
          title: r.region,
          subTitle: '${r.attractions!.length} attractions'
        )).toList();
  }

  static String mapAttractionCategoryToString(AttractionCategory cat) {
    switch(cat) {
      case AttractionCategory.byActivity:
        return 'By Activity';
      case AttractionCategory.byRegion:
        return 'By Region';
      default:
        return '';
    }
  }
  
}