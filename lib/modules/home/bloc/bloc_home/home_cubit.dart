import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/home/model/get_user_data.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  RemoteApi _remoteApi = RemoteApi();

  getUserData() async {
    emit(HomeLoading());

    GetUserData? model = await _remoteApi.fetchUserInfo();

    if (model != null) {
      emit(HomeSuccess(model));
    } else {
      emit(HomeFailure());
    }
  }
}
