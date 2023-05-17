import 'package:mobideliv/core/use_case/use_cases.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:mobideliv/features/commercant/profil/domain/repository/trader_repository.dart';

class GetTraderInfoUseCase implements UseCaseTwoParams<Trader, String, bool> {
  final FirestoreTraderRepository addNewTraderRepository;

  GetTraderInfoUseCase(this.addNewTraderRepository);

  @override
  Future<Trader> call(
      {required String paramsOne, required bool paramsTwo}) {
    return addNewTraderRepository.getTrader(paramsOne);
  }
}