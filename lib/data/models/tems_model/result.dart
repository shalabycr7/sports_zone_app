import 'package:collection/collection.dart';

import 'coach.dart';
import 'player.dart';

class Result {
  int? teamKey;
  String? teamName;
  String? teamLogo;
  List<Player>? players;
  List<Coach>? coaches;

  Result({
    this.teamKey,
    this.teamName,
    this.teamLogo,
    this.players,
    this.coaches,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        teamKey: json['team_key'] as int?,
        teamName: json['team_name'] as String?,
        teamLogo: json['team_logo'] as String?,
        players: (json['players'] as List<dynamic>?)
            ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
            .toList(),
        coaches: (json['coaches'] as List<dynamic>?)
            ?.map((e) => Coach.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'team_key': teamKey,
        'team_name': teamName,
        'team_logo': teamLogo,
        'players': players?.map((e) => e.toJson()).toList(),
        'coaches': coaches?.map((e) => e.toJson()).toList(),
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
      teamKey.hashCode ^
      teamName.hashCode ^
      teamLogo.hashCode ^
      players.hashCode ^
      coaches.hashCode;
}
