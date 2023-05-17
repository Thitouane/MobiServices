import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../authentification/presentation/data/data_sources/auth_repository.dart';

class FirestoreTrader {
  static final _TraderCollection = FirebaseFirestore.instance.collection("commerçant");

  static Future<void> createTrader(Trader trader) async {
    await _TraderCollection
        .doc(trader.id)
        .set(trader.toJson());
  }

  static Stream<List<Trader>> getAllTraders() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
    _TraderCollection.snapshots();
    return snapshots.map((snapshot) {
      List<Trader> TradersInfo = [];
      for (final doc in snapshot.docs) {
        Trader trader = Trader.fromJson(doc.data());
        TradersInfo.add(trader);
      }
      return TradersInfo;
    });
  }

  static Future<Trader> getTrader(String id) async {
    var nom = await FirestoreAuth().getCurrentUserId();
    DocumentSnapshot<Map<String,dynamic>> trader = await _TraderCollection.doc(nom).get();
    if (trader.exists) {
      return Trader.fromJson(trader.data());
    }
    else {
      return Future.error("error");
    }
  }

  static Future<String> updateTrader(String id, Trader traderInfo) async {
    try {
      await _TraderCollection.doc(id).update(traderInfo.toJson());
      return "done";
    }
    catch (e) {
      return Future.error("error");
    }
  }
}