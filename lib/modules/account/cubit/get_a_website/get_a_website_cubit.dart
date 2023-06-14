/*
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/account/model/get_website_model.dart';
import 'package:ready_made_4_trade/modules/material/models/get_materials_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'get_a_website_state.dart';

class WebSiteCubit extends Cubit<GetWebsitePageState> {
  WebSiteCubit() : super(WebSiteInitial());

  RemoteApi _remoteApi = RemoteApi();

  getMaterials() async {
    emit(WebSiteLoading());

    GetAllMaterials? model = await _remoteApi.getAllMaterials();

    if (model != null) {
      emit(WebSiteSuccess(model));
    } else {
      emit(WebSiteFailure());
    }
  }

  getMaterialSearch(String search) async {
    emit(WebSiteSearchLoading());

    Getwebsite? model = await _remoteApi. getwebsite();

    if (model != null) {
      emit(WebSiteSearchSuccess(model));
    } else {
      emit(WebSiteSearchEmpty());
    }
  }
}
*/
