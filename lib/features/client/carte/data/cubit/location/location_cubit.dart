import 'package:bloc/bloc.dart';
import 'package:location/location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  static const apiURL = 'http://api-adresse.data.gouv.fr';

  LocationCubit()
      : super(LocationInitial());

  Future<LocationData?> getCurrentLocation() async {
    emit(LocationLoading());
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(const LocationLoaded(null));
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        emit(const LocationLoaded(null));
      }
    }
    emit(LocationLoaded(await location.getLocation()));
  }
}
