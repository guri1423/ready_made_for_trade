import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/f_and_i/model/finance_insurnace_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'finanace_insurance_state.dart';

class FinanaceInsuranceCubit extends Cubit<FinanaceInsuranceState> {
  FinanaceInsuranceCubit() : super(FinanaceInsuranceInitial());

  final RemoteApi _remoteApi = RemoteApi();

  getFinanceInsuranceData(String? type) async {
    emit(FinanaceInsuranceLoading());

    GetFinanceAndInsurance? status =
        await _remoteApi.getFinanceAndInsurance(type);
    if (status != null) {
      emit(FinanaceInsuranceSuccess(status));
    } else {
      emit(FinanaceInsuranceFailure());
    }
  }

  getFinanceInsuranceSearchData(String? search, String? type) async {
    emit(FinanaceInsuranceSearchLoading());

    GetFinanceAndInsurance? status =
        await _remoteApi.searchFinanceAndInsurance(search, type);



    if (status != null) {

      if (status.message == 'Data Not Found') {
        emit(FinanaceInsuranceSearchEmpty());
      }


      emit(FinanaceInsuranceSearchSuccess(status));
    } else {
      emit(FinanaceInsuranceSearchFailure());
    }
  }
}
