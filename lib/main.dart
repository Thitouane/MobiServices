import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobideliv/core/router/router.gr.dart';

import 'package:mobideliv/locator.dart';
import 'core/router/router.dart';
import 'core/styles/colors.dart';
import 'core/utils/firebase_options.dart';
import 'features/authentification/presentation/bloc/cubit/type_cubit.dart';
import 'features/client/accueil/presentation/cubit/homeServices/home_services_cubit.dart';
import 'features/client/profil/presentation/bloc/profil_cubit.dart';
import 'features/commercant/profil/bloc/profil_service_at_home_cubit.dart';
import 'features/commercant/profil/bloc/profil_trader_cubit.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    initializeDateFormatting()
        .then((_) => runApp(const MyApp()));
  });
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GetIt sl = GetIt.instance;
    return materialApp(context);
  }

  Widget materialApp(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider<HomeServicesCubit>(
          create: (context) => locator<HomeServicesCubit>(),
        ),
        BlocProvider<ProfilUserCubit>(
          create: (context) => locator<ProfilUserCubit>(),
        ),
        BlocProvider<ProfilUserCubit>(create: (_) => locator<ProfilUserCubit>()),
        BlocProvider<ProfilTraderCubit>(create: (_) => locator<ProfilTraderCubit>()),
        BlocProvider<ProfilServiceCubit>(create: (_) => locator<ProfilServiceCubit>()),
        BlocProvider<TypeCubit>(create: (_) => locator<TypeCubit>()),
      ],
      child:AdaptiveTheme(
        light: ThemeData(
          dividerColor: Colors.transparent,
          brightness: Brightness.light,
          primarySwatch: Palette.orangeTheme,
          fontFamily: "Spartan",
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Palette.darkGrey,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        dark: ThemeData(
          dividerColor: Colors.transparent,
          brightness: Brightness.dark,
          fontFamily: "Spartan",
          primarySwatch: Colors.purple,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Palette.darkGrey,
            ),
          ),
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme,darktheme) => MaterialApp.router(
          title: "Mobideliv",
          theme: theme,
          darkTheme: darktheme,
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
