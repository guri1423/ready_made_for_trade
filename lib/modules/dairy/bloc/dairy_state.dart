part of 'dairy_cubit.dart';

abstract class DairyState extends Equatable {
  const DairyState();
}

class DairyInitial extends DairyState {
  @override
  List<Object> get props => [];
}

class DairyLoading extends DairyState {
  @override
  List<Object> get props => [];
}

class DairySuccess extends DairyState {

  GetDairyData? model;

  DairySuccess(this.model);

  @override
  List<Object> get props => [];
}

class DairyFailure extends DairyState {
  @override
  List<Object> get props => [];
}

class DairyFilterLoading extends DairyState {
  @override
  List<Object> get props => [];
}

class DairyFilterSuccess extends DairyState {

  GetDairyData? model;

  DairyFilterSuccess(this.model);

  @override
  List<Object> get props => [];
}

class DairyFilterEmpty extends DairyState {
  @override
  List<Object> get props => [];
}

class DairyFilterFailure extends DairyState {
  @override
  List<Object> get props => [];
}
