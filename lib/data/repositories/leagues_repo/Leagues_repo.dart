import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: unused_import

import 'package:sports_zone/data/models/leagues_model/legues_model.dart';

class LeaguesModelsRepo {
  static const String _apiKey =
      'c4cf9b83dd238694de4a6188f2a57c794070af1fa35646b5e3285b225f9a8482';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<Zsc?> getLeaguesModels(int countryId) async {
    try {
      var response = await http.get(Uri.parse(
          "$_baseUrl?met=Leagues&countryId=$countryId&APIkey=$_apiKey"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        Zsc data = Zsc.fromJson(deCodedResponse);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
