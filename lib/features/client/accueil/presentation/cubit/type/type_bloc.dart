import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/accueil/data/repository/type_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/type_model.dart';

part 'type_event.dart';
part 'type_state.dart';

class TypeBloc extends Bloc<TypeEvent, TypeState> {
  final TypeRepository typeRepository;

  TypeBloc({required this.typeRepository}) : super(TypeInitial()) {
    on<GetAtHomeData>((event, emit) async {
      emit(TypeLoading());
      try {
        final data = await typeRepository.getAtHome();
        await Future.delayed(const Duration(seconds: 2));
        emit(TypeLoaded(data));
      } catch (e) {
        emit(TypeError(e.toString()));
      }
    });
  }
}