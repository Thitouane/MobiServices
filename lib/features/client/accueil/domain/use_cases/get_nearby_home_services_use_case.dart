import 'package:mobideliv/core/use_case/use_cases.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/home_service_entity.dart';

import 'package:mobideliv/features/client/accueil/domain/repositories/home_services_repository.dart';

class GetHomeServicesUseCase
    extends UseCaseOneParam<List<HomeServiceEntity>, String> {
  final HomeServicesRepository _getNearbyHomeServices;

  GetHomeServicesUseCase(this._getNearbyHomeServices);
  @override
  Future<List<HomeServiceEntity>> call(String serviceName) async {
    return await _getNearbyHomeServices.getHomeServicesByServiceName(serviceName);
  }
}
