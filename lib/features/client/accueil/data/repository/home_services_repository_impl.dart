import 'package:mobideliv/core/data/data_sources/firestore_commercant.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/home_service_entity.dart';
import 'package:mobideliv/features/client/accueil/domain/repositories/home_services_repository.dart';

class HomeServicesRepositoryImpl extends HomeServicesRepository {
  static final FireStoreCommercant _fireStoreCommercant = FireStoreCommercant();
  @override
  Future<List<HomeServiceEntity>> getHomeServicesByServiceName(String serviceName) {
    return _fireStoreCommercant.getAllCommercantsByService(serviceName).then((commercants) {
      return commercants.map((commercant) {
        HomeServiceEntity serviceEntity = HomeServiceEntity.fromDto(commercant);
        serviceEntity.distance = 1.5; // TODO : get distance from user location
        serviceEntity.rating = 4.5;

        return serviceEntity;
      }).toList();
    }).catchError((e) {
      print("Error $e");
    });
  }
}


// TODO: this is only an example, replace with real data
// ServiceEntity coiffHelle = ServiceEntity(
//   id : "3mYgQXbvw7aHHj0IvQXN",
//   serviceType: ServiceType.home,
//   name: "Coiffure Helle",
//   imageUrl: "images/coiffHelle.png",
//   informationComplementaires: "Coiffure à domicile",
//   adresse: "15, rue normale Lille 59800",
//   rating: 4.5,
//   distance: 1.5,
//   contact: ContactEntity(
//     email: "coiffHelle@example.fr",
//     phoneNumber: "0606060606",
//   ),
// );

// ServiceEntity tiffelle = ServiceEntity(
//   id : "3mYgQXbvw7aHHj0IvQXN",
//   serviceType: ServiceType.home,
//   name: "Tiffelle",
//   imageUrl: "images/tiffelle.png",
//   informationComplementaires: "Coiffure à domicile",
//   adresse: "23, rue de Lille,  Lille 59800",
//   rating: 4.0,
//   distance: 0.5,
//   contact: ContactEntity(
//     email: "tiffelle@example.fr",
//     phoneNumber: "0606060606",
//   ),
// );

// ServiceEntity coiffFeur = ServiceEntity(

//   name: "Coiff Feur",
//   imageUrl: "images/coiff_feur.png",
//   informationComplementaires: "Coiffure à domicile",
//   adresse: "24, rue de la rue,  Lille 59800",
//   rating: 4.1,
//   distance: 0.75,
//   contact: ContactEntity(
//     email: "coifffeur@example.fr",
//     phoneNumber: "0606060606",
//   ),
// );

// return Future.value([coiffHelle, tiffelle, coiffFeur]);