part of 'receipts_cubit.dart';

abstract class ReceiptsState extends Equatable {
  const ReceiptsState();
}

class ReceiptsInitial extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class ReceiptsLoading extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class ReceiptsSuccess extends ReceiptsState {
  GetGalleryImages? model;
  ReceiptsSuccess(this.model);

  @override
  List<Object> get props => [];
}

class ReceiptsFailure extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class SendReceiptsInitial extends ReceiptsState {
  GetGalleryImages? model;
  SendReceiptsInitial(this.model);

  @override
  List<Object> get props => [];
}

class SendReceiptsFailure extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class SendReceiptsLoading extends ReceiptsState {
  @override
  List<Object> get props => [];
}

class SendReceiptsSuccess extends ReceiptsState {
  GetGalleryImages? model;
  SendReceiptsSuccess(this.model);

  @override
  List<Object> get props => [];
}
