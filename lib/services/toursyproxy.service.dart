import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toursy_flutter_revamp/models/activitydata.model.dart';
import 'dart:convert' as convert;
import 'package:toursy_flutter_revamp/models/attraction.model.dart';
import 'package:toursy_flutter_revamp/models/regionaldata.model.dart';

class ToursyProxy {

  static const String BASE_URL = 'https://us-central1-toursy-242912.cloudfunctions.net/';

  static Future<List<AttractionModel>> getTopAttractions() {
    List<AttractionModel> topAttractions = [];
    Completer<List<AttractionModel>> eventsCompleter = Completer();

    var url = Uri.parse(BASE_URL + '/getTopAttractions');
    http.get(url).then((response) {
      var parsedJSON = convert.jsonDecode(response.body);
        var topAttractionsJSON = parsedJSON['templateData']['attractions'];
        
        for(var topAttraction in topAttractionsJSON) {
          topAttractions.add(AttractionModel.fromJson(topAttraction['attractionData']));
        }

        Future.delayed(const Duration(seconds: 1), () {
          eventsCompleter.complete(topAttractions);
        });

    }).onError((error, stackTrace) {
      eventsCompleter.completeError(
          const AsyncSnapshot.withError(ConnectionState.done, 'error')
        );
    }).catchError((error) {
      eventsCompleter.completeError(
          const AsyncSnapshot.withError(ConnectionState.done, 'error')
        );
    });

    return eventsCompleter.future;    
  }

  static Future<List<ActivityDataModel>> getAttractionsByActivity() {
    List<ActivityDataModel> byActivity = [];
    Completer<List<ActivityDataModel>> eventsCompleter = Completer();

    var url = Uri.parse(BASE_URL + '/getAttractionsByActivity');
    http.get(url).then((response) {
      var parsedJSON = convert.jsonDecode(response.body);
        var activityAttractionsJSON = parsedJSON['templateData']['attractionsByActivity'];
        
        for(var byActivityAttraction in activityAttractionsJSON) {
          byActivity.add(ActivityDataModel.fromJson(byActivityAttraction['activityData']));
        }

        Future.delayed(const Duration(seconds: 1), () {
          eventsCompleter.complete(byActivity);
        });
        
    }).onError((error, stackTrace) {
      eventsCompleter.completeError(
          const AsyncSnapshot.withError(ConnectionState.done, 'error')
        );
    }).catchError((error) {
      eventsCompleter.completeError(
          const AsyncSnapshot.withError(ConnectionState.done, 'error')
        );
    });

    return eventsCompleter.future;    
  }

  static Future<List<RegionalDataModel>> getRegionalData() {
    List<RegionalDataModel> regionalDataList = [];
    Completer<List<RegionalDataModel>> eventsCompleter = Completer();

    var url = Uri.parse(BASE_URL + '/getAllAttractions');
    http.get(url).then((response) {
      var parsedJSON = convert.jsonDecode(response.body);
        var attractionsByRegionJSON = parsedJSON['templateData']['attractionsByRegion'];
        
        for(var regionDataJson in attractionsByRegionJSON) {
          var data = regionDataJson['regionData'];
          regionalDataList.add(RegionalDataModel.fromJson(data));
        }

        Future.delayed(const Duration(seconds: 1), () {
          eventsCompleter.complete(regionalDataList);
        });
        
    }).onError((error, stackTrace) {
      eventsCompleter.completeError(
          const AsyncSnapshot.withError(ConnectionState.done, 'error')
        );
    }).catchError((error) {
      eventsCompleter.completeError(
          const AsyncSnapshot.withError(ConnectionState.done, 'error')
        );
    });

    return eventsCompleter.future;    
  }
}