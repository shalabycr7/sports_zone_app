part of 'countires_cubit.dart';

@immutable
abstract class CountiresState {}

class CountiresInitial extends CountiresState {}

class CountiresLoadind extends CountiresState {}

class CountiresSussess extends CountiresState {
  final CountiersModels ourresponse;
  CountiresSussess({required this.ourresponse});
}

class CountiresError extends CountiresState {}
