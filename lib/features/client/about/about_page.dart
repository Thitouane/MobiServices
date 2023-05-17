import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AidePage extends StatefulWidget {
  AidePage({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<AidePage> createState() => _AidePageState();
}

class _AidePageState extends State<AidePage> {
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
              const Icon(Icons.help_outline_outlined,
                  size: 100, color: Palette.orangePrimary),
              const SizedBox(height: 30),
              const Text(
                "Besoin d'aide ?",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Palette.orangePrimary,
                ),
              ),
              const SizedBox(height: 50),
              const Text("Retrouver les commerçants et artisants près de chez vous grâce à MobiService",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              const Text(
                  "Vous proposez un service itinérant ou  à domicile et vous aimeriez le paertager au plus grands nombres ? N'hésitez plus et faites vous un compte commerçant grâce à MobiService ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              const Text(
                  "Grâce à MobiService vous ne serez jamais à cours de commerce!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Divider(
                thickness: 0.5,
                color: Palette.darkGrey,
              ),
              const Text(
                  "Repérez vous grâce à notre carte :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Column(
                  children: [
                    Row(
                        children: const [
                          Icon(Icons.location_on_rounded, color: Palette.lightBlue),
                          Text("Les services à domicile")
                        ]
                    ),
                    Row(
                        children: const [
                          Icon(Icons.location_on_rounded, color: Palette.orangeTheme),
                          Text("Les services itinérant")
                        ]
                    )
                  ],
                ),
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