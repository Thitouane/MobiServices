import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';

import '../../../../core/presentation/client/app_bar.dart';
import '../../../../core/presentation/client/navbar.dart';
import '../../../../core/router/router.gr.dart';
import '../../../commercant/carte/data/cubit/point/point_bloc.dart';
import '../../../commercant/carte/data/cubit/point/point_event.dart';
import '../../../commercant/carte/data/cubit/point/point_state.dart';
import '../../../commercant/carte/data/point_repo.dart';
import '../../../commercant/carte/domain/entity/point_arret.dart';

class AddPointPage extends StatelessWidget {
  final ServiceModel service;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AddPointPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PointBloc>(
        create: (context) => PointBloc(pointRepository: PointRepository())..add(GetComData(service.id!)),
        child: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
            body: _getBody(context),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // TODO : attention id
                AutoRouter.of(context).push(AddPointDetailRoute(
                  point: PointModel(
                      adresse: "",
                      arret: "",
                      arrive: "",
                      commercant: "",
                      point: const GeoPoint(0,0),
                      service: "",
                      name: ""
                  ),
                  service: service
                ));
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.add),
            )
        )
    );
  }

  Widget _getBody(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${service.name} arrêts',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
              ),
            ),
          ) ,
        ),
        BlocBuilder<PointBloc, PointState>(
            builder: (context, state) {
              if (state is PointLoaded) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: state.point.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                title: Text(
                                  state.point[index].adresse,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle: Row(
                                    children: [
                                      const Icon(
                                          Icons.timer_rounded,
                                          size: 16.0
                                      ),
                                      SizedBox(
                                        width: 4.0,
                                      ),
                                      Text('${state.point[index].arrive} : ${state.point[index].arret}'),
                                    ]
                                ),
                              )
                          );
                        }
                    )
                );
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        )
      ],
    );
  }

}
