import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ready_made_4_trade/modules/account/model/website_text_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'edit_website_text_state.dart';

class EditWebsiteTextCubit extends Cubit<EditWebsiteTextState> {
  EditWebsiteTextCubit() : super(EditWebsiteTextInitial());
  final RemoteApi remoteApi = RemoteApi();

  getWebsiteText() async {
    emit(EditWebsiteTextInitial());
    GetWebsiteTextModel? data = await remoteApi.getWebsiteText();
    if(data != null){
      emit(EditWebsiteTextLoaded(data: data));
    }else{
      emit(EditWebsiteTextFailure());
    }
  }
}
