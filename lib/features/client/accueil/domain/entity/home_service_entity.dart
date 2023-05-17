import 'package:mobideliv/core/data/dto/commercant_dto.dart';
import 'package:mobideliv/core/domain/entity/commercant_entity.dart';
import 'package:mobideliv/core/domain/entity/service_entity.dart';

class HomeServiceEntity extends ServiceEntity {
  double? distance;
  double? rating;
  String? service;
  
  HomeServiceEntity({
    required CommercantEntity commercant,
    String? service,
    this.distance,
    this.rating,
    ServiceType serviceType = ServiceType.home,
  }) : super(commercant: commercant, serviceType: serviceType);

  factory HomeServiceEntity.fromDto(CommercantDto commercant) {
    return HomeServiceEntity(
      commercant: commercant.toEntity(),
      service: commercant.service,
    );
  }
}
