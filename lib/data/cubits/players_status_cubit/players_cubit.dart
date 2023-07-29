import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sports_zone/data/models/countries_model/countries_model.dart';
import 'package:sports_zone/data/models/plyer1_model/plyer1_model.dart';
import 'package:sports_zone/data/models/tems_model/tems_model.dart';
import 'package:sports_zone/data/repositories/players_repo/players_repo.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit() : super(PlayersInitial());

  getPlayer(String tm) {
    Players().getPlayers(tm).then((value) {
      if (value != null) emit(PlayersAll(ourresponse: value));
    });
  }

  getPlayer1(String srch) {
    Players().getPlayer(srch).then((value) {
      if (value != null) emit(PlayersOne(ourresponse1: value));
    });
  }
}
