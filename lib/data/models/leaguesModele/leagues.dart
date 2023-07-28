class Zsc {
  Zsc({
    required this.success,
    required this.result,
  });
  late final int success;
  late final List<Result> result;

  Zsc.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['result'] = result.map((e) => e.toJson()).toList();
    return data;
  }
}

class Result {
  Result({
    required this.leagueKey,
    required this.leagueName,
    required this.countryKey,
    required this.countryName,
    this.leagueLogo,
    this.countryLogo,
  });
  late final int leagueKey;
  late final String leagueName;
  late final int countryKey;
  late final String countryName;
  late final String? leagueLogo;
  late final String? countryLogo;

  Result.fromJson(Map<String, dynamic> json) {
    leagueKey = json['league_key'];
    leagueName = json['league_name'];
    countryKey = json['country_key'];
    countryName = json['country_name'];
    leagueLogo = null;
    countryLogo = null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['league_key'] = leagueKey;
    data['league_name'] = leagueName;
    data['country_key'] = countryKey;
    data['country_name'] = countryName;
    data['league_logo'] = leagueLogo;
    data['country_logo'] = countryLogo;
    return data;
  }
}
