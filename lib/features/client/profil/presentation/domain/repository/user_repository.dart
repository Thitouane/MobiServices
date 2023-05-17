
import '../entity/client_entity.dart';

abstract class FirestoreUserRepository {
  Future<void> addNewUser(Client user);

  Future<Client> getUser(String id);

  Stream<List<Client>> getAllUsers();

  Future<String> updateUser(String id, Client infoUser);
}