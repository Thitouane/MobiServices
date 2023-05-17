import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobideliv/features/client/carte/data/cubit/address/address_cubit.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';

import '../../../../client/accueil/domain/entity/service_model.dart';
import '../../../../client/carte/data/cubit/address/address_cubit.dart';
import '../../../../commercant/profil/domain/entity/trader_entity.dart';

class FirestoreAuth {
  final FirebaseAuth authstore = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _userCollection = FirebaseFirestore.instance.collection("client");
  final _traderCollection = FirebaseFirestore.instance.collection("commerçant");
  final _serviceCollection = FirebaseFirestore.instance.collection("service");

  Future<String> getAnonymousImageUrl() async{
    Reference ref = FirebaseStorage.instance
        .ref('anonyme.png');
    return await ref.getDownloadURL();
  }

  Future<Client?> authAnonymous() async{
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
      String img = await getAnonymousImageUrl();
      if (userCredential!= null){
        String uid = userCredential.user?.uid ?? "";
        Client client = Client(
            id: uid,
            firstname: "",
            name: "",
            email: "",
            img: "",
            password: "",
            addresse: "",
            phonenumber: "",
            favoris: []);
        client.setId(uid);
        client.setImage(img);
        return client;
      }
      return null;

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future<void> signedOut() => FirebaseAuth.instance.signOut();

  Future<String?> authClient(String email,String password) async{
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential!= null){
        String uid = userCredential.user?.uid ?? "";
        return uid;
      }
      return "";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Stream<Trader> authTraderStateChange(Trader trader) {
    return authstore
        .authStateChanges()
        .asyncMap((client) {
      trader;
      return trader;
    }
    );
  }

  Future<Trader> getTrader(String id) async {
    DocumentSnapshot<Map<String,dynamic>> trader = await _traderCollection.doc(id).get();

    return Trader.fromJson(trader.data());
  }

  Stream<Client> authStateChange(Client client){
    Client user = Client(
        id: client.getId(),
        firstname: client.getFirstName(),
        name: client.getName(),
        email: client.getEmail(),
        img: "",
        password: client.getPassword(),
        addresse: client.getAddresse(),
        phonenumber: client.getPhoneNumber(),
        favoris: []);
    return authstore
        .authStateChanges()
        .asyncMap((client) {
      user;
      return user;
    }
    );
  }

  Future<void> addTrader(Trader user) async {
    try {
      await _traderCollection.doc(user.getId()).set(user.toJson());
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> addClient(Client user) async {
    try {
      await _userCollection.doc(user.getId()).set(user.toJson());
    }
    catch (e) {
      print(e);
    }
  }

  Future<void> addService(ServiceModel service) async {
    try {
      List<dynamic> latlng = await AddressCubit().getFromAddress(
          address: service.adresse
      );
      service.setPoint(GeoPoint(latlng.last, latlng.first));
      service.setId(service.id!);

      await _serviceCollection.doc(service.id).set(service.toJson());
    }
    catch (e) {
      print(e);
    }
  }

  Future<String?> getCurrentUserId() async {
    try {
      return authstore.currentUser?.uid;
    }
    catch (e) {
      print(e);
    }
  }

  Stream<Client> get user {
    return authstore
        .authStateChanges()
        .asyncMap((user) {
          Client client = Client(
              id: user!.uid,
              firstname: "",
              name: "",
              email: "",
              img: "",
              password: "",
              addresse: "",
              phonenumber: "",
              favoris: []);
          client.setId(user.uid);
          return client;
        }
      );
    }

  Future<String> authentification(String email,String password) async{
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential!= null){
        String uid = userCredential.user?.uid ?? "";
        return uid;
      }
      return "erreur";
    } on FirebaseAuthException catch (e) {
      return "erreur";
    }
  }

  Future<String> getTypeOfAccount(String id) async{
    try {
      DocumentSnapshot<Map<String,dynamic>> user = await _userCollection.doc(id).get();
      if (user.data() != null){
        return "client";
      }
      else {
        DocumentSnapshot<Map<String,dynamic>> trader = await _traderCollection.doc(id).get();
        if (trader.data() != null){
          return "trader";
        }
        return "error";
      }
    } on Exception catch (e) {
      return "";
    }
  }
}
