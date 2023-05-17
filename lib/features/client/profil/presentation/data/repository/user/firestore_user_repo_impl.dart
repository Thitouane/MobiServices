import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/repository/user_repository.dart';

import '../../data_sources/firestore_user_info.dart';

class FirebaseUserRepoImpl implements FirestoreUserRepository {
  @override
  Future<void> addNewUser(Client user) async {
    try {
      await FirestoreUser.createUser(user);
    }
    catch (e){
      return Future.error(e.toString());
    }
  }


  @override
  Stream<List<Client>> getAllUsers() {
    return FirestoreUser.getAllUsers();
  }

  @override
  Future<Client> getUser(String id) async {
    try {
      Client user = await FirestoreUser.getUser(id);

      return user;
    }catch(e) {
      return Future.error(e.toString());
    }
  }
  @override
  Future<String> updateUser(String id, Client userInfo) async{
    try {
      await FirestoreUser.updateUser(id, userInfo);
      return "done";
    }
    catch(e){
      return Future.error(e.toString());
    }
  }
}