
import '../../../../accueil/domain/entity/service_model.dart';

abstract class ServiceState {
  const ServiceState();
}

class ServiceInitial extends ServiceState {}

class ServiceError extends ServiceState {
  final String error;
  ServiceError(this.error);
  @override
  List<Object> get props => [error];
}

class ServiceLoading extends ServiceState {
  @override
  List<Object?> get props => [];
}

class ServiceLoaded extends ServiceState {
  List<ServiceModel> mydata;
  ServiceLoaded(this.mydata);
  @override
  List<Object?> get props => [];
}