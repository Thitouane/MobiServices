import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_event.dart';
import 'package:mobideliv/features/client/rdv/data/cubit/rdv_state.dart';
import 'package:mobideliv/features/client/rdv/data/repo/rdv_repo.dart';
import 'package:mobideliv/features/client/rdv/domain/entity/booking.dart';

class RdvBloc extends Bloc<RdvEvent, RdvState> {
  final RdvRepository rdvRepository;
  RdvBloc({required this.rdvRepository}) : super(RdvInitial()) {
    on<GetRdvData>((event, emit) async {
      emit(RdvLoading());
      try {
        final data = await rdvRepository.getAll();
        await Future.delayed(const Duration(seconds: 1));
        emit(RdvLoaded(data));
      } catch (e) {
        emit(RdvError(e.toString()));
      }
    });

    on<GetComAll>((event, emit) async {
      emit(RdvLoading());
      try {
        final data = await rdvRepository.getComAll();
        await Future.delayed(const Duration(seconds: 1));
        emit(RdvLoaded(data));
      } catch (e) {
        emit(RdvError(e.toString()));
      }
    });

    on<DelRdv>((event, emit) async {
      try {
        emit(RdvLoading());
        final data = await rdvRepository.deleteOne(event.service);
        await Future.delayed(const Duration(seconds: 5));
        emit(RdvLoaded([BookingModel(booking: data)]));
      } catch (e) {
        emit(RdvError(e.toString()));
      }
    });
  }
}