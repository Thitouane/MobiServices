import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/home_service_entity.dart';
import 'package:mobideliv/features/client/accueil/domain/use_cases/get_nearby_home_services_use_case.dart';
part 'home_services_state.dart';

class HomeServicesCubit extends Cubit<HomeServicesState> {
  final GetHomeServicesUseCase _getHomeServices;
  HomeServicesCubit(this._getHomeServices) : super(HomeServicesInitial());

  static HomeServicesCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future getAllCommercantByService(String serviceName) async {
    emit(HomeServicesLoading());
    await _getHomeServices.call(serviceName).then((homeServices) {
      emit(HomeServicesLoaded(homeServices: homeServices));
    }).catchError((error) {
      emit(HomeServicesError(message: error.toString()));
    });
  }

  @override
  void onChange(Change<HomeServicesState> change) {
    super.onChange(change);
  }
}
