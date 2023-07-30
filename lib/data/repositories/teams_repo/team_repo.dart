import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/tems_model/tems_model.dart';

class Teams_Scorer {
  Future<TemsModel?> getTeams(String Search, int id) async {
    try {
      var response;
      // leagueid not static
      if (Search.length > 0) {
        print("heree");
        response = await http.get(Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252&leagueId=$id&teamName=$Search"));
      } else {
        print("heree22222");
        response = await http.get(Uri.parse(
            "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252&leagueId=$id"));
      }
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        print("yesss");
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
