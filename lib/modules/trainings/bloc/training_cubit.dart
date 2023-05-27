import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/trainings/models/get_trainings_model.dart';
import 'package:ready_made_4_trade/modules/trainings/models/training_status_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit() : super(TrainingInitial());

  RemoteApi _remoteApi = RemoteApi();

  getAllTrainings({
    required String userID,
  }) async {
    emit(TrainingLoading());

    GetAllTrainings? model = await _remoteApi.getAllTrainings();

    if (model != null) {
      getTrainingStatus(userID: userID, model: model);
    } else {
      emit(TrainingFailure());
    }
  }

  void getTrainingStatus(
      {required String userID, required GetAllTrainings model}) async {
    UserTrainingStatus? trainingStatus =
        await _remoteApi.getTrainingsStatus(userID: userID);
    emit(TrainingSuccess(model, trainingStatus!));
  }

  storeTrainingUpdate(
      {required String customerId,
      required String userID,
      required Map<String, dynamic> status}) async {
    await _remoteApi.saveTrainingStatus(
        userID: userID, customerId: customerId, status: status);
    getAllTrainings(userID: userID);
  }
}
