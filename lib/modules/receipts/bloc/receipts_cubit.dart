import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/modules/gallery/models/get_gallery_images.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'receipts_state.dart';

class ReceiptsCubit extends Cubit<ReceiptsState> {
  ReceiptsCubit() : super(ReceiptsInitial());

  RemoteApi _remoteApi = RemoteApi();

  getReceipts()async{
    emit(ReceiptsLoading());
    GetGalleryImages? status = await _remoteApi.getReceiptsImages();
    emit(ReceiptsSuccess(status));

  }

  sendReceipts()async{
    emit(SendReceiptsLoading());
    GetGalleryImages? status = await _remoteApi.getReceiptsImages();
    emit(SendReceiptsInitial(status));

  }


}
