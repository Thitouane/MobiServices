
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';

import '../../../../../../core/use_case/use_cases.dart';
import '../entity/client_entity.dart';
import '../repository/user_repository.dart';

class GetUserInfoUseCase implements UseCaseTwoParams<Client, String, bool> {
  final FirestoreUserRepository addNewUserRepository;

  GetUserInfoUseCase(this.addNewUserRepository);

  @override
  Future<Client> call(
      {required String paramsOne, required bool paramsTwo}) async {
    return addNewUserRepository.getUser(paramsOne);
  }
}