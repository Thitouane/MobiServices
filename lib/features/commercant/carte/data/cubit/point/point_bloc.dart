import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/commercant/carte/data/cubit/point/point_event.dart';
import 'package:mobideliv/features/commercant/carte/data/cubit/point/point_state.dart';
import 'package:mobideliv/features/commercant/carte/data/point_repo.dart';


class PointBloc extends Bloc<PointEvent, PointState> {
  final PointRepository pointRepository;

  PointBloc({required this.pointRepository}) : super(PointInitial()) {
    on<GetMyData>((event, emit) async {
      emit(PointLoading());
      try {
        final data = await pointRepository.getMyPoints();
        await Future.delayed(const Duration(seconds: 2));
        emit(PointLoaded(data));
      } catch (e) {
        emit(PointError(e.toString()));
      }
    });

    on<UpdateMyData>((event, emit) async {
      try {
        await pointRepository.updateMyData(event.point);
      } catch (e) {
        emit(PointError(e.toString()));
      }
    });

    on<AddData>((event, emit) async {
      try {
        await pointRepository.addData(
          event.point,
          event.service
        );
      } catch (e) {
        emit(PointError(e.toString()));
      }
    });

    on<DelPoint>((event, emit) async {
      try {
        await pointRepository.delData(
            event.point
        );
      } catch (e) {
        emit(PointError(e.toString()));
      }
    });

    on<GetComData>((event, emit) async {
      emit(PointLoading());
      try {
        final data = await pointRepository.getComPoints(event.mail);
        await Future.delayed(const Duration(seconds: 2));
        emit(PointLoaded(data));
      } catch (e) {
        emit(PointError(e.toString()));
      }
    });
  }

}