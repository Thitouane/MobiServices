import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';

import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/core/styles/colors.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';

class AmbulantDetailPage extends StatelessWidget {
  final ServiceModel commercant;

  AmbulantDetailPage({super.key, required this.commercant});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'MobiService',
        theme: ThemeData(
            primarySwatch: Palette.orangeTheme, fontFamily: "Spartan"),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar:  CustomAppBar(scaffoldKey: _scaffoldKey),
            body: _body(context)//const DetailView()
        )
    );
  }

  Widget _body(BuildContext context) {

    return ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0),
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                    commercant.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Spartan",
                      color: Color.fromRGBO(89, 89, 89, 1),
                      fontWeight: FontWeight.bold,
                    )
                ),
                subtitle: commercant.at_home 
                    ? Text('à domicile')
                    : Text('itinérant'),
                leading: Image.asset(
                    height: MediaQuery.of(context).size.height * 0.10,
                    '${commercant.img}'
                ),
                trailing: commercant.at_home
                    ? FloatingActionButton(
                      child: const Icon(Icons.calendar_month),
                      onPressed: () {
                        AutoRouter.of(context).push(RdvRoute(commercant: commercant));
                      },
                    )
                    : FloatingActionButton(
                child: const Icon(Icons.add_location_alt_rounded),
                onPressed: () {
                  AutoRouter.of(context).push(AddPointRoute(service: commercant));
                },
              ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color.fromRGBO(243, 243, 243, 1),
              child: ListTile(
                leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.home_repair_service_rounded,
                        color: Color.fromRGBO(255, 112, 78, 1),
                      ),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          thickness: 2,
                        ),
                      )
                    ]
                ),
                title: Text(
                    '${commercant.type}'
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color.fromRGBO(243, 243, 243, 1),
              child: ListTile(
                leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.location_on_rounded,
                        color: Color.fromRGBO(255, 112, 78, 1),
                      ),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          thickness: 2,
                        ),
                      )
                    ]
                ),
                title: Text(
                    '${commercant.adresse}, ${commercant.ville}'
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color.fromRGBO(243, 243, 243, 1),
              child: ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.access_time_filled_outlined,
                      color: Color.fromRGBO(255, 112, 78, 1),
                    ),
                    SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        thickness: 2,
                      ),
                    )
                  ],
                ),
                title: Text(
                    '${commercant.horraire}'
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color.fromRGBO(243, 243, 243, 1),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.info,
                            color: Color.fromRGBO(255, 112, 78, 1),
                          ),
                          SizedBox(
                            height: 20,
                            child: VerticalDivider(
                              thickness: 2,
                            ),
                          ),
                          Text('Informations supplémentaires'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                        '${commercant.info}'
                    ),
                  )
                ],
              ),
            ),
            Card(
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color.fromRGBO(243, 243, 243, 1),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.contact_mail,
                              color: Color.fromRGBO(255, 112, 78, 1),
                            ),
                            SizedBox(
                              height: 20,
                              child: VerticalDivider(
                                thickness: 2,
                              ),
                            ),
                            Text('Contact'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: Color.fromRGBO(3, 169, 244, 1),
                              ),
                              title: Text(
                                  '${commercant.tel}'
                              )
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.alternate_email,
                              color: Color.fromRGBO(3, 169, 244, 1),
                            ),
                            title: Text(
                                '${commercant.mail}'
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: commercant.at_home
                      ? const Text("")
                      : TextButton(
                    onPressed: () {
                      AutoRouter.of(context).push(
                          ItineraireCommercantRoute(service: commercant)
                      );
                    },
                    child: const Text(
                      "Voir l'itinéraire",
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Palette.lightBlue
                      ),
                    ),
                  )
              ),
            )
          ],
        );
  }
}
