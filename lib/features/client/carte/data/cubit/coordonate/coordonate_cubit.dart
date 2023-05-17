import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

part 'coordonate_state.dart';

class CoordonateCubit extends Cubit<CoordonateState> {
  static const apiURL = 'http://api-adresse.data.gouv.fr';

  // TODO : to data
  final _commercants = FirebaseFirestore.instance
      .collection('commercant')
      .snapshots();

  CoordonateCubit()
      : super(CoordonateInitial());

  getFromLatLong({
    double lat = 50.635787,
    double lon = 3.07045
  }) async {
    emit(CoordonateLoading());
    var response = await Dio().get(
        '$apiURL/reverse/',
        queryParameters: {
          "lat": lat,
          "lon": lon
        }
    );
    var address = response.data["features"][0]["properties"]["label"];
    emit(CoordonateLoaded(address));
  }
}