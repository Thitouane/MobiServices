import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/commercant/navbar.dart';
import 'package:mobideliv/core/presentation/commercant/app_bar_commercant.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AideCommercantPage extends StatefulWidget {
  AideCommercantPage({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<AideCommercantPage> createState() => _AidePageState();
}

class _AidePageState extends State<AideCommercantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      drawer: NavBar(),
      appBar: CustomAppBar(scaffoldKey: widget._scaffoldKey),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(Icons.help_outline_outlined,
                  size: 100, color: Palette.orangePrimary),
              SizedBox(height: 30),
              Text(
                "Besoin d'aide ?",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.orangePrimary,
                ),
              ),
              SizedBox(height: 50),
              Text("Gérer votre commerce grâce à MobiService",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("L'application qui vous rapproche des clients.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text(
                  "Vous proposez un service à domicile ? Gérez vos rendez-vous grâce à MobiService",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Vous proposez un service itinérant ? Gérez votre itinéraire, vos points d'arrêts et vos propositions clients grâce à MobiService",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Divider(
                thickness: 0.5,
                color: Palette.darkGrey,
              ),
              Text("Contactez nous :",
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              InkWell(
                  child: Text(
                    'mobidelivcontact@gmail.com',
                    style: TextStyle(
                        color: Palette.lightBlue
                    ),
                  ),
                  onTap: () => launchUrl(Uri(
                      scheme: 'mailto',
                      path: 'mobidelivcontact@gmail.com'
                  ))
              ),
              SizedBox(height: 10),
              InkWell(
                  child: Text(
                    'MobiService.com',
                    style: TextStyle(
                        color: Palette.lightBlue
                    ),
                  ),
                  onTap: () => launchUrl(Uri(
                      scheme: 'https',
                      host: 'mobideliv.wordpress.com'
                  ))
              ),
              SizedBox(height: 10),
              InkWell(
                  child: Text(
                    'Notre facebook',
                    style: TextStyle(
                        color: Palette.lightBlue
                    ),
                  ),
                  onTap: () => launchUrl(Uri(
                      scheme: 'https',
                      host: 'www.facebook.com',
                      path: 'profile.php',
                      queryParameters: {
                        'id': '100086195753309'
                      }
                  ))
              ),
            ],
          ),
        ),
      ));
  }
}