import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/presentation/client/app_bar.dart';
import '../../../../core/presentation/client/navbar.dart';
import '../../../../core/styles/colors.dart';
import '../../../commercant/carte/data/cubit/point/point_bloc.dart';
import '../../../commercant/carte/data/cubit/point/point_event.dart';
import '../../../commercant/carte/data/point_repo.dart';
import '../../../commercant/carte/domain/entity/point_arret.dart';
import '../../accueil/domain/entity/service_model.dart';
import '../data/cubit/address/address_cubit.dart';

class AddPointDetailPage extends StatefulWidget {
  final PointModel point;
  final ServiceModel service;
  AddPointDetailPage({super.key, required this.point, required this.service});

  @override
  State<StatefulWidget> createState() {
    return _AddPointDetailState();
  }
}

class _AddPointDetailState extends State<AddPointDetailPage> {
  TextEditingController adresseController = TextEditingController();
  TextEditingController arriveController = TextEditingController();
  TextEditingController arretController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  late StackRouter _autorouter;

  @override
  void didChangeDependencies() {
    _autorouter = AutoRouter.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    adresseController.text = widget.point.adresse ?? "";
    arretController.text = widget.point.arret ?? "";
    arriveController.text = widget.point.arrive ?? "";
    infoController.text = widget.point.info ?? "";

  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
        title: 'MobiService',
        theme: ThemeData(
            primarySwatch: Palette.orangeTheme, fontFamily: "Spartan"),
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => PointBloc(pointRepository: PointRepository())
            ),
            BlocProvider(
                create: (context) => AddressCubit()
            ),
          ],
          child: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar:CustomAppBar(
              scaffoldKey: _scaffoldKey,
            ),
            body: _body(context)//const DetailView()
        )
      )
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: ListTile(
                      leading: /*Image.network("")*/const Icon(
                        Icons.person,
                        color: Colors.orangeAccent,
                      ),
                      title: Text("${widget.point.name}"),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: adresseController,
                      decoration: const InputDecoration(
                      icon: Icon(
                      Icons.location_on_rounded,
                      color: Colors.orangeAccent,
                      ),
                      labelText: "Adresse"
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: arriveController,
                      decoration: const InputDecoration(
                  icon: Icon(
                  Icons.local_shipping_rounded,
                  color: Colors.orangeAccent,
                  ),
                  labelText: "Heure d'arrivée"
                  ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: arretController,
                      decoration: const InputDecoration(
                    icon: Icon(
                    Icons.timer,
                    color: Colors.orangeAccent,
                    ),
                    labelText: "Durée de l'arrêt"
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: infoController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                icon: Icon(
                Icons.info,
                color: Colors.orangeAccent,
                ),
                labelText: "informations"
                ),
                    ),
                  ),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        onPressed: () async {
                          List<dynamic> latlng = await context.read<AddressCubit>().getFromAddress(
                              address: adresseController.text
                          );
                          GeoPoint point = GeoPoint(latlng.last, latlng.first);
                          setState(() {
                            widget.point.setAdresse = adresseController.text;
                            widget.point.setInfo = infoController.text;
                            widget.point.setArret = arretController.text;
                            widget.point.setArrive = arriveController.text;
                            widget.point.setPoint = point;
                          });

                          context.read<PointBloc>().add(AddData(
                            widget.point,
                            widget.service
                          ));

                          Vibration.vibrate();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Point ajouté"),
                          ));

                          Future.delayed(Duration(seconds: 3), () {
                            _autorouter.push(AddPointRoute(service: widget.service));
                          });
                        },
                        child: const Text(
                          "Valider",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.greenAccent,
                          ),
                        )
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: TextButton(
                          onPressed: ()  {
                            AutoRouter.of(context).pop();
                          },
                          child: const Text(
                            "Annuler",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.redAccent
                            ),
                          )
                      )
                  )
                ],
              ),
            )
          ],
        );
      }
    );
  }
}

