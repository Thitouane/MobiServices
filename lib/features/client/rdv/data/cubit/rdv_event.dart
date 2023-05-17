import 'package:booking_calendar/booking_calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';


abstract class RdvEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends RdvEvent {
  final String email;
  final LatLng latlng;
  final String adresse;

  Create(this.email, this.latlng, this.adresse);
}

class GetRdvData extends RdvEvent {
  GetRdvData();
}

class GetComAll extends RdvEvent {
  GetComAll();
}

class DelRdv extends RdvEvent {
  final BookingService service;

  DelRdv(this.service);
}