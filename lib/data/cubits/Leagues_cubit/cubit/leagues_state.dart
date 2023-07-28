import 'package:flutter/foundation.dart';
import 'package:sports_zone/data/models/leaguesModele/leagues.dart';

@immutable
abstract class LeaguesState {}

class LeaguesInitial extends LeaguesState {}

class LeaguesLoadind extends LeaguesState {}

class LeaguesSussess extends LeaguesState {
  final Zsc ourrresponse;
  LeaguesSussess({required this.ourrresponse});
}

class LeaguesError extends LeaguesState {}
