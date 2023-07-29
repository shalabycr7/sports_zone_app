import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/tems_model/tems_model.dart';

class Teams_Scorer {
  Future<TemsModel?> getTeams(String Search) async {
    try {
      http.Response response;
      // leagueid not static
      if (Search != null) {
        response = await http.get(Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252&leagueId=205&teamName=$Search"));
      } else {
        response = await http.get(Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252&leagueId=205"));
      }
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TemsModel data = TemsModel.fromJson(decodedresponse);
        return data;
      } else {
        print("request failed");
        return null;
      }
    } catch (error) {
      print("erroe:$error");
      return null;
    }
  }
}
