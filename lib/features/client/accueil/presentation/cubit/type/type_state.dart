part of 'type_bloc.dart';

abstract class TypeState {
  const TypeState();
}

class TypeInitial extends TypeState {}

class TypeError extends TypeState {
  final String error;

  TypeError(this.error);
  @override
  List<Object> get props => [error];
}

class TypeLoading extends TypeState {
  @override
  List<Object?> get props => [];
}

class TypeLoaded extends TypeState {
  List<TypeModel> type;
  TypeLoaded(this.type);

  @override
  List<Object?> get props => [];
}