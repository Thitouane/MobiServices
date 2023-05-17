import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';
import 'package:mobideliv/features/client/accueil/presentation/home_page.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';
import 'package:mobideliv/features/client/profil/presentation/profil_page.dart';

import 'delayed_animation.dart';

class PasswordClientPage extends StatefulWidget {
  late Client client;
  PasswordClientPage({required this.client,super.key});

  @override
  PasswordClientState createState() => PasswordClientState(this.client);
}

class PasswordClientState extends State<PasswordClientPage> {
  Client client;
  late String email;
  late String password;
  late String confirmpassword;
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  PasswordClientState(this.client);
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      body: Form(
        key: _formKey,
        child:
            SingleChildScrollView(
              reverse: true,
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
                    margin: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    child : Image(image: AssetImage('assets/mobideliv.png')),
                  ),
                  Text(
                    "Authentification :",
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
                          }else if (value!.length < 6){
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
    }else if (value.characters.length < 6){
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

  void signin(context) async{
    if (_formKey.currentState!.validate()) {
      var id = await FirestoreAuth().authClient(email, password);
      String uid = id ?? "";
      client.setId(uid);
      client.setEmail(email);
      client.setPassword(password);
      await FirestoreAuth().addClient(client);
      AutoRouter.of(context).push(
        HomePageRoute(
        )
      );
    }
  }
}