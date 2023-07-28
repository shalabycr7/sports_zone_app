import 'package:collection/collection.dart';

class Result {
  int? countryKey;
  String? countryName;
  String? countryIso2;
  String? countryLogo;

  Result({
    this.countryKey,
    this.countryName,
    this.countryIso2,
    this.countryLogo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        countryKey: json['country_key'] as int?,
        countryName: json['country_name'] as String?,
        countryIso2: json['country_iso2'] as String?,
        countryLogo: json['country_logo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'country_key': countryKey,
        'country_name': countryName,
        'country_iso2': countryIso2,
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
      countryKey.hashCode ^
      countryName.hashCode ^
      countryIso2.hashCode ^
      countryLogo.hashCode;
}
