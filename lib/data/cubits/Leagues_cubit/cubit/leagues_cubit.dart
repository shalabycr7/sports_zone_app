import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_zone/data/cubits/Leagues_cubit/cubit/leagues_state.dart';
import 'package:sports_zone/data/repositories/LeaguesRepo/Leagues_repo.dart';

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


// class LeaguesCubit extends Cubit<LeaguesState> {
//   LeaguesCubit() : super(LeaguesInitial());

//   getLeagues() {
//     emit(LeaguesLoadind());
//     LeaguesModelsRepo().getLeaguesModels().then((value) {
//       if (value != null) {
//         emit(LeaguesSussess(ourrresponse: value));
//       } else {
//         emit(LeaguesError());
//       }
//     });
//   }
// }