import 'result.dart';

class TopScorers {
  int? success;
  List<Result>? result;

  TopScorers({this.success, this.result});

  factory TopScorers.fromJson(Map<String, dynamic> json) => TopScorers(
        success: json['success'] as int?,
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'result': result?.map((e) => e.toJson()).toList(),
      };
}
