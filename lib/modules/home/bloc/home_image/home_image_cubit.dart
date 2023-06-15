import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/home/model/home_image_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'home_image_state.dart';

class HomeImageCubit extends Cubit<HomeImageState> {
  HomeImageCubit() : super(HomeImageInitial());

  loadImage() async {
    HomeImage? data = await remoteApi.getImage();
    if (data != null) {
      emit(HomeImageLoaded(homeImage: data));
    } else {
      emit(HomeImageFailure());
    }
  }

  final RemoteApi remoteApi = RemoteApi();
}
