import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_password_trader.dart';
import 'package:mobideliv/features/authentification/presentation/widget/type_service_page.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:phone_number/phone_number.dart';

import '../../../client/accueil/domain/entity/service_model.dart';


class CompanySecondPage extends StatefulWidget {
  Trader trader;
  ServiceModel service;
  CompanySecondPage(this.trader, this.service, {Key? key}) : super(key: key);

  @override
  CompanySecondPageState createState() => CompanySecondPageState(trader:trader, service: service);
}

class CompanySecondPageState extends State<CompanySecondPage> {
  CompanySecondPageState({required this.trader,required this.service});
  late Trader trader;
  ServiceModel service;
  late String content= "";
  late String email = "";
  String tel = "";
  bool isvalid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return buildClient(context);
  }

  Widget buildClient(BuildContext context){
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      body:Form(
        key: _formKey,
        child:ListView(
        children:  [
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
                    "Information sur l'entreprise :",
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
                          "Numéro de téléphone de l'entreprise ",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Numéro de téléphone de l'entreprise",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              tel = value;
                            });
                          },
                          validator: (value) {
                            checkPhoneNumber(context, value!);
                            if ( isvalid) {
                              return 'Numéro de téléphone invalide';
                            }
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
                      "Adresse email de l'entreprise ",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Adresse email de l'entreprise",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value == "") {
                          return 'Veuillez entrer une adresse email valide';
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
                        "Description de l'entreprise ",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            content = value;
                          });
                        },
                      ),
                    ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showFab?FloatingActionButton.extended(
        label: Text(
          "Suivant",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        onPressed:  () {
          continueToServicetype(context);
        },
      ):null,
    );
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

  bool isValidEmail(String string) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(string);
  }

  void continueToServicetype(context){
    if (_formKey.currentState!.validate()) {
      service.setInfo(content);
      service.setPhoneNumber(tel);
      service.setMail(email);
      AutoRouter.of(context).push(
        TypeServiceRoute(
            trader: trader,
            service: service
        )
      );
    }
  }
}
