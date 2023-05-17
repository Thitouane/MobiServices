part of 'location_cubit.dart';

abstract class LocationState {
  const LocationState();
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  const LocationLoaded(this.content);

  final LocationData? content;
}
