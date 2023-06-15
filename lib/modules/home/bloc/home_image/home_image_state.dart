part of 'home_image_cubit.dart';

abstract class HomeImageState extends Equatable {
  const HomeImageState();

  @override
  List<Object> get props => [];
}

class HomeImageInitial extends HomeImageState {}

class HomeImageFailure extends HomeImageState {}

class HomeImageLoaded extends HomeImageState {
  final HomeImage homeImage;

  const HomeImageLoaded({required this.homeImage});
}
