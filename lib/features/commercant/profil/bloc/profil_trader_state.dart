
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';

abstract class ProfilTraderState {}

class ProfilTrader extends ProfilTraderState {}

class ProfilTraderInitial extends ProfilTraderState {}

class ProfilTraderLoading extends ProfilTraderState {}

class ProfilTraderLoaded extends ProfilTraderState {
  final Trader trader;

  ProfilTraderLoaded({required this.trader});

  @override
  List<Object> get props => [trader];
}

class ProfilTraderError extends ProfilTraderState {
  final String message;

  ProfilTraderError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}