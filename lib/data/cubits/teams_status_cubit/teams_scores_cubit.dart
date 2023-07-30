import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../screens/teams_scores_screen.dart';
import '../../models/tems_model/tems_model.dart';
import '../../models/top_scorers_model/top_scorers_model.dart';
import '../../repositories/teams_repo/team_repo.dart';
import '../../repositories/top_scorers_repo/topscorers_repo.dart';
//import '../../repositories/topscorers_repo.dart';
//lib/data/repositories/topscorers_repo.dart
part 'teams_scores_state.dart';

class TeamsScoresCubit extends Cubit<TeamsScoresState> {
  TeamsScoresCubit() : super(TeamsScoresInitial());

  Future<void> getTeam(int id) async {
    emit(TeamsScoresLoading());
    Teams_Scorer().getTeams(search.text, id).then((value) {
      if (value != null) {
        print("on");
        emit(TeamsScoresTeams(ourresponse: value));
      } else {
        print("no yes");
        emit(TeamsScoresError());
      }
    });
  }

  Future<void> getTopScorers(int id) async {
    emit(TeamsScoresLoading());
    TopScorer().getTopScorers(id).then((value) {
      if (value != null) {
        print("on");
        emit(TeamsScoresTopScorers(response: value));
      } else {
        print("no yes");
        emit(TeamsScoresError());
      }
    });
  }
}
