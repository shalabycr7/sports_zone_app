import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:sports_zone/data/models/Countires/countries_model.dart';
import 'package:sports_zone/data/repositories/Countires_repo.dart';

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
