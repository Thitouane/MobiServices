import 'package:cloud_firestore/cloud_firestore.dart';

class PointModel {
  String adresse;
  String arret;
  String arrive;
  String commercant;
  late GeoPoint point;
  String? info;
  String? service;
  String? name;
  String? id;

  PointModel({
    required this.adresse,
    required this.arret,
    required this.arrive,
    required this.commercant,
    required this.point,
    this.info,
    required this.service,
    this.name,
    this.id
  });

  set setCommercant(String i) {
    commercant = i;
  }

  set setName(String i) {
    name = i;
  }

  set setAdresse(String i) {
    adresse = i;
  }

  set setArrive(String i) {
    arrive = i;
  }

  set setArret(String i) {
    arret = i;
  }

  set setInfo(String i) {
    info = i;
  }

  set setId(String i) {
    id = i;
  }

  set setService(String i) {
    service = i;
  }

  set setPoint(GeoPoint g) {
    point = g;
  }

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      adresse: json['adresse'],
      arret: json['arret'],
      arrive: json['arrive'],
      commercant: json['commercant'],
      point: json['point'],
      info: json['info'],
      name: json['name'],
      service: json['service']
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'adresse': adresse,
      'arret': arret,
      'arrive': arrive,
      'commercant': commercant,
      'point': point,
      'info': info,
      'service': service,
      'name': name,
      'id': id
    };
  }
}