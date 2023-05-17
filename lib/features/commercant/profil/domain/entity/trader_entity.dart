class Trader{
  String id = "";
  String firstname = "";
  String name = "";
  String email = "";
  String img = "";
  String password = "";
  String phonenumber = "";
  String service = "";
  String siret = "";
  String type = "";
  String info = "";

  Trader({
    required String id,
    required String firstname,
    required String name,
    required String email,
    required String img,
    required String password,
    required String phonenumber,
    required String service,
    required String siret,
    required String type,
    required String info,
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

  String getSiret(){
    return this.siret;
  }

  void setSiret(String siret) {
    this.siret= siret;
  }

  String getPhoneNumber() {
    return this.phonenumber;
  }

  void setPhoneNumber(String phonenumber){
    this.phonenumber = phonenumber;
  }

  String getService() {
    return this.service;
  }

  void setService(String service) {
    this.service = service;
  }

  String getType() {
    return this.type;
  }

  void setType(String type) {
    this.type = type;
  }

  String getInfo() {
    return this.info;
  }

  void setInfo(String info) {
    this.info = info;
  }

  Trader.fromJson(Map<String, dynamic>? json) {
    id = json?["id"] ?? "";
    firstname = json?["firstname"];
    name = json?['name'];
    email = json?["email"];
    phonenumber = json?["phonenumber"];
    password = json?["password"];
    img = json?["img"];
    service = json?["service"];
    siret = json?["siret"];
    /*type = json?["type"];*/
    info = json?["info"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data['name'] = name;
    data['firstname'] = firstname;
    data["email"] = email;
    data["phonenumber"] = phonenumber;
    data["password"] = password;
    data["img"] = img;
    data["siret"] = siret;
    data["service"] = service;
    data["type"] = type;
    data["info"] = info;
    return data;
  }
}