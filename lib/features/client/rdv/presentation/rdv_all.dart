import 'package:auto_route/auto_route.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_bloc.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_event.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_state.dart';
import 'package:mobideliv/features/client/rdv/data/repo/rdv_repo.dart';
import 'package:mobideliv/features/client/rdv/domain/entity/jour.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/presentation/client/navbar.dart';
import '../../../../core/styles/colors.dart';

class RdvAllPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RdvAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MobiService',
        theme: ThemeData(
            primarySwatch: Palette.orangeTheme,
            fontFamily: "Spartan"),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
            body: _body(context) //const DetailView()
        )
    );
  }

  Widget _body(BuildContext context) {
    return BlocProvider(
        create: (context) =>
        RdvBloc(
            rdvRepository: RdvRepository()
        )
          ..add(GetRdvData()),
        child: Column(
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
                                      '${service?.name}',
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
                                    trailing: IconButton(
                                      icon: const Icon(Icons.cancel_rounded),
                                      onPressed: () {
                                        BlocProvider.of<RdvBloc>(context).add(DelRdv(booking!));

                                        Vibration.vibrate();
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Rendez-vous supprimé"),
                                        ));

                                        AutoRouter.of(context).pushNamed('/client-home');
                                      },
                                    ),
                                    onTap: () {
                                      AutoRouter.of(context).push(RdvDetailRoute(booking: state.mydata[index]));
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
          )
    );
  }
}
