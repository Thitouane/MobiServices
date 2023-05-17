
import '../domain/entity/client_entity.dart';

abstract class ProfilUserState {}

class ProfilUser extends ProfilUserState {}

class ProfilUserInitial extends ProfilUserState {}

class ProfilUserLoading extends ProfilUserState {}

class ProfilUserLoaded extends ProfilUserState {
  final Client user;

  ProfilUserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfilUserError extends ProfilUserState {
  final String message;

  ProfilUserError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}