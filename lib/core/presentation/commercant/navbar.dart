import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/commercant/profil/data/data_sources/firestore_trader_info.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';

import '../../../features/authentification/presentation/data/data_sources/auth_repository.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  late String nom = "";
  late String firstname = "";
  late String img = "assets/anonyme.png";

  void loadData(context) async{
    Trader user = await FirestoreTrader.getTrader("");
    setState(() {
      if (user.getName() != ""){
        this.nom = user.getName();
      }
      else {
        this.nom = "Anonyme";
      }
      this.firstname = user.getFirstName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 105,
              child: DrawerHeader(
                  child: Card(
                    child: ListTile(
                      leading: Image.asset(
                        img,
                      ),
                      title: Text(firstname),
                      subtitle: Text(nom),
                      onTap: () {
                        AutoRouter.of(context).push(ProfilTraderRoute(edit: false, choice: ""));
                      },
                    ),
                  )),
            ),
            Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Accueil'),
                      onTap: () {
                        AutoRouter.of(context).pushNamed("/commercant-home");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profil'),
                      onTap: () {
                        AutoRouter.of(context).push(ProfilTraderRoute(
                          edit: false,
                          choice: "commerçant",
                        ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.map),
                      title: const Text('Carte'),
                      onTap: () {
                        AutoRouter.of(context).pushNamed("/carte-commercant");
                      },
                    ),
                  ],
                )),
            const Divider(
              height: 2.0,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Aide'),
                      onTap: () {
                        AutoRouter.of(context).pushNamed("/about-commercant");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Déconnexion'),
                      onTap: () {
                        AdaptiveTheme.of(context).setLight();
                        FirestoreAuth().signedOut();
                        AutoRouter.of(context).push(WelcomeRoute());
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
