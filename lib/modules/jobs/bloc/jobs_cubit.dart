import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_status.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit() : super(JobsInitial());
  final RemoteApi apiServices = RemoteApi();

  loadAllJobs() async {
    GetJobStatus? jobStatus = await apiServices.getJobStatus();
    if (jobStatus != null) {
      emit(JobsLoaded(jobStatus: jobStatus));
    } else {
      emit(JobsFailure());
    }
  }
}
