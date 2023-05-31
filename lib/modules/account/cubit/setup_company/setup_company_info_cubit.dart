import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/account/model/setup_cmpany_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'setup_company_info_state.dart';

class SetupCompanyInfoCubit extends Cubit<SetupCompanyInfoState> {
  SetupCompanyInfoCubit() : super(SetupCompanyInfoInitial());
  final RemoteApi remoteApi = RemoteApi();
  GetCompanyInfo? data;

  getCompanyInfo() async {
    data = await remoteApi.getCompanyInfo();
    if (data != null) {
      emit(SetupCompanyInfoLoaded(data: data!.data));
    } else {
      emit(SetupCompanyInfoUpdateFailure());
    }
  }

  updateCompany({required SetupCompanyData model}) async {
    emit(SetupCompanyInfoUpdateLoading(data: data!.data));
    await remoteApi.updateCompanyInfo(setupCompanyData: model);
    getCompanyInfo();
  }
}
