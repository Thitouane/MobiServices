import 'package:mobideliv/core/domain/entity/commercant_entity.dart';
import 'package:mobideliv/core/domain/entity/service_entity.dart';

class CommercantDto {
  String id;
  String adresse;
  String email;
  String firstname;
  String name;
  String username;
  String info;
  String img;
  String type;
  String phonenumber;
  double rating;
  String siret;
  String? service;

  CommercantDto({
    required this.id,
    required this.adresse,
    required this.email,
    required this.firstname,
    required this.name,
    required this.username,
    required this.info,
    required this.img,
    required this.rating,
    required this.type,
    required this.phonenumber,
    required this.siret,
    this.service,
  });

  CommercantEntity toEntity() {
    return CommercantEntity(
      id: id,
      adresse: adresse,
      email: email,
      firstname: firstname,
      name: name,
      username: username,
      info: info,
      img: img,
      rating: rating,
      type: type == 'home' ? ServiceType.home : ServiceType.itinerant,
      phonenumber: phonenumber,
      siret: siret,
    );
  }

  factory CommercantDto.fromJson(String id, Map<String, dynamic> json) {
    return CommercantDto(
      id: id,
      adresse: json['adresse'],
      email: json['email'],
      firstname: json['firstname'],
      name: json['name'],
      username: json['username'],
      info: json['info'],
      img: json['img'],
      rating: json['rating'],
      type: json['type'],
      phonenumber: json['phonenumber'],
      siret: json['siret'],
      service: json['service'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adresse': adresse,
      'email': email,
      'firstname': firstname,
      'name': name,
      'username': username,
      'info': info,
      'img': img,
      'rating': rating,
      'type': type,
      'phonenumber': phonenumber,
      'siret': siret,
    };
  }
}
