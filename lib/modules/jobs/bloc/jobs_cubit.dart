import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/modules/home/pages/icon_models/jobs_model.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_data.dart';
import 'package:ready_made_4_trade/modules/jobs/models/get_job_invoice.dart';
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

  getJobsData(String jobId) async {
    GetJobData? jobData = await apiServices.getJobData(jobId);
    if (jobData != null) {
      emit(JobsDataByIdLoaded(jobData: jobData));
    } else {
      emit(JobsFailure());
    }
  }

  getAllJobsByStatus(String status) async {
    emit(JobsInitial());
    JobsModel? jobData = await apiServices.getJobsOnStatusBasis(status);
    if (jobData != null) {
      emit(JobsDataByStatusLoaded(jobData: jobData));
    } else {
      emit(JobsFailure());
    }
  }

  getJobInvoiceData(int jobID) async {
    GetJobInvoiceData? data = await apiServices.getJobInvoice(jobID);
    if (data != null) {
      emit(JobsInvoiceLoaded(data: data));
    } else {
      emit(JobsFailure());
    }
  }
}
