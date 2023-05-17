import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';

import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:mobideliv/core/utils/utils.dart';


import '../../accueil/presentation/widgets/ambulant_information.dart';
import '../../accueil/presentation/widgets/at_home_information.dart';

class FavorisPage extends StatefulWidget {
  FavorisPage({Key? key}) : super(key: key);

  @override
  State<FavorisPage> createState() => FavoriteState();
}

class FavoriteState extends State<FavorisPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavBar(),
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text('Favoris'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Icon(Icons.home, color: Palette.orangeTheme),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Itinérant",
                        style: TextStyle(
                          color: Palette.orangeTheme,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: AmbulantInformation()
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Icon(
                        Icons.home_repair_service,
                        color: Palette.orangeTheme
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Service à domicile",
                        style: TextStyle(
                          color: Palette.orangeTheme,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: AtHomeInformation()
                )
              ],
            )
        )
    );
  }

}