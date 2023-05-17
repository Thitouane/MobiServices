import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends ServiceEvent {
  final String email;
  final LatLng latlng;
  final String adresse;

  Create(this.email, this.latlng, this.adresse);
}

class GetData extends ServiceEvent {
  GetData();
}

class GetService extends ServiceEvent {
  final String id;
  GetService(this.id);
}

class GetComService extends ServiceEvent {
  GetComService();
}

class GetAmbulant extends ServiceEvent {
  GetAmbulant();
}

class GetAtHome extends ServiceEvent {
  GetAtHome();
}