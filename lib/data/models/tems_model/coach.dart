import 'package:collection/collection.dart';

class Coach {
  String? coachName;
  dynamic coachCountry;
  dynamic coachAge;

  Coach({this.coachName, this.coachCountry, this.coachAge});

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        coachName: json['coach_name'] as String?,
        coachCountry: json['coach_country'] as dynamic,
        coachAge: json['coach_age'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'coach_name': coachName,
        'coach_country': coachCountry,
        'coach_age': coachAge,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Coach) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      coachName.hashCode ^ coachCountry.hashCode ^ coachAge.hashCode;
}
