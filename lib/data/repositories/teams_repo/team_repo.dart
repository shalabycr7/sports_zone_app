import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/tems_model/tems_model.dart';

class TeamsScorer {
  static const String _apiKey =
      'c4cf9b83dd238694de4a6188f2a57c794070af1fa35646b5e3285b225f9a8482';
  static const String _baseUrl = 'https://apiv2.allsportsapi.com/football/';
  Future<TemsModel?> getTeams(String search, int id) async {
    try {
      http.Response response;
      if (search != '') {
        response = await http.get(Uri.parse(
            "$_baseUrl?&met=Teams&APIkey=$_apiKey&leagueId=$id&teamName=$search"));
      } else {
        response = await http.get(
            Uri.parse("$_baseUrl?&met=Teams&APIkey=$_apiKey&leagueId=$id"));
      }
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
}
