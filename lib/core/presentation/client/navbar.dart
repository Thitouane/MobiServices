import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/authentification/authentification_page.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';
import 'package:mobideliv/features/client/profil/presentation/data/data_sources/firestore_user_info.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {

  NavBarState();

  late String nom = "";
  late String firstname = "";
  late String img = "assets/anonyme.png";

  void loadData(context) async{
    Client user = await FirestoreUser.getUser("");
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
              height: MediaQuery.of(context).size.height * 0.18,
              child: DrawerHeader(
                  child: Card(
                    child: buildListTile(context)
                    ),
                  ),
            ),
            Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Accueil'),
                      onTap: () {
                        AutoRouter.of(context).pushNamed("/client-home");
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profil'),
                      onTap: () {
                        AutoRouter.of(context).push(ProfilRoute(edit: false));
                      },
                    ),/*
                    ListTile(
                      leading: const Icon(Icons.search),
                      title: const Text('Recherche'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/recherche');
                      },
                    ),*/
                    ListTile(
                      leading: const Icon(Icons.map),
                      title: const Text('Carte'),
                      onTap: () {
                        AutoRouter.of(context).pushNamed("/carte-client");
                      },
                    ),/*
                    ListTile(
                      leading: const Icon(Icons.favorite_border),
                      title: const Text('Favoris'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/favoris', arguments: user);
                      },
                    ),*/
                    ListTile(
                      leading: const Icon(Icons.event_note_outlined),
                      title: const Text('Rendez-vous'),
                      onTap: () {
                        AutoRouter.of(context).push(RdvAllRoute());
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
                        AutoRouter.of(context).pushNamed('/about-client');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Paramètre'),
                      onTap: () {
                        AutoRouter.of(context).push(
                            ParameterClientRoute()
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Déconnexion'),
                      onTap: () {
                        FirestoreAuth().signedOut();
                        AutoRouter.of(context).push(
                          WelcomeRoute(),
                        );
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

  ListTile buildListTile(context) {
    loadData(context);
    return ListTile(
      leading: Image.asset(
          height: MediaQuery.of(context).size.height * 0.10,
          img),
      title: Text(nom),
      subtitle: Text(firstname),
      onTap: () {
        AutoRouter.of(context).push(ProfilRoute(edit: false));
      },
    );
  }
}
