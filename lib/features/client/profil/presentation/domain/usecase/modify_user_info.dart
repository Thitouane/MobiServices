
import '../../../../../../core/use_case/use_cases.dart';
import '../entity/client_entity.dart';
import '../repository/user_repository.dart';

class ModifyUserInfoUseCase implements UseCaseTwoParams<String, Client, bool> {
  final FirestoreUserRepository addNewUserRepository;

  ModifyUserInfoUseCase(this.addNewUserRepository);

  @override
  Future<String> call(
      {required Client paramsOne, required bool paramsTwo}) {
    return addNewUserRepository.updateUser(paramsOne.id,paramsOne);
  }
}