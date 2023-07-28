import 'package:collection/collection.dart';

import 'result.dart';

class CountriesModel {
  int? success;
  List<Result>? result;

  CountriesModel({this.success, this.result});

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      success: json['success'] as int?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'result': result?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CountriesModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode;
}
