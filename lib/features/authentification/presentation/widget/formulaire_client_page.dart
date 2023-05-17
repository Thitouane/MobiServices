import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_company.dart';
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_password_client.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:phone_number/phone_number.dart';

import '../data/data_sources/auth_repository.dart';


class LoginPage extends StatefulWidget {
  String type = "";
  LoginPage(this.type, {Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState(type:type);
}

class LoginPageState extends State<LoginPage> {
  LoginPageState({required this.type});
  late String type;
  late String nom ="";
  late String firstname ="";
  late String tel = "";
  late String addresse = "";
  late String siret = "";
  bool isvalid = false;

  final _formKey = GlobalKey<FormState>();
  final _formKeyTrader = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (type == "client"){
      return buildClient(context);
    }
    else {
      return buildCommercant(context);
    }
  }

  Widget buildClient(BuildContext context){
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body :
          Form (
            key: _formKey,
            child:
            Column (
              children: [
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  child : Image(image: AssetImage('assets/mobideliv.png')),
                ),
                Text(
                  "Information Client",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                Container (
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nom ",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: "Nom",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == "" ) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                          onChanged: (String value) {
                            setState(() {
                              nom = value;
                            });
                          }
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prénom ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                            decoration: InputDecoration(
                          hintText: "Prénom",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" ) {
                            return 'Veuillez entrer votre prénom';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            firstname = value;
                          });
                        }
                      ),
                    ],
                    ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                    "Numéro de téléphone ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "N° de Tel",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        checkPhoneNumber(context, value!);
                        if ( isvalid) {
                          return 'Numéro de téléphone invalide';
                        }
                        else if (value == ""){
                          return "Veuillez entrez un numéro de téléphone";
                        }
                        return null;

                      },
                      onChanged: (String value) {
                        setState(() {
                          tel = value;
                        });
                      }
                    ),
                  ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      "Adresse ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Adresse",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == "" ) {
                            return 'Veuillez entrer une adresse';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            addresse = value;
                          });
                        }
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
      floatingActionButton: showFab?FloatingActionButton.extended(
        label: Text(
          "Suivant",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        onPressed:  () {
          sendClientPasswordForm(context);
        },
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildCommercant(BuildContext context){
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      body: Form(
        key: _formKeyTrader,
        child: SingleChildScrollView (
          reverse: true,
          child:
            Column (
              children: [
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.height * 0.2,
                  margin: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 30,
                  ),
                  child : Image(image: AssetImage('assets/mobideliv.png')),
                ),
                Text(
                  "S'inscrire",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                Container (
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                      "Nom ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nom",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            nom = value;
                          });
                        },
                        validator: (value) {
                          if (value == "" ) {
                            return 'Veuillez rentrer votre prénom';
                          }
                            return null;
                          },
                      ),
                    ],
                  ),
                ),
                Container (
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        "Prénom ",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Prénom",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            firstname = value;
                          });
                        },
                        validator: (value) {
                          if (value == "" ) {
                            return 'Veuillez entrer votre prénom';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container (
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      "Numéro de téléphone",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                      TextFormField(
                      decoration: InputDecoration(
                        hintText: "N° de téléphone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          tel = value;
                        });
                      },
                      validator: (value) {
                        checkPhoneNumber(context, value!);
                        if (isvalid ) {
                          return 'Numéro de téléphone invalide';
                        }
                        else if (value==""){
                          return "Veuillez entrer un numéro de téléphone";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
                Container (
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                      "Siret ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                      TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "SIRET",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              siret = value;
                            });
                          },
                        validator: (value) {
                          if (value == "" ) {
                            return 'Veuillez rentrer un numéro de SIRET';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Container (
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                          "Informtion supplémentaire ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Information Supplémentaires",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              addresse = value;
                            });
                          },
                          validator: (value) {
                            if (value == "" ) {
                              return "Nécéssite des informations";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: showFab?FloatingActionButton.extended(
        label: Text(
          "Suivant",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        onPressed:  () {
          sendTraderPasswordForm(context);
        },
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void sendClientPasswordForm(context) async{
    if (_formKey.currentState!.validate()) {
      Client user = Client(id: '', firstname: '', name: '', email: '', img: '', password: '', addresse: '', phonenumber: '', favoris: []);
      String uri = await FirestoreAuth().getAnonymousImageUrl();
      user.setName(nom);
      user.setFirstName(firstname);
      user.setPhoneNumber(tel);
      user.setAddresse(addresse);
      user.setImage(uri);
      AutoRouter.of(context).push(
        PasswordClientRoute(
            client: user
        )
      );
    }
  }

  Future<bool?> checkPhoneNumber(context,String tel) async{
    try {
      PhoneNumber phoneNumber = await PhoneNumberUtil().parse(tel);

      bool isValid = await PhoneNumberUtil().validate(tel);
      setState(() {
        isvalid = isValid;
      });
      if (isValid) {
        return isValid;
      }
      return false;
    }catch(e){
      return null;
    }
  }

  void sendTraderPasswordForm(context) async{
    if (_formKeyTrader.currentState!.validate()) {
      Trader trader = Trader(id: "",
          firstname: "",
          name: "",
          img: "",
          password: "",
          phonenumber: "",
          email: '',
          service: '',
          siret: '',
          type: '',
          info: '');
      String uri = await FirestoreAuth().getAnonymousImageUrl();
      trader.setName(nom);
      trader.setFirstName(firstname);
      trader.setPhoneNumber(tel);
      trader.setSiret(siret);
      trader.setInfo(addresse);
      trader.setImage(uri);
      AutoRouter.of(context).push(
        CompanyRoute(
            trader: trader
        )
      );
    }
  }
}
