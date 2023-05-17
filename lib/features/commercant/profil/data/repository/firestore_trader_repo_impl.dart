

import 'package:mobideliv/features/commercant/profil/data/data_sources/firestore_trader_info.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:mobideliv/features/commercant/profil/domain/repository/trader_repository.dart';

class FirebaseTraderRepoImpl implements FirestoreTraderRepository {
  @override
  Future<void> addNewTrader(Trader trader) async {
    try {
      await FirestoreTrader.createTrader(trader);
    }
    catch (e){
      return Future.error(e.toString());
    }
  }


  @override
  Stream<List<Trader>> getAllTraders() {
    return FirestoreTrader.getAllTraders();
  }

  @override
  Future<Trader> getTrader(String id) async {
    try {
      Trader trader = await FirestoreTrader.getTrader(id);
      return trader;
    }catch(e) {
      return Future.error(e.toString());
    }
  }
  @override
  Future<String> updateTrader(String id, Trader traderinfo) async{
    try {
      await FirestoreTrader.updateTrader(id, traderinfo);
      return "done";
    }
    catch(e){
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> saveImage() {
    // TODO: implement saveImage
    throw UnimplementedError();
  }
}