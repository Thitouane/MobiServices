import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';

import '../../../../../authentification/presentation/data/data_sources/auth_repository.dart';

class FirestoreUser {
  static final _userCollection = FirebaseFirestore.instance.collection("client");
  static final _traderCollection = FirebaseFirestore.instance.collection("commerçant");

  static Future<void> createUser(Client user) async {
    await _userCollection
        .doc(user.id)
        .set(user.toJson());
  }

  static Stream<List<Client>> getAllUsers() {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
    _userCollection.snapshots();
    return snapshots.map((snapshot) {
      List<Client> usersInfo = [];
      for (final doc in snapshot.docs) {
        Client user = Client.fromJson(doc.data());
        usersInfo.add(user);
      }
      return usersInfo;
    });
  }

  static Future<Client> getUser(String id) async {
    var nom = await FirestoreAuth().getCurrentUserId();
    DocumentSnapshot<Map<String,dynamic>> user = await _userCollection.doc(nom).get();
    if (user.exists) {
      return Client.fromJson(user.data());
    }
    else {
      return Future.error("error");
    }
  }

  static Future<Client> getTrader(String id) async {
    var nom = await FirestoreAuth().getCurrentUserId();
    DocumentSnapshot<Map<String,dynamic>> user = await _traderCollection.doc(nom).get();
    if (user.exists) {
      return Client.fromJson(user.data());
    }
    else {
      return Future.error("error");
    }
  }

  static Future<String> updateUser(String id, Client userInfo) async {
    try {
      await _userCollection.doc(id).update(userInfo.toJson());
      return "done";
    }
    catch (e) {
      return Future.error("error");
    }

  }
}