import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ready_made_4_trade/services/remote_api.dart';
import '../models/get_all_trades_model.dart';
part 'search_trades_state.dart';

class SearchTradesCubit extends Cubit<SearchTradesState> {
  SearchTradesCubit() : super(SearchTradesInitial());

  final RemoteApi _api = RemoteApi();

  getTrades() async {
    emit(TradesLoading());
    GetAllTrades? model = await _api.getAllTrades();

    if (model != null) {
      emit(TradesSuccess(model));
    } else {
      emit(TradesFailure());
    }
  }

  searchTrades(String controller) async {
    emit(TradesLoading());
    GetAllTrades? model = await _api.getSearchTrades(controller);

    if (model == null || model.message == 'Data Not Found') {
      emit(SearchTradesEmpty());
    } else {
      emit(SearchTradesSuccess(model));
    }
  }

  filterTrades(String value)async{
    emit(FilterTradesInitial());

    GetAllTrades? model = await _api.filterTrades(value);
    if (model == null ||  model.message.contains('Data Not Found')) {
      emit(FilterTradesEmpty());
    } else {
      emit(FilterTradesSuccess(model));
    }

  }



}
