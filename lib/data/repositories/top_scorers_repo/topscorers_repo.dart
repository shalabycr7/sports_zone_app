import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/top_scorers_model/top_scorers_model.dart';

class TopScorer {
  Future<TopScorersModel?> getTopScorers() async {
    try {
      // leagueid not static
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Topscorers&APIkey=b1adac156f26d4e1617feed2cf9ba42f054958c3a0f7b982a9bd24faa68f7252&leagueId=207"));
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        TopScorersModel data = TopScorersModel.fromJson(decodedresponse);
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
