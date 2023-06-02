import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/modules/home/model/get_user_data.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'upload_logo_state.dart';

class UploadLogoCubit extends Cubit<UploadLogoState> {
  UploadLogoCubit() : super(UploadLogoInitial());
  RemoteApi remoteApi = RemoteApi();

  getOldLogo() async {
    GetUserData? model = await remoteApi.fetchUserInfo();
    if (model != null) {
      emit(UploadLogoLoaded(
          oldLogoLink: '${model.data.filePath}/${model.data.logo}'));
    } else {
      emit(UploadLogoFailure());
    }
  }

  uploadNewLogo(File imageFile) async {
    bool status = await remoteApi.uploadLogo(file: imageFile);
    if (status) {
      emit(UploadNewLogoLoaded());
    } else {
      emit(UploadNewLogoFailure());
    }
  }
}
