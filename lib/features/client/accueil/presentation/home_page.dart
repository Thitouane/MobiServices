import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/client/app_bar_acceuil.dart';

import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:mobideliv/core/utils/utils.dart';
import 'package:mobideliv/features/client/accueil/presentation/widgets/ambulant_information.dart';
import 'package:mobideliv/features/client/accueil/presentation/widgets/at_home_information.dart';

class HomeClientPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeClientPage({super.key});


  // TODO : auto sized img
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                    Icons.local_shipping_rounded,
                    color: Palette.orangeTheme,
                    size: 32
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Service Itinérant",
                    style: TextStyle(
                        color: Palette.darkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0
                    ),
                  ),
                ),
              ]
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: AmbulantInformation()
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    color: Palette.orangeTheme,
                    size: 32,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Service à domicile",
                      style: TextStyle(
                        color: Palette.darkGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                ]
            ),
            Expanded(
                child: AtHomeInformation()
            ),
          ],
        )
      )
    );
  }

}
