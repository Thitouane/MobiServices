import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/client/profil/presentation/profil_page.dart';
import 'package:mobideliv/features/commercant/profil/profil_trader_page.dart';import '../../../client/accueil/domain/entity/service_model.dart';


import '../../../commercant/profil/domain/entity/trader_entity.dart';
import '../data/data_sources/auth_repository.dart';

class PasswordTraderPage extends StatefulWidget {
  PasswordTraderPage({required this.trader,required this.service,super.key});
  Trader trader;
  ServiceModel service;

  @override
  PasswordTraderState createState() => PasswordTraderState(this.trader,this.service);
}

class PasswordTraderState extends State<PasswordTraderPage> {
  late Trader trader;
  ServiceModel service;
  late String email = "";
  late String password = "";
  late String confirmpassword = "";
  final _formKey = GlobalKey<FormState>();

  PasswordTraderState(this.trader, this.service);
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      body: Form(
        key: _formKey,
        child:
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Column (
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.2,
                    margin: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      bottom: 30,
                    ),
                    child : Image(image: AssetImage('assets/mobideliv.png')),
                  ),
                  Text(
                    "Authentification",
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
                          "Adresse email ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Adresse email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              email = value;
                            });
                          }
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
                          "Mot de passe ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Mot de passe",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';

                            }else if (value!.length <6){
                              return 'Veuillez entre un mot de passe de 6 caractères minimum';
                            }
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
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
                          "Confirmez votre mot de passe ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Confirmez votre mot de passe",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              confirmpassword = value;
                            });
                          },
                          validator: (value) {
                            if (value == "" ) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            else if (value != password){
                              return "Le mot de passe n'est pas le même que celui au dessus";
                            }
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: showFab? FloatingActionButton.extended(
        label: Text(
          "Valider",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        onPressed:  () {
          signin(context);
        },
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  bool isValidEmail(String string) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(string);
  }

  String? validatePassword(String value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';

    }else if (value.length<6){
      return 'Veuillez entre un mot de passe de 6 caractères minimum';
    }
    else {
      if (!regex.hasMatch(value)) {
        return 'Veuillez entrer un mot de passe valide';
      } else {
        return null;
      }
    }
  }

  void signin(context) async {
    if (_formKey.currentState!.validate()) {
      var id = await FirestoreAuth().authClient(email, password);
      String uid = id ?? "";
      trader.setId(uid);
      trader.setEmail(email);
      trader.setPassword(password);
      trader.setService(uid);
      service.setId(uid);
      await FirestoreAuth().addTrader(trader).then((value) =>
          FirestoreAuth().addService(service));
      AutoRouter.of(context).push(
        HomeCommercantRoute()
      );
    }
  }
}