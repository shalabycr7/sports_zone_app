import 'package:collection/collection.dart';

class Result {
  int? leagueKey;
  String? leagueName;
  int? countryKey;
  String? countryName;
  String? leagueLogo;
  dynamic countryLogo;

  Result({
    this.leagueKey,
    this.leagueName,
    this.countryKey,
    this.countryName,
    this.leagueLogo,
    this.countryLogo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        leagueKey: json['league_key'] as int?,
        leagueName: json['league_name'] as String?,
        countryKey: json['country_key'] as int?,
        countryName: json['country_name'] as String?,
        leagueLogo: json['league_logo'] as String?,
        countryLogo: json['country_logo'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'league_key': leagueKey,
        'league_name': leagueName,
        'country_key': countryKey,
        'country_name': countryName,
        'league_logo': leagueLogo,
        'country_logo': countryLogo,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Result) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      leagueKey.hashCode ^
      leagueName.hashCode ^
      countryKey.hashCode ^
      countryName.hashCode ^
      leagueLogo.hashCode ^
      countryLogo.hashCode;
}
