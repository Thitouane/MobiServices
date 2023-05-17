part of 'home_services_cubit.dart';

abstract class HomeServicesState {}

class HomeServicesInitial extends HomeServicesState {}

class HomeServicesLoading extends HomeServicesState {}

class HomeServicesLoaded extends HomeServicesState {
  final List<HomeServiceEntity> homeServices;

  HomeServicesLoaded({required this.homeServices});
}

class HomeServicesError extends HomeServicesState {
  final String message;

  HomeServicesError({required this.message});
}
