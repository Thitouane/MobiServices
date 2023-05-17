import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/profil/presentation/bloc/profil_state.dart';
import 'package:mobideliv/features/commercant/profil/bloc/profil_trader_state.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';
import 'package:mobideliv/features/commercant/profil/domain/usecase/get_trader_info_usecase.dart';
import 'package:mobideliv/features/commercant/profil/domain/usecase/modify_trader_info.dart';





class ProfilTraderCubit extends Cubit<ProfilTraderState> {
  final GetTraderInfoUseCase getTraderInfoUseCase;
  final ModifyTraderInfoUseCase modifyTraderInfoUseCase;
  late Trader trader;

  ProfilTraderCubit({required this.getTraderInfoUseCase, required this.modifyTraderInfoUseCase}) : super(ProfilTraderInitial());

  static ProfilTraderCubit get(BuildContext context) => BlocProvider.of(context);


  Future<void> fetch() async {
    emit(ProfilTraderLoading());
    try{
      final response = await this.getTraderInfoUseCase.call(paramsOne: "", paramsTwo: true);
      emit(ProfilTraderLoaded(trader: response ));
    } catch(e) {
      emit(ProfilTraderError(message :e.toString()));
    }
  }

  Future<void> updateTraderInfo(String id, Trader traderInfo) async {
    trader = traderInfo;
    emit(ProfilTraderLoading());
    await modifyTraderInfoUseCase.call(paramsOne: traderInfo, paramsTwo: true).then((String info){
      emit(ProfilTraderLoaded(trader: traderInfo));
    })
        .catchError((e) {
      e.toString();
    });
  }

  @override
  void onChange(Change<ProfilTraderState> change) {
    super.onChange(change);
    log(change.toString());
  }
}