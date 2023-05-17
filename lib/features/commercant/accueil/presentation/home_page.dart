import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/carte/data/cubit/service/service_state.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_bloc.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_event.dart';
import 'package:mobideliv/features/client/rdv/data/repo/rdv_repo.dart';
import 'package:mobideliv/features/commercant/carte/data/cubit/point/point_bloc.dart';
import 'package:mobideliv/features/commercant/carte/data/point_repo.dart';

import '../../../../core/presentation/commercant/app_bar_acceuil.dart';
import '../../../../core/presentation/commercant/navbar.dart';
import '../../../../core/router/router.gr.dart';
import '../../../client/accueil/data/repository/service_repo.dart';
import '../../../client/carte/data/cubit/service/service_bloc.dart';
import '../../../client/carte/data/cubit/service/service_event.dart';
import '../../../client/rdv/data/cubit/rdv_state.dart';
import '../../../client/rdv/domain/entity/jour.dart';
import '../../carte/data/cubit/point/point_event.dart';
import '../../carte/data/cubit/point/point_state.dart';
import '../../carte/domain/entity/point_arret.dart';

class HomeCommercantPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeCommercantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavBar(),
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ServiceBloc(serviceRepository: ServiceRepository())..add(GetComService()),
        ),
        BlocProvider(
          create: (context) => RdvBloc(rdvRepository: RdvRepository())..add(GetComAll()),
        ),
        BlocProvider(
          create: (context) => PointBloc(pointRepository: PointRepository())..add(GetMyData()),
        ),
        ],
      child: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServiceLoaded) {
            if (state.mydata.first.at_home) {
              return Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:Text(
                        "Mes Rendez-Vous",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                    ) ,
                  ),
                  BlocBuilder<RdvBloc, RdvState>(
                      builder: (context, state) {
                        if (state is RdvLoaded) {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: state.mydata.length,
                                  itemBuilder: (context, index) {
                                    var service = state.mydata[index].service;
                                    var booking = state.mydata[index].booking;
                                    var endDate = state.mydata[index].booking?.bookingEnd.weekday;
                                    var startDate = state.mydata[index].booking?.bookingStart.weekday;
                                    return Card(
                                        child: ListTile(
                                          title: Text(
                                            '${booking?.userName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          subtitle: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.timer_rounded,
                                                        size: 16.0
                                                    ),
                                                    SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Text('${startDate != null ? Jour.values[startDate-1].name : ""} ${state.mydata[index].booking?.bookingStart.day} : ${state.mydata[index].booking?.bookingStart.hour}h${state.mydata[index].booking?.bookingStart.minute}'),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.timer_off_rounded,
                                                        size: 16.0
                                                    ),
                                                    SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Text('${endDate != null ? Jour.values[endDate-1].name : ""} ${state.mydata[index].booking?.bookingEnd.day} : ${state.mydata[index].booking?.bookingEnd.hour}h${state.mydata[index].booking?.bookingEnd.minute}'),
                                                  ],
                                                )
                                              ]
                                          ),
                                          onTap: () {
                                            AutoRouter.of(context).push(RdvComDetailRoute(booking: state.mydata[index]));
                                          },
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
            } else {
              return Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:Text(
                        "Mes Arrêts",
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
                                          onTap: () {
                                            AutoRouter.of(context).push(PointDetailRoute(point: state.point[index]));
                                          },
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
          } else if (state is ServiceLoading){
            return Center(child: CircularProgressIndicator(),);
          } else {
            return Center(child: Text(
              "Pas de service associé"
            ));
          }
        }
      )
    );
  }
}
