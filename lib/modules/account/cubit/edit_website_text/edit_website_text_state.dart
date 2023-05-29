part of 'edit_website_text_cubit.dart';

abstract class EditWebsiteTextState extends Equatable {
  const EditWebsiteTextState();

  @override
  List<Object> get props => [];
}

class EditWebsiteTextInitial extends EditWebsiteTextState {}

class EditWebsiteTextLoaded extends EditWebsiteTextState {
  const EditWebsiteTextLoaded({required this.data});

  final GetWebsiteTextModel data;
}

class EditWebsiteTextFailure extends EditWebsiteTextState {}

class EditWebsiteTextUpdateLoading extends EditWebsiteTextState {}

class EditWebsiteTextUpdateSuccessful extends EditWebsiteTextState {}
