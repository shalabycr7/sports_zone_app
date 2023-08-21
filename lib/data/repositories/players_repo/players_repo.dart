import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/plyer1_model/plyer1_model.dart';
import '../../models/tems_model/tems_model.dart';

class Players {
  static const String _apiKey =
      '96dcd54337dd88e5c710d0afbdafaf7f08e390184032cf6b60baf041d7733994';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<TemsModel?> getPlayers(String tm, int id) async {
    try {
      http.Response response;

      response = await http.get(Uri.parse(
          "$_baseUrl?&met=Teams&APIkey=$_apiKey&leagueId=$id&teamName=$tm"));
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TemsModel data = TemsModel.fromJson(decodedresponse);
        return data;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<Plyer1Model?> getPlayer(String srch, int teamId) async {
    try {
      http.Response response;

      response = await http.get(Uri.parse(
          "$_baseUrl?&playerName=$srch&met=Players&APIkey=$_apiKey&teamId=$teamId"));

      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        Plyer1Model data = Plyer1Model.fromJson(decodedresponse);
        return data;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
