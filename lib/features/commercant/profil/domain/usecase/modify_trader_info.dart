
import 'package:mobideliv/core/use_case/use_cases.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:mobideliv/features/commercant/profil/domain/repository/trader_repository.dart';

class ModifyTraderInfoUseCase implements UseCaseTwoParams<String, Trader, bool> {
  final FirestoreTraderRepository addNewTraderRepository;

  ModifyTraderInfoUseCase(this.addNewTraderRepository);

  @override
  Future<String> call(
      {required Trader paramsOne, required bool paramsTwo}) {
    return addNewTraderRepository.updateTrader(paramsOne.id,paramsOne);
  }
}