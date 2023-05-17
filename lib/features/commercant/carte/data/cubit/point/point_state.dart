
import '../../../domain/entity/point_arret.dart';

abstract class PointState {
  const PointState();
}

class PointInitial extends PointState {}

class PointError extends PointState {
  final String error;

  PointError(this.error);
  @override
  List<Object> get props => [error];
}

class PointLoading extends PointState {
  @override
  List<Object?> get props => [];
}

class PointLoaded extends PointState {
  List<PointModel> point;
  PointLoaded(this.point);

  @override
  List<Object?> get props => [];
}