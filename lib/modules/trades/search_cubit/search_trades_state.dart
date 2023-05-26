part of 'search_trades_cubit.dart';

abstract class SearchTradesState extends Equatable {
  const SearchTradesState();
}

class TradesLoading extends SearchTradesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchTradesInitial extends SearchTradesState {
  @override
  List<Object> get props => [];
}

class TradesSuccess extends SearchTradesState {
  GetAllTrades? model;

  TradesSuccess(this.model);

  @override
  List<Object> get props => [];
}

class TradesFailure extends SearchTradesState {
  @override
  List<Object> get props => [];
}

class SearchTradesSuccess extends SearchTradesState {
  GetAllTrades? model;

  SearchTradesSuccess(this.model);

  @override
  List<Object> get props => [];
}

class SearchTradesEmpty extends SearchTradesState {
  @override
  List<Object> get props => [];
}

class FilterTradesInitial extends SearchTradesState {
  @override
  List<Object> get props => [];
}

class FilterTradesSuccess extends SearchTradesState {
  GetAllTrades? model;
  FilterTradesSuccess(this.model);
  @override
  List<Object> get props => [];
}

class FilterTradesEmpty extends SearchTradesState {
  @override
  List<Object> get props => [];
}

class FilterTradesFailure extends SearchTradesState {
  @override
  List<Object> get props => [];
}

