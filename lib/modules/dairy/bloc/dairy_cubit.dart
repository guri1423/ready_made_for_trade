import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/dairy/model/get_diary_data_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'dairy_state.dart';

class DairyCubit extends Cubit<DairyState> {
  DairyCubit() : super(DairyInitial());

  RemoteApi _remoteApi = RemoteApi();

  getDiaryData() async {
    emit(DairyLoading());

    GetDairyData? model = await _remoteApi.getDiaryData();

    if (model != null) {
      emit(DairySuccess(model));
    } else {
      emit(DairyFailure());
    }
  }

  getDiaryFilterData(String? status, String? date) async {
    emit(DairyLoading());

    GetDairyData? model = await _remoteApi.getDiaryFilterData(status, date);

    if (model!.message == "No Data Found") {
      emit(DairyFilterEmpty());
    }
    if (model.message == "Data Get Successful!") {
      emit(DairyFilterSuccess(model));
    } else {
      emit(DairyFilterFailure());
    }
  }
}
