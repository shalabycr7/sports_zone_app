import 'package:collection/collection.dart';

class Result {
  int? playerKey;
  String? playerName;
  String? playerNumber;
  dynamic playerCountry;
  String? playerType;
  String? playerAge;
  String? playerMatchPlayed;
  String? playerGoals;
  String? playerYellowCards;
  String? playerRedCards;
  String? playerMinutes;
  String? playerInjured;
  String? playerSubstituteOut;
  String? playerSubstitutesOnBench;
  String? playerAssists;
  String? playerIsCaptain;
  String? playerShotsTotal;
  String? playerGoalsConceded;
  String? playerFoulsCommited;
  String? playerTackles;
  String? playerBlocks;
  String? playerCrossesTotal;
  String? playerInterceptions;
  String? playerClearances;
  String? playerDispossesed;
  String? playerSaves;
  String? playerInsideBoxSaves;
  String? playerDuelsTotal;
  String? playerDuelsWon;
  String? playerDribbleAttempts;
  String? playerDribbleSucc;
  String? playerPenComm;
  String? playerPenWon;
  String? playerPenScored;
  String? playerPenMissed;
  String? playerPasses;
  String? playerPassesAccuracy;
  String? playerKeyPasses;
  String? playerWoordworks;
  String? playerRating;
  String? teamName;
  int? teamKey;
  String? playerImage;

  Result({
    this.playerKey,
    this.playerName,
    this.playerNumber,
    this.playerCountry,
    this.playerType,
    this.playerAge,
    this.playerMatchPlayed,
    this.playerGoals,
    this.playerYellowCards,
    this.playerRedCards,
    this.playerMinutes,
    this.playerInjured,
    this.playerSubstituteOut,
    this.playerSubstitutesOnBench,
    this.playerAssists,
    this.playerIsCaptain,
    this.playerShotsTotal,
    this.playerGoalsConceded,
    this.playerFoulsCommited,
    this.playerTackles,
    this.playerBlocks,
    this.playerCrossesTotal,
    this.playerInterceptions,
    this.playerClearances,
    this.playerDispossesed,
    this.playerSaves,
    this.playerInsideBoxSaves,
    this.playerDuelsTotal,
    this.playerDuelsWon,
    this.playerDribbleAttempts,
    this.playerDribbleSucc,
    this.playerPenComm,
    this.playerPenWon,
    this.playerPenScored,
    this.playerPenMissed,
    this.playerPasses,
    this.playerPassesAccuracy,
    this.playerKeyPasses,
    this.playerWoordworks,
    this.playerRating,
    this.teamName,
    this.teamKey,
    this.playerImage,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        playerKey: json['player_key'] as int?,
        playerName: json['player_name'] as String?,
        playerNumber: json['player_number'] as String?,
        playerCountry: json['player_country'] as dynamic,
        playerType: json['player_type'] as String?,
        playerAge: json['player_age'] as String?,
        playerMatchPlayed: json['player_match_played'] as String?,
        playerGoals: json['player_goals'] as String?,
        playerYellowCards: json['player_yellow_cards'] as String?,
        playerRedCards: json['player_red_cards'] as String?,
        playerMinutes: json['player_minutes'] as String?,
        playerInjured: json['player_injured'] as String?,
        playerSubstituteOut: json['player_substitute_out'] as String?,
        playerSubstitutesOnBench:
            json['player_substitutes_on_bench'] as String?,
        playerAssists: json['player_assists'] as String?,
        playerIsCaptain: json['player_is_captain'] as String?,
        playerShotsTotal: json['player_shots_total'] as String?,
        playerGoalsConceded: json['player_goals_conceded'] as String?,
        playerFoulsCommited: json['player_fouls_commited'] as String?,
        playerTackles: json['player_tackles'] as String?,
        playerBlocks: json['player_blocks'] as String?,
        playerCrossesTotal: json['player_crosses_total'] as String?,
        playerInterceptions: json['player_interceptions'] as String?,
        playerClearances: json['player_clearances'] as String?,
        playerDispossesed: json['player_dispossesed'] as String?,
        playerSaves: json['player_saves'] as String?,
        playerInsideBoxSaves: json['player_inside_box_saves'] as String?,
        playerDuelsTotal: json['player_duels_total'] as String?,
        playerDuelsWon: json['player_duels_won'] as String?,
        playerDribbleAttempts: json['player_dribble_attempts'] as String?,
        playerDribbleSucc: json['player_dribble_succ'] as String?,
        playerPenComm: json['player_pen_comm'] as String?,
        playerPenWon: json['player_pen_won'] as String?,
        playerPenScored: json['player_pen_scored'] as String?,
        playerPenMissed: json['player_pen_missed'] as String?,
        playerPasses: json['player_passes'] as String?,
        playerPassesAccuracy: json['player_passes_accuracy'] as String?,
        playerKeyPasses: json['player_key_passes'] as String?,
        playerWoordworks: json['player_woordworks'] as String?,
        playerRating: json['player_rating'] as String?,
        teamName: json['team_name'] as String?,
        teamKey: json['team_key'] as int?,
        playerImage: json['player_image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'player_key': playerKey,
        'player_name': playerName,
        'player_number': playerNumber,
        'player_country': playerCountry,
        'player_type': playerType,
        'player_age': playerAge,
        'player_match_played': playerMatchPlayed,
        'player_goals': playerGoals,
        'player_yellow_cards': playerYellowCards,
        'player_red_cards': playerRedCards,
        'player_minutes': playerMinutes,
        'player_injured': playerInjured,
        'player_substitute_out': playerSubstituteOut,
        'player_substitutes_on_bench': playerSubstitutesOnBench,
        'player_assists': playerAssists,
        'player_is_captain': playerIsCaptain,
        'player_shots_total': playerShotsTotal,
        'player_goals_conceded': playerGoalsConceded,
        'player_fouls_commited': playerFoulsCommited,
        'player_tackles': playerTackles,
        'player_blocks': playerBlocks,
        'player_crosses_total': playerCrossesTotal,
        'player_interceptions': playerInterceptions,
        'player_clearances': playerClearances,
        'player_dispossesed': playerDispossesed,
        'player_saves': playerSaves,
        'player_inside_box_saves': playerInsideBoxSaves,
        'player_duels_total': playerDuelsTotal,
        'player_duels_won': playerDuelsWon,
        'player_dribble_attempts': playerDribbleAttempts,
        'player_dribble_succ': playerDribbleSucc,
        'player_pen_comm': playerPenComm,
        'player_pen_won': playerPenWon,
        'player_pen_scored': playerPenScored,
        'player_pen_missed': playerPenMissed,
        'player_passes': playerPasses,
        'player_passes_accuracy': playerPassesAccuracy,
        'player_key_passes': playerKeyPasses,
        'player_woordworks': playerWoordworks,
        'player_rating': playerRating,
        'team_name': teamName,
        'team_key': teamKey,
        'player_image': playerImage,
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
      playerKey.hashCode ^
      playerName.hashCode ^
      playerNumber.hashCode ^
      playerCountry.hashCode ^
      playerType.hashCode ^
      playerAge.hashCode ^
      playerMatchPlayed.hashCode ^
      playerGoals.hashCode ^
      playerYellowCards.hashCode ^
      playerRedCards.hashCode ^
      playerMinutes.hashCode ^
      playerInjured.hashCode ^
      playerSubstituteOut.hashCode ^
      playerSubstitutesOnBench.hashCode ^
      playerAssists.hashCode ^
      playerIsCaptain.hashCode ^
      playerShotsTotal.hashCode ^
      playerGoalsConceded.hashCode ^
      playerFoulsCommited.hashCode ^
      playerTackles.hashCode ^
      playerBlocks.hashCode ^
      playerCrossesTotal.hashCode ^
      playerInterceptions.hashCode ^
      playerClearances.hashCode ^
      playerDispossesed.hashCode ^
      playerSaves.hashCode ^
      playerInsideBoxSaves.hashCode ^
      playerDuelsTotal.hashCode ^
      playerDuelsWon.hashCode ^
      playerDribbleAttempts.hashCode ^
      playerDribbleSucc.hashCode ^
      playerPenComm.hashCode ^
      playerPenWon.hashCode ^
      playerPenScored.hashCode ^
      playerPenMissed.hashCode ^
      playerPasses.hashCode ^
      playerPassesAccuracy.hashCode ^
      playerKeyPasses.hashCode ^
      playerWoordworks.hashCode ^
      playerRating.hashCode ^
      teamName.hashCode ^
      teamKey.hashCode ^
      playerImage.hashCode;
}
