// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: unused_import

import 'package:sports_zone/data/models/leagues_model/legues_model.dart';

class LeaguesModelsRepo {
  Future<Zsc?> getLeaguesModels() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Leagues&countryid=200&APIkey=e9b633c2759b431301301d00f9a9a3809b238030211a54b71e43e1e0db147f13"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        Zsc data = Zsc.fromJson(deCodedResponse);
        return data;
      } else {
        print("Requist faild");
        return null;
      }
    } catch (e) {
      print("Error:$e");
      return null;
    }
  }
}
