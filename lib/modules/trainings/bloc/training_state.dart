part of 'training_cubit.dart';

abstract class TrainingState extends Equatable {
  const TrainingState();
}

class TrainingInitial extends TrainingState {
  @override
  List<Object> get props => [];
}

class TrainingLoading extends TrainingState {
  @override
  List<Object> get props => [];
}

class TrainingSuccess extends TrainingState {

  GetAllTrainings? model;
  TrainingSuccess(this.model);

  @override
  List<Object> get props => [];
}

class TrainingFailure extends TrainingState {
  @override
  List<Object> get props => [];
}
