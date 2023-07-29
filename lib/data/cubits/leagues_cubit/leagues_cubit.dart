import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:sports_zone/data/models/leagues_model/legues_model.dart';
import 'package:sports_zone/data/repositories/leagues_repo/Leagues_repo.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit() : super(LeaguesInitial());

  getLeagues() {
    emit(LeaguesLoadind());
    LeaguesModelsRepo().getLeaguesModels().then((value) {
      if (value != null) {
        emit(LeaguesSussess(ourrresponse: value));
      } else {
        emit(LeaguesError());
      }
    });
  }
}
