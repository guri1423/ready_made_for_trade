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

class JobsDataByIdLoaded extends JobsState {
  const JobsDataByIdLoaded({required this.jobData});

  final GetJobData jobData;
}

class JobsInvoiceLoaded extends JobsState {
  const JobsInvoiceLoaded({required this.data});

  final GetJobInvoiceData data;
}

class JobsDataByStatusLoaded extends JobsState {
  const JobsDataByStatusLoaded({required this.jobData});

  final JobsModel jobData;
}

class JobsFailure extends JobsState {}
