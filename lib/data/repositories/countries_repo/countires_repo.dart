// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sports_zone/data/models/countries_model/countries_model.dart';


class CountiersModelsRepo {
  Future<CountiersModels?> getCountiersModels() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=e9b633c2759b431301301d00f9a9a3809b238030211a54b71e43e1e0db147f13"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        CountiersModels data = CountiersModels.fromJson(deCodedResponse);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
