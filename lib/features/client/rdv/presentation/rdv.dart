import 'package:flutter/material.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';

import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:mobideliv/features/client/rdv/data/repo/rdv_repo.dart';

class RdvPage extends StatefulWidget {
  final ServiceModel commercant;

  const RdvPage({super.key, required this.commercant});

  @override
  State<StatefulWidget> createState() {
    return _RdvPageState();
  }
}

class _RdvPageState extends State<RdvPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final now = DateTime.now();
  late BookingService? service;
  late bool init = false;

  @override
  void initState() {
    super.initState();
    loadData(context);
  }

  List<DateTimeRange> converted = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavBar(),
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        body: Center(
          child:
            init
              ? BookingCalendar(
              bookedSlotTextStyle:
              const TextStyle(color: Colors.red, fontSize: 24),
              availableSlotTextStyle:
              TextStyle(color: Colors.blue[900], fontSize: 24),
              selectedSlotTextStyle: TextStyle(
                  color: Colors.red[900],
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
              bookingService: service!,
              convertStreamResultToDateTimeRanges: RdvRepository().convertStreamResultFirebase,
              getBookingStream: RdvRepository().getBookingStreamFirebase,
              uploadBooking: RdvRepository().addBooking,
              availableSlotText: "Disponnible",
              selectedSlotText: "Sélectionné",
              bookedSlotText: "Réservé",
              hideBreakTime: true,
              loadingWidget: const Text('...'),
              uploadingWidget: const CircularProgressIndicator(),
              locale: 'fr_FR',
              startingDayOfWeek: StartingDayOfWeek.monday,
            )
              : const CircularProgressIndicator(),
        ),
    );
  }

  void loadData(context) async{
    String? userId = await FirestoreAuth().getCurrentUserId();
    String client = await RdvRepository().getClientName(userId!);

    setState(() {
      service = BookingService(
          serviceName: widget.commercant.name,
          serviceId: widget.commercant.id,
          userId: userId,
          userName: client,
          serviceDuration: 30,
          bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
          bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
    });
    init = true;
  }
}
