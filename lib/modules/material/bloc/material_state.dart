part of 'material_cubit.dart';

abstract class MaterialPageState extends Equatable {
  const MaterialPageState();
}

class MaterialInitial extends MaterialPageState {
  @override
  List<Object> get props => [];
}

class MaterialLoading extends MaterialPageState {
  @override
  List<Object> get props => [];
}

class MaterialSuccess extends MaterialPageState {

  GetAllMaterials? model;
  MaterialSuccess(this.model);

  @override
  List<Object> get props => [];
}

class MaterialFailure extends MaterialPageState {



  @override
  List<Object> get props => [];
}

class MaterialSearchLoading extends MaterialPageState {
  @override
  List<Object> get props => [];
}

class MaterialSearchSuccess extends MaterialPageState {

  GetAllMaterials? model;
  MaterialSearchSuccess(this.model);

  @override
  List<Object> get props => [];
}

class MaterialSearchEmpty extends MaterialPageState {



  @override
  List<Object> get props => [];
}
