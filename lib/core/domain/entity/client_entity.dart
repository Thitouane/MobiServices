class ClientEntity {
  String id;
  String adresse;
  String userName;
  String? firstName;
  String? name;
  String phonenumber;
  String img;
  String? email;

  ClientEntity({
    required this.id,
    required this.adresse,
    required this.userName,
    required this.phonenumber,
    required this.img,
    this.firstName,
    this.name,
    this.email,
  });
}
