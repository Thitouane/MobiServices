import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobideliv/core/domain/entity/client_entity.dart';
import 'package:mobideliv/core/domain/entity/commercant_entity.dart';
import 'package:mobideliv/core/domain/entity/service_entity.dart';
import 'package:mobideliv/core/domain/entity/rdv_status.dart';


class RdvEntity extends ServiceEntity {
  String? rdvId;
  Timestamp? date;
  int? duration;
  RdvStatus status;
  String? description;
  String adresseRdv;
  String? clientId;

  RdvEntity({
    CommercantEntity? commercant,
    ClientEntity? client,
    required this.adresseRdv,
    ServiceType? serviceType,
    this.date,
    this.rdvId,
    this.duration,
    this.description,
    this.status = RdvStatus.waiting,
    String? serviceName,
    this.clientId,
  }) : super(
            commercant: commercant,
            client: client,
            serviceName: serviceName,
            serviceType: serviceType);

  factory RdvEntity.fromService(ServiceEntity entity) {
    return RdvEntity(
      commercant: entity.commercant,
      serviceType: entity.serviceType,
      serviceName: entity.serviceName,
      adresseRdv: entity.commercant!.adresse,
    );
  }
}
