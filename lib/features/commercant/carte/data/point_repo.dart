import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';
import 'package:mobideliv/features/client/rdv/data/repo/rdv_repo.dart';
import 'package:mobideliv/features/commercant/carte/domain/entity/point_arret.dart';

class PointRepository {
  final points = FirebaseFirestore.instance.collection("point_arret");
  final commercants = FirebaseFirestore.instance.collection("commerçant");

  Future<List<PointModel>> getMyPoints() async {
    List<PointModel> list = [];
    try {
      var nom = await FirestoreAuth().getCurrentUserId();
      final service = await points
          .where("commercant", isEqualTo: nom)
          .get();

      service.docs.forEach((element) {
        PointModel point = PointModel.fromJson(element.data());
        point.setId = element.id;

        list.add(point);
      });

      return list;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateMyData(PointModel point) async {
    bool newPoint = true;
    try {
      var nom = await FirestoreAuth().getCurrentUserId();
      final p = await points
          .get();

      p.docs.forEach((element) async {
        if (element.id == point.id) {
          await points.doc(element.id).update(point.toJSON());
          newPoint = false;
        }
      });

      if (newPoint) {
        final c = await commercants
            .where("id", isEqualTo: nom)
            .get();

        var commercant = c.docs.first.data();
        point.setCommercant = nom!;
        point.setService = commercant['service'];
        point.setName = commercant['firstname'] + " " + commercant['name'] ?? "";
        await points.add(point.toJSON());
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addData(PointModel point, ServiceModel service) async {
    try {
      var nom = await FirestoreAuth().getCurrentUserId();
      final c = await commercants
          .where("id", isEqualTo: service.id)
          .get();

      var commercant = c.docs.first.data();
      point.setCommercant = service.id!;
      point.setService = commercant['service'];
      point.setName = await RdvRepository().getClientName(nom!);
      await points.add(point.toJSON());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delData(PointModel point) async {
    try {
      final p = await points
          .where('adresse', isEqualTo: point.adresse)
          .where('arrive', isEqualTo: point.arrive)
          .where('commercant', isEqualTo: point.commercant)
          .where('service', isEqualTo: point.service)
        .get();
      p.docs.forEach((element) async {
        await points.doc(element.id).delete();
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<PointModel>> getComPoints(String id) async {
    List<PointModel> list = [];
    try {
      final commercant = await commercants.doc(id).get();


      final service = await points
          .where("commercant", isEqualTo: commercant.data()!['id'])
          .get();

      service.docs.forEach((element) async {
        if (element.id == element.data()['id'] || element.data()['id'] == null) {
          PointModel point = PointModel.fromJson(element.data());
          list.add(point);
        } else {
          await points.doc(element.id).delete();
        }
      });
      return list;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}