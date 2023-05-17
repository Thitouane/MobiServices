import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  static const apiURL = 'http://api-adresse.data.gouv.fr';

  AddressCubit()
      : super(AddressInitial());

  Future<List<dynamic>> getFromAddress({
    String address = "3 Avenue Henri Poincare 59650 Villeneuve-d'Ascq"
  }) async {
    emit(AddressLoading());

    var response = await Dio().get(
        '$apiURL/search/',
      queryParameters: {
        "q": address
      }
    );

    var coordinate = response.data["features"][0]["geometry"]["coordinates"];

    emit(AddressLoaded(coordinate));
    return coordinate;
  }
}
