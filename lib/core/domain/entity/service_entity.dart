import 'package:mobideliv/core/domain/entity/client_entity.dart';
import 'package:mobideliv/core/domain/entity/commercant_entity.dart';

enum ServiceType { home, itinerant }

class ServiceEntity {
  CommercantEntity? commercant;
  ClientEntity? client;
  String? serviceName;
  ServiceType? serviceType;

  ServiceEntity({
    this.commercant,
    this.client,
    this.serviceType,
    this.serviceName,
  });
}
