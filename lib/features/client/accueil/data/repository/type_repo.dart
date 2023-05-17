import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/type_model.dart';

class TypeRepository {
  final _type = FirebaseFirestore.instance.collection("type");
  final _service = FirebaseFirestore.instance.collection("service");

  Future<List<TypeModel>> getAll() async {
    List<TypeModel> typeList = [];
    final type = await _type.get();
    for (var typeElement in type.docs) {
      TypeModel typeModel = TypeModel(
          service: typeElement["service"],
      );
      typeList.add(typeModel);
    }
    return typeList;
  }

  Future<void> addtype(TypeModel type) async{
    var ref = await _type
        .doc(type.service)
        .set(type.toJson());
  }

  Future<void> modifyType(TypeModel type) async{

  }

  Future<List<TypeModel>> getAtHome() async {
    List<TypeModel> typeList = [];
    try {
      final service = await _service
          .where('at_home', isEqualTo: true)
          .get();

      final type = await _type
          .get();

      for (var typeElement in type.docs) {
        TypeModel typeModel = TypeModel(
            service: typeElement["service"],
        );
        typeList.add(typeModel);
      }

      return typeList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return typeList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
