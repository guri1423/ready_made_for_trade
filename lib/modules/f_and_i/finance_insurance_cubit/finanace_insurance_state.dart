part of 'finanace_insurance_cubit.dart';

abstract class FinanaceInsuranceState extends Equatable {
  const FinanaceInsuranceState();
}

class FinanaceInsuranceInitial extends FinanaceInsuranceState {
  @override
  List<Object> get props => [];
}


class FinanaceInsuranceLoading extends FinanaceInsuranceState {
  @override
  List<Object> get props => [];
}

class FinanaceInsuranceSuccess extends FinanaceInsuranceState {


  GetFinanceAndInsurance? model;

  FinanaceInsuranceSuccess(this.model);

  @override
  List<Object> get props => [];
}

class FinanaceInsuranceFailure extends FinanaceInsuranceState {
  @override
  List<Object> get props => [];
}


class FinanaceInsuranceSearchLoading extends FinanaceInsuranceState {
  @override
  List<Object> get props => [];
}

class FinanaceInsuranceSearchSuccess extends FinanaceInsuranceState {
  GetFinanceAndInsurance model;

  FinanaceInsuranceSearchSuccess(this.model);

  @override
  List<Object> get props => [];
}

class FinanaceInsuranceSearchFailure extends FinanaceInsuranceState {
  @override
  List<Object> get props => [];
}


class FinanaceInsuranceSearchEmpty extends FinanaceInsuranceState {


  @override
  List<Object> get props => [];
}
