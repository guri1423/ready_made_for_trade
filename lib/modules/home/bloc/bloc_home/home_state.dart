part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  GetUserData? model;
  HomeSuccess(this.model);

  @override
  List<Object> get props => [];
}

class HomeFailure extends HomeState {
  @override
  List<Object> get props => [];
}


