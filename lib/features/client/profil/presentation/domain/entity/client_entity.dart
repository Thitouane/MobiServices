class Client{
  String id = "";
  String firstname = "";
  String name = "";
  String email = "";
  String img = "";
  String password = "";
  String addresse = "";
  String phonenumber = "";
  List<dynamic> favoris = [];

  Client({
    required String id,
    required String firstname,
    required String name,
    required String email,
    required String img,
    required String password,
    required String addresse,
    required String phonenumber,
    required List<dynamic> favoris,
  }) ;

  String getId(){
    return this.id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getFirstName() {
    return this.firstname;
  }

  void setFirstName(String firstname) {
    this.firstname = firstname;
  }

  String getEmail(){
    return this.email;
  }

  void setEmail(String email){
    this.email = email;
  }

  String getImage(){
    return this.img;
  }

  void setImage(String img){
    this.img = img;
  }

  String getPassword(){
    return this.password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getAddresse(){
    return this.addresse;
  }

  void setAddresse(String addresse) {
    this.addresse= addresse;
  }

  String getPhoneNumber() {
    return this.phonenumber;
  }

  void setPhoneNumber(String phonenumber){
    this.phonenumber = phonenumber;
  }

  List<dynamic> getFavoris() {
    return this.favoris;
  }

  void setFavoris(List<dynamic> favoris){
    this.favoris = favoris;
  }

  Client.fromJson(Map<String, dynamic>? json) {
    id = json?["id"] ?? "";
    firstname = json?["firstname"];
    name = json?['name'];
    email = json?["email"];
    phonenumber = json?["phonenumber"];
    addresse = json?["addresse"];
    password = json?["password"];
    img = json?["img"];
    favoris = json?["favoris"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    data["addresse"] = addresse;
    data["email"] = email;
    data["phonenumber"] = phonenumber;
    data["password"] = password;
    data["img"] = img;
    data["favoris"] = favoris;
    return data;
  }
}