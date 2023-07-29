import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/countries_model/countries_model.dart';
import '../../../models/plyer1_model/plyer1_model.dart';
import '../../../models/tems_model/tems_model.dart';
import '../../../repositories/players_repo.dart';

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
