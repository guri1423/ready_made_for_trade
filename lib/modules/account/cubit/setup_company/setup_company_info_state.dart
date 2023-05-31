part of 'setup_company_info_cubit.dart';

abstract class SetupCompanyInfoState extends Equatable {
  const SetupCompanyInfoState();

  @override
  List<Object> get props => [];
}

class SetupCompanyInfoInitial extends SetupCompanyInfoState {}

class SetupCompanyInfoLoaded extends SetupCompanyInfoState {
  const SetupCompanyInfoLoaded({required this.data});

  final SetupCompanyData data;
}

class SetupCompanyInfoUpdateLoading extends SetupCompanyInfoState {
  const SetupCompanyInfoUpdateLoading({required this.data});

  final SetupCompanyData data;
}

class SetupCompanyInfoUpdateSuccess extends SetupCompanyInfoState {}

class SetupCompanyInfoUpdateFailure extends SetupCompanyInfoState {}
