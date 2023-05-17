import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/carte/data/cubit/service/service_event.dart';
import 'package:mobideliv/features/client/carte/data/cubit/service/service_state.dart';

import '../../../../accueil/data/repository/service_repo.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;
  ServiceBloc({required this.serviceRepository}) : super(ServiceInitial()) {
    on<GetData>((event, emit) async {
      emit(ServiceLoading());
      try {
        final data = await serviceRepository.getAll();
        await Future.delayed(const Duration(seconds: 1));
        emit(ServiceLoaded(data));
      } catch (e) {
        emit(ServiceError(e.toString()));
      }
    });

    on<GetAmbulant>((event, emit) async {
      emit(ServiceLoading());
      try {
        final data = await serviceRepository.getAmbulant();
        await Future.delayed(const Duration(seconds: 1));
        emit(ServiceLoaded(data));
      } catch (e) {
        emit(ServiceError(e.toString()));
      }
    });

    on<GetAtHome>((event, emit) async {
      emit(ServiceLoading());
      try {
        final data = await serviceRepository.getAtHome();
        await Future.delayed(const Duration(seconds: 1));
        emit(ServiceLoaded(data));
      } catch (e) {
        emit(ServiceError(e.toString()));
      }
    });

    on<GetService>((event, emit) async {
      emit(ServiceLoading());
      try {
        final data = await serviceRepository.getService(event.id);
        await Future.delayed(const Duration(seconds: 1));
        emit(ServiceLoaded([data]));
      } catch (e) {
        emit(ServiceError(e.toString()));
      }
    });

    on<GetComService>((event, emit) async {
      emit(ServiceLoading());
      try {
        final data = await serviceRepository.getComService();
        await Future.delayed(const Duration(seconds: 1));
        emit(ServiceLoaded(data));
      } catch (e) {
        emit(ServiceError(e.toString()));
      }
    });
  }
}