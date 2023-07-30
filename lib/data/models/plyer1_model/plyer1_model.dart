import 'package:collection/collection.dart';

import 'result.dart';

class Plyer1Model {
  int? success;
  List<Result>? result;

  Plyer1Model({this.success, this.result});

  factory Plyer1Model.fromJson(Map<String, dynamic> json) => Plyer1Model(
        success: json['success'] as int?,
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'result': result?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Plyer1Model) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode;
}
