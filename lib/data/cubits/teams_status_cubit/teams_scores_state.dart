part of 'teams_scores_cubit.dart';

@immutable
abstract class TeamsScoresState {}

class TeamsScoresInitial extends TeamsScoresState {}

class TeamsScoresTeams extends TeamsScoresState {
  final TemsModel ourresponse;
  TeamsScoresTeams({required this.ourresponse});
}

class TeamsScoresTopScorers extends TeamsScoresState {
  final TopScorersModel response;
  TeamsScoresTopScorers({required this.response});
}
