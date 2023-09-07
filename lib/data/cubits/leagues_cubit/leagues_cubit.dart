import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:sports_zone/data/models/leagues_model/legues_model.dart';
import 'package:sports_zone/data/repositories/leagues_repo/leagues_repo.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit() : super(LeaguesInitial());

  getLeagues(int countryId) {
    emit(LeaguesLoadind());
    LeaguesModelsRepo().getLeaguesModels(countryId).then((value) {
      if (value != null) {
        emit(LeaguesSussess(ourrresponse: value));
      } else {
        emit(LeaguesError());
      }
    });
  }
}
