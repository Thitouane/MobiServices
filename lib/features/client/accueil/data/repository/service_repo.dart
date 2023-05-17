import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';

import '../../domain/entity/service_model.dart';

class ServiceRepository {
  final _fireCloud = FirebaseFirestore.instance.collection("service");

  Future<List<ServiceModel>> getAll() async {
    List<ServiceModel> serList = [];
    try {
      final service = await _fireCloud.get();

      service.docs.forEach((element) {
        serList.add(ServiceModel.fromJson(element.data()));
      });
      return serList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return serList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ServiceModel>> getAmbulant() async {
    List<ServiceModel> serList = [];
    try {
      final service = await _fireCloud
          .where('at_home', isEqualTo: false)
          .get();

      service.docs.forEach((element) {
        return serList.add(ServiceModel.fromJson(element.data()));
      });

      return serList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return serList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ServiceModel> getService(String id) async{
    final DocumentSnapshot<Map<String,dynamic>> service = await _fireCloud.doc(id).get();
    if (service.exists) {
      return ServiceModel.fromJson(service.data());
    }
    else {
      return Future.error("error");
    }
  }

  Future<List<ServiceModel>> getComService() async{
    List<ServiceModel> list = [];
    String id = (await FirestoreAuth().getCurrentUserId())!;
    final DocumentSnapshot<Map<String,dynamic>> service = await _fireCloud.doc(id).get();
    if (service.exists) {
      list.add(ServiceModel.fromJson(service.data()));
      return list;
    } else {
      return Future.error("error");
    }
  }

  Future<String> updateService(String id, ServiceModel serviceInfo) async {
    try {
      await _fireCloud.doc(id).update(serviceInfo.toJson());
      return "done";
    }
    catch (e) {
      return Future.error("error");
    }
  }

  Future<List<ServiceModel>> getAtHome() async {
    List<ServiceModel> serList = [];
    try {
      final service = await _fireCloud
          .where('at_home', isEqualTo: true)
          .get();

      service.docs.forEach((element) {
        return serList.add(ServiceModel.fromJson(element.data()));
      });

      return serList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error '${e.code}': ${e.message}");
      }
      return serList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}