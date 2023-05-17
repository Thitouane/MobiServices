import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';

import '../../../../commercant/profil/domain/entity/trader_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_repository.dart';



class AuthRepoImpl implements FirestoreAuthUserRepository {
  final firestoreauth =  FirestoreAuth();

  @override
  Future<void> addNewClient(Client user) async {
    try {
      await firestoreauth.addClient(user);
    }
    catch (e){
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> addNewTrader(Trader trader) {
    // TODO: implement addNewTrader
    throw UnimplementedError();
  }

  @override
  Future<Client?> auth() async {
    try {
      await firestoreauth.authAnonymous();
    }
    catch (e){
      return Future.error(e.toString());
    }
  }

  @override
  Future<String?> getCurrentUserId() async {
    try {
      await firestoreauth.getCurrentUserId();
    }
    catch (e){
      return Future.error(e.toString());
    }
  }

  @override
  Stream<List<Trader>> getAllTrader() {
    // TODO: implement getAllTrader
    throw UnimplementedError();
  }

  @override
  Stream<List<Client>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<Client> getClient(String identifiant) async {
    // TODO: implement getTrader
    throw UnimplementedError();
  }

  @override
  Future<Trader> getTrader(String identifiant) {
    // TODO: implement getTrader
    throw UnimplementedError();
  }

}