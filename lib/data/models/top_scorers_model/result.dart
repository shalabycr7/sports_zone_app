import 'package:collection/collection.dart';

class Result {
  int? playerPlace;
  String? playerName;
  int? playerKey;
  String? teamName;
  int? teamKey;
  int? goals;
  dynamic assists;
  int? penaltyGoals;

  Result({
    this.playerPlace,
    this.playerName,
    this.playerKey,
    this.teamName,
    this.teamKey,
    this.goals,
    this.assists,
    this.penaltyGoals,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        playerPlace: json['player_place'] as int?,
        playerName: json['player_name'] as String?,
        playerKey: json['player_key'] as int?,
        teamName: json['team_name'] as String?,
        teamKey: json['team_key'] as int?,
        goals: json['goals'] as int?,
        assists: json['assists'] as dynamic,
        penaltyGoals: json['penalty_goals'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'player_place': playerPlace,
        'player_name': playerName,
        'player_key': playerKey,
        'team_name': teamName,
        'team_key': teamKey,
        'goals': goals,
        'assists': assists,
        'penalty_goals': penaltyGoals,
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
      playerPlace.hashCode ^
      playerName.hashCode ^
      playerKey.hashCode ^
      teamName.hashCode ^
      teamKey.hashCode ^
      goals.hashCode ^
      assists.hashCode ^
      penaltyGoals.hashCode;
}
