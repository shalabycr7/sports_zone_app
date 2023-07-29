part of 'leagues_cubit.dart';

@immutable
abstract class LeaguesState {}

class LeaguesInitial extends LeaguesState {}

class LeaguesLoadind extends LeaguesState {}

class LeaguesSussess extends LeaguesState {
  final Zsc ourrresponse;
  LeaguesSussess({required this.ourrresponse});
}

class LeaguesError extends LeaguesState {}
