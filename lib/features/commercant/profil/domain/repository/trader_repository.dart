
import '../entity/trader_entity.dart';

abstract class FirestoreTraderRepository {
  Future<void> addNewTrader(Trader trader);

  Future<Trader> getTrader(String id);

  Stream<List<Trader>> getAllTraders();

  Future<String> updateTrader(String id, Trader infoTrader);

  Future<void> saveImage();


}