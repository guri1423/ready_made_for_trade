part of 'jobs_cubit.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

class JobsInitial extends JobsState {}

class JobsLoaded extends JobsState {
  const JobsLoaded({required this.jobStatus});

  final GetJobStatus jobStatus;
}

class JobsFailure extends JobsState {}
