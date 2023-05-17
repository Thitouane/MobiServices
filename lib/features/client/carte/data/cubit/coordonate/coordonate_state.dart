part of 'coordonate_cubit.dart';

abstract class CoordonateState {
  const CoordonateState();
}

class CoordonateError extends CoordonateState {
  final String error;

  CoordonateError(this.error);
  @override
  List<Object> get props => [error];
}

class CoordonateInitial extends CoordonateState {}

class CoordonateLoading extends CoordonateState {}

class CoordonateLoaded extends CoordonateState {
  const CoordonateLoaded(this.content);

  final String content;
}
