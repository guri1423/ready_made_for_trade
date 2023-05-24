part of 'customer_search_cubit.dart';

abstract class CustomerSearchState extends Equatable {
  const CustomerSearchState();
}

class CustomerSearchInitial extends CustomerSearchState {
  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerSearchState {
  GetCustomerModel? model;

  CustomerInitial(this.model);

  @override
  List<Object> get props => [];
}

class CustomerLoading extends CustomerSearchState {


  @override
  List<Object> get props => [];
}

class CustomerSuccess extends CustomerSearchState {
  GetCustomerModel? model;

  CustomerSuccess(this.model);

  @override
  List<Object> get props => [];
}

class CustomerEmpty extends CustomerSearchState {
  @override
  List<Object> get props => [];
}

class CustomerFail extends CustomerSearchState {
  @override
  List<Object> get props => [];
}

class CustomerSearchSuccess extends CustomerSearchState {
  GetCustomerModel? model;

  CustomerSearchSuccess(this.model);

  @override
  List<Object> get props => [];
}

class CustomerSearchEmpty extends CustomerSearchState {
  @override
  List<Object> get props => [];
}
