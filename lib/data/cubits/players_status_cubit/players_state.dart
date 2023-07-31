part of 'players_cubit.dart';

@immutable
abstract class PlayersState {}

class PlayersInitial extends PlayersState {}

class PlayersAll extends PlayersState {
  final TemsModel ourresponse;
  PlayersAll({required this.ourresponse});
}

class PlayersOne extends PlayersState {
  final Plyer1Model ourresponse1;
  PlayersOne({required this.ourresponse1});
}


