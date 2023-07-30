import 'package:collection/collection.dart';

class Player {
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
  String? playerImage;

  Player({
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
    this.playerImage,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
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
        'player_image': playerImage,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Player) return false;
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
      playerImage.hashCode;
}
