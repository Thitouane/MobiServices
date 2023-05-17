import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';
import 'package:mobideliv/features/client/carte/data/cubit/address/address_cubit.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';

import '../data/data_sources/auth_repository.dart';
import 'formulaire_company_page_2.dart';


class CompanyPage extends StatefulWidget {
  Trader trader;
  CompanyPage(this.trader, {Key? key}) : super(key: key);

  @override
  CompanyPageState createState() => CompanyPageState(trader:trader);
}

class CompanyPageState extends State<CompanyPage> {
  CompanyPageState({required this.trader});
  late Trader trader;
  String nom = "";
  String ville = "";
  bool at_home = true;
  String adresse = "";
  GeoPoint point = const GeoPoint(50, 50);
  int _value =  0;
  bool isvalid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return buildClient(context);
  }

  Widget buildClient(BuildContext context){
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    margin: EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 30,
                    ),
                    child : Image(image: AssetImage('assets/mobideliv.png')),
                  ),
                  Text(
                    "Informations sur l'entreprise",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Type de Commerce :",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        ListTile(
                          title: const Text('A domicile'),
                          leading: Radio(
                            value: 0,
                            groupValue: _value,
                            activeColor: Color(0xFF6200EE),
                            onChanged: (value) {
                              setState(() {
                                _value = 0;
                                at_home = true;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Itinérant'),
                          leading: Radio(
                            value: 1,
                            groupValue: _value,
                            activeColor: Color(0xFF6200EE),
                            onChanged: (value) {
                              setState(() {
                                _value = 1;
                                at_home = false;
                              });
                            },
                          ),
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
                        "Nom de l'entreprise ",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Nom de l'entreprise",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            nom = value;
                          });
                        },
                        validator: (value) {
                          if (value == "" ) {
                            return "Veuillez entrer le nom de l'entreprise";
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
                        "Ville de l'entreprise ",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ville de l'entreprise",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            ville = value;
                          });
                        },
                        validator: (value) {
                          if (value == "" ) {
                            return "Veuillez entrer la ville où se situe l'entreprise";
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
                        "Adresse de l'entreprise ",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Adresse de l'entreprise",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            adresse = value;
                          });
                        },
                        onSaved: (value) async {
                          List<dynamic> latlng = await context.read<AddressCubit>().getFromAddress(
                              address: adresse
                          );
                          setState(() {
                            point = GeoPoint(latlng.last, latlng.first);
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
      ),
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
          buildNextTrader(context);
        },
      ):null,
    );
  }

  void buildNextTrader(context)async {
    if (_formKey.currentState!.validate()) {
      ServiceModel service = ServiceModel(
          adresse: this.ville,
          mail: "",
          name: this.nom,
          at_home: this.at_home,
          latLng: point,
          info: "",
          type:""
      );
      String uri = await FirestoreAuth().getAnonymousImageUrl();

      service.setVille(ville);
      service.setAddresse(adresse);
      service.setImg("assets/anonyme.png");
      service.setOpen(true);
      service.setAtHome(at_home);
      service.setRate(25);
      service.setPoint(point);
      service.setHoraire("");

      AutoRouter.of(context).pop();
      AutoRouter.of(context).push(
        CompanySecondRoute(
            trader: trader,
            service: service
        )
      );
    }
  }
}
