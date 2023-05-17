import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobideliv/core/data/dto/commercant_dto.dart';
import 'package:mobideliv/core/domain/entity/commercant_horaires_entity.dart';

class FireStoreCommercant {
  static final _commercantCollection =
      FirebaseFirestore.instance.collection("commerçant");

  Future<List<CommercantDto>> getAllCommercants() async {
    return await _commercantCollection.doc("commercan1").get().then((value) {
      return [CommercantDto.fromJson("commercan1", value.data()!)];
    });
  }

  Future<List<CommercantDto>> getAllCommercantsByService(String serviceName) {
    return _commercantCollection
        .where("service", isEqualTo: serviceName.toLowerCase())
        .get()
        .then((value) {
      return value.docs
          .map((doc) => CommercantDto.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  Future<List<CommercantCreneauxEntity>> getCommercantHoraires(
      String commercantId) async {
    return await _commercantCollection
        .doc(commercantId)
        .collection("creneaux")
        .get()
        .then((result) {
      return result.docs
          .map((doc) => CommercantCreneauxEntity.fromJson(doc.id, doc.data()))
          .toList();
    });
  }
}
