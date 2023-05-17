import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/accueil/data/repository/service_repo.dart';
import 'package:mobideliv/features/commercant/profil/bloc/profil_service_at_home_state.dart';

import '../../../client/accueil/domain/entity/service_model.dart';





class ProfilServiceCubit extends Cubit<ProfilServiceState> {
  late ServiceModel service;

  ProfilServiceCubit() : super(ProfilServiceInitial());

  static ProfilServiceCubit get(BuildContext context) => BlocProvider.of(context);


  Future<void> fetch(String id) async {
    emit(ProfilServiceLoading());
    try{
      final response = await ServiceRepository().getService(id);
      emit(ProfilServiceLoaded(service: response ));
    } catch(e) {
      emit(ProfilServiceError(message :e.toString()));
    }
  }

  Future<void> updateServiceInfo(String id, ServiceModel serviceInfo) async {
    service = serviceInfo;
    emit(ProfilServiceLoading());
    await ServiceRepository().updateService(id, serviceInfo).then((value){
      emit(ProfilServiceLoaded(service: serviceInfo));
    })
        .catchError((e) {
      e.toString();
    });
  }

  @override
  void onChange(Change<ProfilServiceState> change) {
    super.onChange(change);
    log(change.toString());
  }
}