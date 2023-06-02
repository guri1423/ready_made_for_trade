import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/essentials/models/get_essentails_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'essential_bloc_state.dart';

class EssentialBlocCubit extends Cubit<EssentialBlocState> {
  EssentialBlocCubit() : super(EssentialBlocInitial());

  RemoteApi _remoteApi = RemoteApi();

  getAllMaterials() async {
    emit(EssentialBlocLoading());

    GetEssentialsData? model = await _remoteApi.getAllEssentials();

    if (model != null) {
      emit(EssentialBlocSuccess(model));
    } else {
      emit(EssentialBlocFailure());
    }
  }

  getSearchEssential(String? search) async {
    emit(EssentialSearchLoading());

    GetEssentialsData? status = await _remoteApi.getSearchEssentials(search);

    if (status == null) {
      emit(EssentialSearchEmpty());
    } else if (status.message.contains('Data Not Found')) {
      emit(EssentialSearchEmpty());
    } else {
      emit(EssentialSearchSuccess(status));
    }
  }
}
