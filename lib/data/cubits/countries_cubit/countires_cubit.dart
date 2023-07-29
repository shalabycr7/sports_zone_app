import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sports_zone/data/models/countries_model/countries_model.dart';
import 'package:sports_zone/data/repositories/countries_repo/countires_repo.dart';

part 'countires_state.dart';

class CountiresCubit extends Cubit<CountiresState> {
  CountiresCubit() : super(CountiresInitial());

  getCountiers() {
    emit(CountiresLoadind());
    CountiersModelsRepo().getCountiersModels().then((value) {
      if (value != null) {
        emit(CountiresSussess(ourresponse: value));
      } else {
        emit(CountiresError());
      }
    });
  }
}
