import 'package:mobideliv/core/domain/entity/service_entity.dart';

class CommercantEntity {
  String id;
  String adresse;
  String? name;
  String username;
  String? info;
  double? rating;
  String? phonenumber;
  String? img; // TODO remove this field and replace it with commercant image
  String? email;
  String? firstname;
  ServiceType? type;
  String? siret;

  CommercantEntity(
      {required this.id,
      required this.adresse,
      required this.img,
      required this.rating,
      required this.username,
      this.name,
      this.info,
      this.phonenumber,
      this.email,
      this.type,
      this.siret,
      this.firstname});

}
