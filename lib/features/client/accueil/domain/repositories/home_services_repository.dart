import 'package:mobideliv/features/client/accueil/domain/entity/home_service_entity.dart';

abstract class HomeServicesRepository {
  Future<List<HomeServiceEntity>> getHomeServicesByServiceName(String serviceName);
}
