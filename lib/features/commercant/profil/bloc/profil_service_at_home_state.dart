
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';

abstract class ProfilServiceState {}

class ProfilService extends ProfilServiceState {}

class ProfilServiceInitial extends ProfilServiceState {}

class ProfilServiceLoading extends ProfilServiceState {}

class ProfilServiceLoaded extends ProfilServiceState {
  final ServiceModel service;

  ProfilServiceLoaded({required this.service});

  @override
  List<Object> get props => [service];
}

class ProfilServiceError extends ProfilServiceState {
  final String message;

  ProfilServiceError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}