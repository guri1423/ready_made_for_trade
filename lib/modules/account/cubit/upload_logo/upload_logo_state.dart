part of 'upload_logo_cubit.dart';

abstract class UploadLogoState extends Equatable {
  const UploadLogoState();

  @override
  List<Object> get props => [];
}

class UploadLogoInitial extends UploadLogoState {}


class UploadLogoLoaded extends UploadLogoState {
  const UploadLogoLoaded({required this.oldLogoLink});

  final String oldLogoLink;
}
class UploadLogoFailure extends UploadLogoState {}

class UploadNewLogoLoaded extends UploadLogoState {}

class UploadNewLogoFailure extends UploadLogoState {}
