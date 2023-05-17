import 'package:auto_route/auto_route.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';
import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/client/rdv/domain/entity/booking.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/presentation/client/navbar.dart';
import '../../../../core/styles/colors.dart';
import '../data/cubit/rdv_bloc.dart';
import '../data/cubit/rdv_event.dart';
import '../data/cubit/rdv_state.dart';
import '../domain/entity/jour.dart';

import 'package:mobideliv/features/client/rdv/data/repo/rdv_repo.dart';

class RdvDetailPage extends StatelessWidget {
  final BookingModel booking;

  RdvDetailPage({super.key, required this.booking});
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
    var startDate = booking.booking?.bookingStart.weekday;

    return  BlocProvider(
      create: (context) =>
        RdvBloc(
          rdvRepository: RdvRepository()
        ),
      child: BlocBuilder<RdvBloc, RdvState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0, top: 8.0, right: 20.0),
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      height: MediaQuery.of(context).size.height * 0.10,
                      '${booking.service?.img}',
                    ),
                    title: Text(
                      '${booking.service?.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: FloatingActionButton(
                      onPressed: () {
                        BlocProvider.of<RdvBloc>(context).add(DelRdv(booking.booking!));

                        Vibration.vibrate();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Rendez-vous supprimé"),
                        ));

                        Future.delayed(const Duration(seconds: 3), () {
                          AutoRouter.of(context).pushNamed('/client-home');
                        });
                      },
                      child: const Icon(Icons.delete_outline),
                    ),
                    onTap: () {
                      AutoRouter.of(context).push(AmbulantDetailRoute(commercant: booking.service!));
                    },
                  ),
                ),
                const SizedBox(
                height: 8.0,
                ),
                Card(
                child: ListTile(
                title: Text(
                '${startDate != null ? Jour.values[startDate-1].name : ""} ${booking.booking?.bookingStart.day} : ${booking.booking?.bookingStart.hour}h${booking.booking?.bookingStart.minute}  '
                'à'
                '  ${booking.booking?.bookingEnd.hour}h${booking.booking?.bookingEnd.minute}'
                ),
                leading: const Icon(
                Icons.timer_rounded,
                ),
                ),
                ),
                Card(
                  child: ListTile(
                    title: Text('${booking.service?.adresse}, ${booking.service?.ville}'),
                    leading: const Icon(
                      Icons.location_on_rounded,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}
