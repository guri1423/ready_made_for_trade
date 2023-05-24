import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:ready_made_4_trade/modules/home/pages/icon_models/customer_model.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';

part 'customer_search_state.dart';

class CustomerSearchCubit extends Cubit<CustomerSearchState> {
  CustomerSearchCubit() : super(CustomerSearchInitial());

  final RemoteApi _api = RemoteApi();

  getCustomer() async {
    emit(CustomerLoading());
    GetCustomerModel? model = await _api.getCustomers();

    if (model!= null) {
      emit(CustomerSuccess(model));
    } else {
      emit(CustomerEmpty());
    }
  }

  searchCustomer(String controller) async {
    GetCustomerModel? model = await _api.getSearchCustomer(controller);

    if (model != null) {
      emit(CustomerSearchSuccess(model));
    } else {
      emit(CustomerSearchEmpty());
    }
  }
}
