import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../screens/teams_scores_screen.dart';
import '../../models/tems_model/tems_model.dart';
import '../../models/top_scorers/top_scorers.dart';
import '../../models/top_scorers_model/top_scorers_model.dart';
import '../../repositories/players_repo.dart';
import '../../repositories/team_repo.dart';
import '../../repositories/topscorers_repo.dart';
//import '../../repositories/topscorers_repo.dart';
//lib/data/repositories/topscorers_repo.dart
part 'teams_scores_state.dart';

class TeamsScoresCubit extends Cubit<TeamsScoresState> {
  TeamsScoresCubit() : super(TeamsScoresInitial());

  getTeam() {
    // emit(AllNewsCubitLoading());
    Teams_Scorer().getTeams(Search.text).then((value) {
      if (value != null) emit(TeamsScoresTeams(ourresponse: value));
    });
  }

  getTopScorers() {
    // emit(AllNewsCubitLoading());
    TopScorer().getTopScorers().then((value) {
      if (value != null) emit(TeamsScoresTopScorers(response: value));
    });
  }
}
