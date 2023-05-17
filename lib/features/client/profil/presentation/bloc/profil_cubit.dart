import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobideliv/features/client/profil/presentation/bloc/profil_state.dart';

import '../../../../authentification/presentation/data/data_sources/auth_repository.dart';
import '../domain/entity/client_entity.dart';
import '../domain/usecase/get_user_info_usecase.dart';
import '../domain/usecase/modify_user_info.dart';



class ProfilUserCubit extends Cubit<ProfilUserState> {
  final GetUserInfoUseCase getUserInfoUseCase;
  final ModifyUserInfoUseCase modifyUserInfoUseCase;
  late Client user;
  String userid = "";

  void getUserId() async{
    var id = await FirestoreAuth().getCurrentUserId();
    userid = id.toString();
  }

  String transform(){
    String idea = "";
    return idea;
  }

  ProfilUserCubit({required this.getUserInfoUseCase, required this.modifyUserInfoUseCase}) : super(ProfilUserInitial());

  static ProfilUserCubit get(BuildContext context) => BlocProvider.of(context);


  Future<void> fetch() async {
    emit(ProfilUserLoading());
    try{
      final response = await this.getUserInfoUseCase.call(paramsOne: userid, paramsTwo: true);
      await Future.delayed(const Duration(seconds: 1));
      emit(ProfilUserLoaded(user: response ));
    } catch(e) {
      emit(ProfilUserError(message :e.toString()));
    }
  }

  Future<void> updateUserInfo(String id, Client userInfo) async {
    user = userInfo;
    emit(ProfilUserLoading());
    await modifyUserInfoUseCase.call(paramsOne: userInfo, paramsTwo: true).then((String info){
      emit(ProfilUserLoaded(user: userInfo));
    })
        .catchError((e) {
      e.toString();
    });
  }

  @override
  void onChange(Change<ProfilUserState> change) {
    super.onChange(change);
    log(change.toString());
  }
}