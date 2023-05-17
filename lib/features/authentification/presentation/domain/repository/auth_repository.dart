import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';

import '../../../../commercant/profil/domain/entity/trader_entity.dart';

abstract class FirestoreAuthUserRepository {
  Future<void> addNewClient(Client user);

  Future<Client?> auth();

  Future<String?> getCurrentUserId();

  Future<void> addNewTrader(Trader trader);

  Future<Client> getClient(String identifiant);

  Future<Trader> getTrader(String identifiant);

  Stream<List<Client>> getAllUsers();

  Stream<List<Trader>> getAllTrader();
}