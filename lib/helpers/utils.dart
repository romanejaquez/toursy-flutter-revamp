import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        showIfLoggedIn: true,
        showNormal: true,
        size: 35
      ),
      BottomBarItem(
        id: 'byregion',
        icon: ToursyFontIcons.toursyMap,
        isSelected: false,
        route: '/byregion',
        showIfLoggedIn: true,
        showNormal: true,
        size: 35
      ),
      BottomBarItem(
        id: 'byactivity',
        icon: ToursyFontIcons.toursyWalk,
        isSelected: false,
        route: '/byactivity',
        showIfLoggedIn: true,
        showNormal: true,
        size: 35
      ),
      BottomBarItem(
        id: 'favorites',
        icon: Icons.favorite,
        isSelected: false,
        route: '/favorites',
        showIfLoggedIn: true,
        showNormal: false,
        size: 35
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
  
  static void insertListItemsInFuture(List<Object>? sourceList, List<Object>? destinationList, GlobalKey<AnimatedListState>? key) {
    if (sourceList != null && destinationList != null && key != null) {
      var future = Future(() {});
      for (var i = 0; i < sourceList.length; i++) {
        future = future.then((_) {
          return Future.delayed(const Duration(milliseconds: 125), () {
            destinationList.add(sourceList[i]);
            key.currentState!.insertItem(i);
          });
        });
      }
    }
  }

  static String deviceSuffix(BuildContext context) {
    String deviceSuffix = '';
    TargetPlatform platform = Theme.of(context).platform;
    switch(platform) {
      case TargetPlatform.android:
        deviceSuffix = '_android';
        break;
      case TargetPlatform.iOS:
        deviceSuffix = '_ios';
        break;
      default: 
        deviceSuffix = '';
        break;
    }

    return deviceSuffix;
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}