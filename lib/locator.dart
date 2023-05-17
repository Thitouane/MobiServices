import 'package:get_it/get_it.dart';
import 'package:mobideliv/features/authentification/presentation/bloc/cubit/type_cubit.dart';
import 'package:mobideliv/features/authentification/presentation/data/repository/auth_repository_impl.dart';
import 'package:mobideliv/features/authentification/presentation/domain/repository/auth_repository.dart';
import 'package:mobideliv/features/client/accueil/presentation/cubit/homeServices/home_services_cubit.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/repository/user_repository.dart';
import 'package:mobideliv/features/client/profil/presentation/domain/usecase/get_user_info_usecase.dart';
import 'package:mobideliv/features/commercant/profil/bloc/profil_trader_cubit.dart';
import 'features/client/accueil/domain/repositories/home_services_repository.dart';
import 'features/client/accueil/domain/use_cases/get_nearby_home_services_use_case.dart';
import 'features/client/profil/presentation/bloc/profil_cubit.dart';
import 'features/client/accueil/data/repository/home_services_repository_impl.dart';
import 'features/client/profil/presentation/data/repository/user/firestore_user_repo_impl.dart';
import 'features/client/profil/presentation/domain/usecase/modify_user_info.dart';
import 'features/commercant/profil/bloc/profil_service_at_home_cubit.dart';
import 'features/commercant/profil/data/repository/firestore_trader_repo_impl.dart';
import 'features/commercant/profil/domain/repository/trader_repository.dart';
import 'features/commercant/profil/domain/usecase/get_trader_info_usecase.dart';
import 'features/commercant/profil/domain/usecase/modify_trader_info.dart';
final locator = GetIt.instance;

void setupLocator() {
  // Repositories
  locator.registerLazySingleton<FirestoreUserRepository>(
      () => FirebaseUserRepoImpl());

  locator
      .registerLazySingleton<FirestoreAuthUserRepository>(() => AuthRepoImpl());
  locator.registerLazySingleton<FirestoreTraderRepository>(
      () => FirebaseTraderRepoImpl());

  // locator.registerLazySingleton<GetUserInfoUseCase>(() => GetUserInfoUseCase(
  //   locator(),
  // ));

  locator
      .registerLazySingleton<ModifyUserInfoUseCase>(() => ModifyUserInfoUseCase(
            locator(),
          ));

  locator
      .registerLazySingleton<GetTraderInfoUseCase>(() => GetTraderInfoUseCase(
            locator(),
          ));

  locator.registerLazySingleton<ModifyTraderInfoUseCase>(
      () => ModifyTraderInfoUseCase(
            locator(),
          ));

  locator.registerLazySingleton<ProfilServiceCubit>(() => ProfilServiceCubit());

  locator.registerLazySingleton<TypeCubit>(() => TypeCubit());

  // locator.registerLazySingleton<ProfilUserCubit>(() => ProfilUserCubit(
  //   getUserInfoUseCase: locator(),
  //   modifyUserInfoUseCase: locator(),
  // ));

  locator.registerLazySingleton<ProfilTraderCubit>(() => ProfilTraderCubit(
        getTraderInfoUseCase: locator(),
        modifyTraderInfoUseCase: locator(),
      ));
  locator.registerLazySingleton<HomeServicesRepository>(
      () => HomeServicesRepositoryImpl());

  // Blocs
  locator.registerLazySingleton<ProfilUserCubit>(() => ProfilUserCubit(
        getUserInfoUseCase: locator(),
        modifyUserInfoUseCase: locator(),
      ));
  locator
      .registerFactory<HomeServicesCubit>(() => HomeServicesCubit(locator()));
  // Use cases
  locator.registerLazySingleton<GetUserInfoUseCase>(() => GetUserInfoUseCase(
        locator(),
      ));
  // locator
  //     .registerLazySingleton<ModifyUserInfoUseCase>(() => ModifyUserInfoUseCase(
  //   locator(),
  // ));

  locator.registerLazySingleton<GetHomeServicesUseCase>(
      () => GetHomeServicesUseCase(locator()));

}
