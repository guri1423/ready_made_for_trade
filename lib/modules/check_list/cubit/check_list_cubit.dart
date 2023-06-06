import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_model.dart';
import 'package:ready_made_4_trade/modules/check_list/models/checklist_status_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'check_list_state.dart';

class CheckListCubit extends Cubit<CheckListState> {
  CheckListCubit() : super(CheckListInitial());
  final RemoteApi _remoteApi = RemoteApi();
  GetChecklist? data;

  getAllChecklist({
    required String userID,
  }) async {
    emit(CheckListInitial());
    data = await _remoteApi.getChecklist();
    if (data != null) {
      getChecklistStatus(userID: userID, model: data!);
    } else {
      emit(CheckListFailure());
    }
  }

  void getChecklistStatus(
      {required String userID, required GetChecklist model}) async {
    UserChecklistStatus? checklistStatus =
        await _remoteApi.getUserChecklistStatus(userID: userID);
    emit(CheckListLoaded(data: data!, checklistStatus: checklistStatus!));
  }

  updateCheckListStatus(
      {required String userId, required Map<String, dynamic> status}) async {
    // emit(CheckListUpdateLoading(data: data!));
    await _remoteApi.updateChecklistStatus(userID: userId, status: status);
    getAllChecklist(userID: userId);
  }
}
