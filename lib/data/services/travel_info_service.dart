import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:micros_app/data/models/models.dart';
import 'package:micros_app/data/services/services.dart';
import 'package:micros_app/env.dart';
import 'package:http/http.dart' as http;

class TravelInfoService {

  // CollectionReference _ref;

  // TravelInfoProvider() {
    // _ref = FirebaseFirestore.instance.collection('TravelInfo');
  // }

  Future<void> create(TravelInfo travelInfo) async {
    try {
      // return _ref.doc(travelInfo.id).set(travelInfo.toJson());
      debugPrint(travelInfo.toMap().toString());
      const url = '${Env.baseUrl}travel-info/store';
      final resp = await http.post(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: travelInfo.toMap(),
      );
      // final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode != 200) {
        debugPrint(resp.body);
      }            
        debugPrint("chill------------------------------------");
    } catch(error) {
      debugPrint(error.toString());
      return Future.error(error.toString());
    }
  }

  static Future<void> update(Map<String, String> data, String idClient) async {
    try {
      debugPrint(data.toString());
      final url = '${Env.baseUrl}travel-info/update/$idClient';
      final resp = await http.put(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
        body: data,
      );
      // final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if (resp.statusCode != 200) {
        debugPrint(resp.body);
      }            
    } catch(error) {
      debugPrint('TRY ERROR <TravelInfo> update:  $error');
      return Future.error(error.toString());

    }    
  }


  static Future<TravelInfo?> getbyId(String idClient) async {
    TravelInfo? travelInfo;
    try {
      final url = '${Env.baseUrl}travel-info/get/$idClient';
      final resp = await http.get(
        Uri.parse(url),
        headers: {'Accept' : 'application/json'},
      );
      if (resp.statusCode == 200) {
        travelInfo = TravelInfo.fromJson(resp.body);
      } else {
        debugPrint('ERROR <TravelInfoService>getbyId: ${resp.body}');
      }           
    } catch(error) {
      debugPrint('ERROR TRY CATCH <TravelInfoService>getbyId: ${error.toString()}');
    }    
      return travelInfo;
  }

}