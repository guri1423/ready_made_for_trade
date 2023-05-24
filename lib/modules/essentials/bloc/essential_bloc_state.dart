part of 'essential_bloc_cubit.dart';

abstract class EssentialBlocState extends Equatable {
  const EssentialBlocState();
}

class EssentialBlocInitial extends EssentialBlocState {
  @override
  List<Object> get props => [];
}

class EssentialBlocLoading extends EssentialBlocState {
  @override
  List<Object> get props => [];
}

class EssentialBlocSuccess extends EssentialBlocState {

  GetEssentialsData? model;
  EssentialBlocSuccess(this.model);

  @override
  List<Object> get props => [];
}

class EssentialBlocFailure extends EssentialBlocState {
  @override
  List<Object> get props => [];
}

class EssentialSearchSuccess extends EssentialBlocState {

  GetEssentialsData? model;
  EssentialSearchSuccess(this.model);

  @override
  List<Object> get props => [];
}

class EssentialSearchLoading extends EssentialBlocState {
  @override
  List<Object> get props => [];
}

class EssentialSearchEmpty extends EssentialBlocState {
  @override
  List<Object> get props => [];
}

class EssentialSearchFailure extends EssentialBlocState {
  @override
  List<Object> get props => [];
}


