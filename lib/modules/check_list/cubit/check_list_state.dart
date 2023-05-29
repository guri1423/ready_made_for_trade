part of 'check_list_cubit.dart';

abstract class CheckListState extends Equatable {
  const CheckListState();

  @override
  List<Object> get props => [];
}

class CheckListInitial extends CheckListState {}

class CheckListUpdateLoading extends CheckListState {
  const CheckListUpdateLoading({required this.data});

  final GetChecklist data;
}

class CheckListLoaded extends CheckListState {
  const CheckListLoaded({required this.data});

  final GetChecklist data;
}

class CheckListFailure extends CheckListState {}
