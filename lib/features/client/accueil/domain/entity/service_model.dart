import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String adresse;
  String mail;
  bool at_home;
  String name;
  GeoPoint latLng;
  String? img;
  String? ville;
  String? info;
  String? horraire;
  bool? open;
  int? rate;
  String? tel;
  String? type;
  String? id = "";

  ServiceModel({
    required this.adresse,
    required this.mail,
    required this.name,
    this.img,
    required this.at_home,
    this.ville,
    required this.latLng,
    this.info,
    this.horraire,
    this.open,
    this.rate,
    this.tel,
    this.type,
    this.id,
  });

  void setRate(int rate) {
    this.rate = rate;
  }

  void setPoint(GeoPoint point) {
    latLng = point;
  }

  int? getRate() {
    return this.rate;
  }

  void setOpen(bool open) {
    this.open = open;
  }

  bool? getOpen() {
    return this.open;
  }

  void setPhoneNumber(String phone){
    this.tel = phone;
  }

  void setImg(String img){
    this.img = img;
  }

  String? getImg() {
    return this.img;
  }

  String? getPhoneNumber(){
    return this.tel;
  }

  void setName(String name) {
    this.name = name;
  }

  String getName() {
    return this.name;
  }

  void setMail(String mail){
    this.mail = mail;
  }

  String getMail() {
    return this.mail;
  }

  String? getAddresse(){
    return this.adresse;
  }

  void setAddresse(String addresse){
    this.adresse = addresse;
  }
  void setVille(String ville) {
    this.ville = ville;
  }

  String? getVille() {
    return this.ville;
  }

  bool getHome(){
    return this.at_home;
  }

  void setHome(bool at_home){
    this.at_home = at_home;
  }

  String? getInfo(){
    return this.info;
  }

  void setInfo(String info){
    this.info = info;
  }

  String? getHoraire(){
    return this.horraire;
  }

  bool getAtHome(){
    return this.at_home;
  }

  void setAtHome(bool home){
    this.at_home = home;
  }

  void setHoraire(String horaire){
    this.horraire = horaire ;
  }

  String? getType(){
    return this.type;
  }

  void setType(String typeid){
    this.type = typeid;
  }

  String? getId() {
    return this.id;
  }

  void setId(String id) {
    this.id = id;
  }

  factory ServiceModel.fromJson(Map<String, dynamic>? json) {
    return ServiceModel(
      adresse: json?['adresse'],
      mail: json?['mail'],
      name: json?['name'],
      img: json?['img'],
      at_home: json?['at_home'],
      ville: json?['ville'],
      latLng: json?['latlng'],
      info: json?['info'],
      horraire: json?['horraire'],
      open: json?['open'],
      rate: json?['rate'],
      tel: json?['tel'],
      type: json?['type'],
      id: json?['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["adresse"] = adresse;
    data['mail'] = mail;
    data['name'] = name;
    data['img'] = img;
    data["at_home"] = at_home;
    data["ville"] = ville;
    data["latlng"] = latLng;
    data["info"] = info;
    data["horraire"] = horraire;
    data["open"] = open;
    data["rate"] = rate;
    data["tel"] = tel;
    data["type"] = type;
    data["id"] = id;
    return data;
  }
}
