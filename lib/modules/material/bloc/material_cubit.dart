import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/material/models/get_materials_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialPageState> {
  MaterialCubit() : super(MaterialInitial());

  RemoteApi _remoteApi = RemoteApi();

  getMaterials() async {
    emit(MaterialLoading());

    GetAllMaterials? model = await _remoteApi.getAllMaterials();

    if (model != null) {
      emit(MaterialSuccess(model));
    } else {
      emit(MaterialFailure());
    }
  }

  getMaterialSearch(String search) async {
    emit(MaterialSearchLoading());

    GetAllMaterials? model = await _remoteApi.getSearchMaterials(search);

    if (model != null) {
      emit(MaterialSearchSuccess(model));
    } else {
      emit(MaterialSearchEmpty());
    }
  }
}
