// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;
import 'package:mobideliv/features/authentification/authentification_page.dart'
    as _i18;
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_client_page.dart'
    as _i17;
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_company.dart'
    as _i19;
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_company_page_2.dart'
    as _i20;
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_password_client.dart'
    as _i21;
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_password_trader.dart'
    as _i22;
import 'package:mobideliv/features/authentification/presentation/widget/type_service_page.dart'
    as _i23;
import 'package:mobideliv/features/client/about/about_page.dart' as _i27;
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart'
    as _i31;
import 'package:mobideliv/features/client/accueil/presentation/home_page.dart'
    as _i1;
import 'package:mobideliv/features/client/accueil/presentation/widgets/ambulant_detail_page.dart'
    as _i3;
import 'package:mobideliv/features/client/accueil/presentation/widgets/at_home_detail_page.dart'
    as _i4;
import 'package:mobideliv/features/client/carte/presentation/add_point_detail_page.dart'
    as _i10;
import 'package:mobideliv/features/client/carte/presentation/add_point_page.dart'
    as _i9;
import 'package:mobideliv/features/client/carte/presentation/carte_itineraire.dart'
    as _i16;
import 'package:mobideliv/features/client/carte/presentation/carte_page.dart'
    as _i13;
import 'package:mobideliv/features/client/favoris/presentation/favoris_page.dart'
    as _i12;
import 'package:mobideliv/features/client/parameter/parameter_client_page.dart'
    as _i26;
import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart'
    as _i35;
import 'package:mobideliv/features/client/profil/presentation/profil_page.dart'
    as _i11;
import 'package:mobideliv/features/client/rdv/domain/entity/booking.dart'
    as _i32;
import 'package:mobideliv/features/client/rdv/presentation/rdv.dart' as _i5;
import 'package:mobideliv/features/client/rdv/presentation/rdv_all.dart' as _i6;
import 'package:mobideliv/features/client/rdv/presentation/rdv_detail.dart'
    as _i7;
import 'package:mobideliv/features/commercant/about/about_page.dart' as _i28;
import 'package:mobideliv/features/commercant/accueil/presentation/home_page.dart'
    as _i2;
import 'package:mobideliv/features/commercant/accueil/presentation/rdv_detail.dart'
    as _i8;
import 'package:mobideliv/features/commercant/carte/domain/entity/point_arret.dart'
    as _i33;
import 'package:mobideliv/features/commercant/carte/presentation/carte_page.dart'
    as _i14;
import 'package:mobideliv/features/commercant/carte/presentation/point_detail_page.dart'
    as _i15;
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart'
    as _i34;
import 'package:mobideliv/features/commercant/profil/profil_trader_page.dart'
    as _i24;
import 'package:mobideliv/features/commercant/profil/widget/profil_service_page.dart'
    as _i25;

class AppRouter extends _i29.RootStackRouter {
  AppRouter([_i30.GlobalKey<_i30.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i29.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      final args = routeData.argsAs<HomePageRouteArgs>(
          orElse: () => const HomePageRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeClientPage(key: args.key),
      );
    },
    HomeCommercantRoute.name: (routeData) {
      final args = routeData.argsAs<HomeCommercantRouteArgs>(
          orElse: () => const HomeCommercantRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.HomeCommercantPage(key: args.key),
      );
    },
    AmbulantDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AmbulantDetailRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.AmbulantDetailPage(
          key: args.key,
          commercant: args.commercant,
        ),
      );
    },
    AtHomeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AtHomeDetailRouteArgs>(
          orElse: () => const AtHomeDetailRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.AtHomeDetailPage(
          key: args.key,
          commercant: args.commercant,
        ),
      );
    },
    RdvRoute.name: (routeData) {
      final args = routeData.argsAs<RdvRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i5.RdvPage(
          key: args.key,
          commercant: args.commercant,
        ),
      );
    },
    RdvAllRoute.name: (routeData) {
      final args = routeData.argsAs<RdvAllRouteArgs>(
          orElse: () => const RdvAllRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.RdvAllPage(key: args.key),
      );
    },
    RdvDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RdvDetailRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.RdvDetailPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    RdvComDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RdvComDetailRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.RdvComDetailPage(
          key: args.key,
          booking: args.booking,
        ),
      );
    },
    AddPointRoute.name: (routeData) {
      final args = routeData.argsAs<AddPointRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.AddPointPage(
          key: args.key,
          service: args.service,
        ),
      );
    },
    AddPointDetailRoute.name: (routeData) {
      final args = routeData.argsAs<AddPointDetailRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i10.AddPointDetailPage(
          key: args.key,
          point: args.point,
          service: args.service,
        ),
      );
    },
    ProfilRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i11.ProfilPage(
          args.edit,
          key: args.key,
        ),
      );
    },
    Favoris.name: (routeData) {
      final args =
          routeData.argsAs<FavorisArgs>(orElse: () => const FavorisArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i12.FavorisPage(key: args.key),
      );
    },
    CarteClientRoute.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.CarteClientPage(),
      );
    },
    CarteCommercantRoute.name: (routeData) {
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i14.CarteCommercantPage(),
      );
    },
    PointDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PointDetailRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i15.PointDetailPage(
          key: args.key,
          point: args.point,
        ),
      );
    },
    ItineraireCommercantRoute.name: (routeData) {
      final args = routeData.argsAs<ItineraireCommercantRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i16.ItineraireCommercantPage(
          args.service,
          key: args.key,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i17.LoginPage(
          args.type,
          key: args.key,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i18.WelcomePage(key: args.key),
      );
    },
    CompanyRoute.name: (routeData) {
      final args = routeData.argsAs<CompanyRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i19.CompanyPage(
          args.trader,
          key: args.key,
        ),
      );
    },
    CompanySecondRoute.name: (routeData) {
      final args = routeData.argsAs<CompanySecondRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i20.CompanySecondPage(
          args.trader,
          args.service,
          key: args.key,
        ),
      );
    },
    PasswordClientRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordClientRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i21.PasswordClientPage(
          client: args.client,
          key: args.key,
        ),
      );
    },
    PasswordTraderRoute.name: (routeData) {
      final args = routeData.argsAs<PasswordTraderRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i22.PasswordTraderPage(
          trader: args.trader,
          service: args.service,
          key: args.key,
        ),
      );
    },
    TypeServiceRoute.name: (routeData) {
      final args = routeData.argsAs<TypeServiceRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i23.TypeServicePage(
          args.trader,
          args.service,
          key: args.key,
        ),
      );
    },
    ProfilTraderRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilTraderRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i24.ProfilTraderPage(
          args.edit,
          args.choice,
          key: args.key,
        ),
      );
    },
    ProfilServiceRoute.name: (routeData) {
      final args = routeData.argsAs<ProfilServiceRouteArgs>();
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i25.ProfilServicePage(
          args.choice,
          args.idService,
          key: args.key,
          formKey: args.formKey,
        ),
      );
    },
    ParameterClientRoute.name: (routeData) {
      final args = routeData.argsAs<ParameterClientRouteArgs>(
          orElse: () => const ParameterClientRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i26.ParameterPage(key: args.key),
      );
    },
    AideRoute.name: (routeData) {
      final args =
          routeData.argsAs<AideRouteArgs>(orElse: () => const AideRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i27.AidePage(key: args.key),
      );
    },
    AideCommercantRoute.name: (routeData) {
      final args = routeData.argsAs<AideCommercantRouteArgs>(
          orElse: () => const AideCommercantRouteArgs());
      return _i29.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i28.AideCommercantPage(key: args.key),
      );
    },
  };

  @override
  List<_i29.RouteConfig> get routes => [
        _i29.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/accueil',
          fullMatch: true,
        ),
        _i29.RouteConfig(
          HomePageRoute.name,
          path: '/client-home',
        ),
        _i29.RouteConfig(
          HomeCommercantRoute.name,
          path: '/commercant-home',
        ),
        _i29.RouteConfig(
          AmbulantDetailRoute.name,
          path: '/ambulant-detail-page',
        ),
        _i29.RouteConfig(
          AtHomeDetailRoute.name,
          path: '/at-home-detail-page',
        ),
        _i29.RouteConfig(
          RdvRoute.name,
          path: '/rdv-client',
        ),
        _i29.RouteConfig(
          RdvAllRoute.name,
          path: '/rdv-all',
        ),
        _i29.RouteConfig(
          RdvDetailRoute.name,
          path: '/rdv-detail',
        ),
        _i29.RouteConfig(
          RdvComDetailRoute.name,
          path: '/rdv-detail',
        ),
        _i29.RouteConfig(
          AddPointRoute.name,
          path: '/add-point',
        ),
        _i29.RouteConfig(
          AddPointDetailRoute.name,
          path: '/add-point-detail',
        ),
        _i29.RouteConfig(
          ProfilRoute.name,
          path: '/profil',
        ),
        _i29.RouteConfig(
          Favoris.name,
          path: '/favoris',
        ),
        _i29.RouteConfig(
          CarteClientRoute.name,
          path: '/carte-client',
        ),
        _i29.RouteConfig(
          CarteCommercantRoute.name,
          path: '/carte-commercant',
        ),
        _i29.RouteConfig(
          PointDetailRoute.name,
          path: '/point-detail',
        ),
        _i29.RouteConfig(
          ItineraireCommercantRoute.name,
          path: '/itineraire-commercant',
        ),
        _i29.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i29.RouteConfig(
          WelcomeRoute.name,
          path: '/accueil',
        ),
        _i29.RouteConfig(
          CompanyRoute.name,
          path: '/entreprise',
        ),
        _i29.RouteConfig(
          CompanySecondRoute.name,
          path: '/entreprisebis',
        ),
        _i29.RouteConfig(
          PasswordClientRoute.name,
          path: '/client_login',
        ),
        _i29.RouteConfig(
          PasswordTraderRoute.name,
          path: '/trader_login',
        ),
        _i29.RouteConfig(
          TypeServiceRoute.name,
          path: '/typeservice',
        ),
        _i29.RouteConfig(
          ProfilTraderRoute.name,
          path: '/profil_commercant',
        ),
        _i29.RouteConfig(
          ProfilServiceRoute.name,
          path: '/profil_service',
        ),
        _i29.RouteConfig(
          ParameterClientRoute.name,
          path: '/parameter_client',
        ),
        _i29.RouteConfig(
          AideRoute.name,
          path: '/about-client',
        ),
        _i29.RouteConfig(
          AideCommercantRoute.name,
          path: '/about-commercant',
        ),
      ];
}

/// generated route for
/// [_i1.HomeClientPage]
class HomePageRoute extends _i29.PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute({_i30.Key? key})
      : super(
          HomePageRoute.name,
          path: '/client-home',
          args: HomePageRouteArgs(key: key),
        );

  static const String name = 'HomePageRoute';
}

class HomePageRouteArgs {
  const HomePageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'HomePageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.HomeCommercantPage]
class HomeCommercantRoute extends _i29.PageRouteInfo<HomeCommercantRouteArgs> {
  HomeCommercantRoute({_i30.Key? key})
      : super(
          HomeCommercantRoute.name,
          path: '/commercant-home',
          args: HomeCommercantRouteArgs(key: key),
        );

  static const String name = 'HomeCommercantRoute';
}

class HomeCommercantRouteArgs {
  const HomeCommercantRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'HomeCommercantRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.AmbulantDetailPage]
class AmbulantDetailRoute extends _i29.PageRouteInfo<AmbulantDetailRouteArgs> {
  AmbulantDetailRoute({
    _i30.Key? key,
    required _i31.ServiceModel commercant,
  }) : super(
          AmbulantDetailRoute.name,
          path: '/ambulant-detail-page',
          args: AmbulantDetailRouteArgs(
            key: key,
            commercant: commercant,
          ),
        );

  static const String name = 'AmbulantDetailRoute';
}

class AmbulantDetailRouteArgs {
  const AmbulantDetailRouteArgs({
    this.key,
    required this.commercant,
  });

  final _i30.Key? key;

  final _i31.ServiceModel commercant;

  @override
  String toString() {
    return 'AmbulantDetailRouteArgs{key: $key, commercant: $commercant}';
  }
}

/// generated route for
/// [_i4.AtHomeDetailPage]
class AtHomeDetailRoute extends _i29.PageRouteInfo<AtHomeDetailRouteArgs> {
  AtHomeDetailRoute({
    _i30.Key? key,
    dynamic commercant,
  }) : super(
          AtHomeDetailRoute.name,
          path: '/at-home-detail-page',
          args: AtHomeDetailRouteArgs(
            key: key,
            commercant: commercant,
          ),
        );

  static const String name = 'AtHomeDetailRoute';
}

class AtHomeDetailRouteArgs {
  const AtHomeDetailRouteArgs({
    this.key,
    this.commercant,
  });

  final _i30.Key? key;

  final dynamic commercant;

  @override
  String toString() {
    return 'AtHomeDetailRouteArgs{key: $key, commercant: $commercant}';
  }
}

/// generated route for
/// [_i5.RdvPage]
class RdvRoute extends _i29.PageRouteInfo<RdvRouteArgs> {
  RdvRoute({
    _i30.Key? key,
    required _i31.ServiceModel commercant,
  }) : super(
          RdvRoute.name,
          path: '/rdv-client',
          args: RdvRouteArgs(
            key: key,
            commercant: commercant,
          ),
        );

  static const String name = 'RdvRoute';
}

class RdvRouteArgs {
  const RdvRouteArgs({
    this.key,
    required this.commercant,
  });

  final _i30.Key? key;

  final _i31.ServiceModel commercant;

  @override
  String toString() {
    return 'RdvRouteArgs{key: $key, commercant: $commercant}';
  }
}

/// generated route for
/// [_i6.RdvAllPage]
class RdvAllRoute extends _i29.PageRouteInfo<RdvAllRouteArgs> {
  RdvAllRoute({_i30.Key? key})
      : super(
          RdvAllRoute.name,
          path: '/rdv-all',
          args: RdvAllRouteArgs(key: key),
        );

  static const String name = 'RdvAllRoute';
}

class RdvAllRouteArgs {
  const RdvAllRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'RdvAllRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.RdvDetailPage]
class RdvDetailRoute extends _i29.PageRouteInfo<RdvDetailRouteArgs> {
  RdvDetailRoute({
    _i30.Key? key,
    required _i32.BookingModel booking,
  }) : super(
          RdvDetailRoute.name,
          path: '/rdv-detail',
          args: RdvDetailRouteArgs(
            key: key,
            booking: booking,
          ),
        );

  static const String name = 'RdvDetailRoute';
}

class RdvDetailRouteArgs {
  const RdvDetailRouteArgs({
    this.key,
    required this.booking,
  });

  final _i30.Key? key;

  final _i32.BookingModel booking;

  @override
  String toString() {
    return 'RdvDetailRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i8.RdvComDetailPage]
class RdvComDetailRoute extends _i29.PageRouteInfo<RdvComDetailRouteArgs> {
  RdvComDetailRoute({
    _i30.Key? key,
    required _i32.BookingModel booking,
  }) : super(
          RdvComDetailRoute.name,
          path: '/rdv-detail',
          args: RdvComDetailRouteArgs(
            key: key,
            booking: booking,
          ),
        );

  static const String name = 'RdvComDetailRoute';
}

class RdvComDetailRouteArgs {
  const RdvComDetailRouteArgs({
    this.key,
    required this.booking,
  });

  final _i30.Key? key;

  final _i32.BookingModel booking;

  @override
  String toString() {
    return 'RdvComDetailRouteArgs{key: $key, booking: $booking}';
  }
}

/// generated route for
/// [_i9.AddPointPage]
class AddPointRoute extends _i29.PageRouteInfo<AddPointRouteArgs> {
  AddPointRoute({
    _i30.Key? key,
    required _i31.ServiceModel service,
  }) : super(
          AddPointRoute.name,
          path: '/add-point',
          args: AddPointRouteArgs(
            key: key,
            service: service,
          ),
        );

  static const String name = 'AddPointRoute';
}

class AddPointRouteArgs {
  const AddPointRouteArgs({
    this.key,
    required this.service,
  });

  final _i30.Key? key;

  final _i31.ServiceModel service;

  @override
  String toString() {
    return 'AddPointRouteArgs{key: $key, service: $service}';
  }
}

/// generated route for
/// [_i10.AddPointDetailPage]
class AddPointDetailRoute extends _i29.PageRouteInfo<AddPointDetailRouteArgs> {
  AddPointDetailRoute({
    _i30.Key? key,
    required _i33.PointModel point,
    required _i31.ServiceModel service,
  }) : super(
          AddPointDetailRoute.name,
          path: '/add-point-detail',
          args: AddPointDetailRouteArgs(
            key: key,
            point: point,
            service: service,
          ),
        );

  static const String name = 'AddPointDetailRoute';
}

class AddPointDetailRouteArgs {
  const AddPointDetailRouteArgs({
    this.key,
    required this.point,
    required this.service,
  });

  final _i30.Key? key;

  final _i33.PointModel point;

  final _i31.ServiceModel service;

  @override
  String toString() {
    return 'AddPointDetailRouteArgs{key: $key, point: $point, service: $service}';
  }
}

/// generated route for
/// [_i11.ProfilPage]
class ProfilRoute extends _i29.PageRouteInfo<ProfilRouteArgs> {
  ProfilRoute({
    required bool edit,
    _i30.Key? key,
  }) : super(
          ProfilRoute.name,
          path: '/profil',
          args: ProfilRouteArgs(
            edit: edit,
            key: key,
          ),
        );

  static const String name = 'ProfilRoute';
}

class ProfilRouteArgs {
  const ProfilRouteArgs({
    required this.edit,
    this.key,
  });

  final bool edit;

  final _i30.Key? key;

  @override
  String toString() {
    return 'ProfilRouteArgs{edit: $edit, key: $key}';
  }
}

/// generated route for
/// [_i12.FavorisPage]
class Favoris extends _i29.PageRouteInfo<FavorisArgs> {
  Favoris({_i30.Key? key})
      : super(
          Favoris.name,
          path: '/favoris',
          args: FavorisArgs(key: key),
        );

  static const String name = 'Favoris';
}

class FavorisArgs {
  const FavorisArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'FavorisArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.CarteClientPage]
class CarteClientRoute extends _i29.PageRouteInfo<void> {
  const CarteClientRoute()
      : super(
          CarteClientRoute.name,
          path: '/carte-client',
        );

  static const String name = 'CarteClientRoute';
}

/// generated route for
/// [_i14.CarteCommercantPage]
class CarteCommercantRoute extends _i29.PageRouteInfo<void> {
  const CarteCommercantRoute()
      : super(
          CarteCommercantRoute.name,
          path: '/carte-commercant',
        );

  static const String name = 'CarteCommercantRoute';
}

/// generated route for
/// [_i15.PointDetailPage]
class PointDetailRoute extends _i29.PageRouteInfo<PointDetailRouteArgs> {
  PointDetailRoute({
    _i30.Key? key,
    required _i33.PointModel point,
  }) : super(
          PointDetailRoute.name,
          path: '/point-detail',
          args: PointDetailRouteArgs(
            key: key,
            point: point,
          ),
        );

  static const String name = 'PointDetailRoute';
}

class PointDetailRouteArgs {
  const PointDetailRouteArgs({
    this.key,
    required this.point,
  });

  final _i30.Key? key;

  final _i33.PointModel point;

  @override
  String toString() {
    return 'PointDetailRouteArgs{key: $key, point: $point}';
  }
}

/// generated route for
/// [_i16.ItineraireCommercantPage]
class ItineraireCommercantRoute
    extends _i29.PageRouteInfo<ItineraireCommercantRouteArgs> {
  ItineraireCommercantRoute({
    required _i31.ServiceModel service,
    _i30.Key? key,
  }) : super(
          ItineraireCommercantRoute.name,
          path: '/itineraire-commercant',
          args: ItineraireCommercantRouteArgs(
            service: service,
            key: key,
          ),
        );

  static const String name = 'ItineraireCommercantRoute';
}

class ItineraireCommercantRouteArgs {
  const ItineraireCommercantRouteArgs({
    required this.service,
    this.key,
  });

  final _i31.ServiceModel service;

  final _i30.Key? key;

  @override
  String toString() {
    return 'ItineraireCommercantRouteArgs{service: $service, key: $key}';
  }
}

/// generated route for
/// [_i17.LoginPage]
class LoginRoute extends _i29.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required String type,
    _i30.Key? key,
  }) : super(
          LoginRoute.name,
          path: '/login',
          args: LoginRouteArgs(
            type: type,
            key: key,
          ),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({
    required this.type,
    this.key,
  });

  final String type;

  final _i30.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{type: $type, key: $key}';
  }
}

/// generated route for
/// [_i18.WelcomePage]
class WelcomeRoute extends _i29.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i30.Key? key})
      : super(
          WelcomeRoute.name,
          path: '/accueil',
          args: WelcomeRouteArgs(key: key),
        );

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.CompanyPage]
class CompanyRoute extends _i29.PageRouteInfo<CompanyRouteArgs> {
  CompanyRoute({
    required _i34.Trader trader,
    _i30.Key? key,
  }) : super(
          CompanyRoute.name,
          path: '/entreprise',
          args: CompanyRouteArgs(
            trader: trader,
            key: key,
          ),
        );

  static const String name = 'CompanyRoute';
}

class CompanyRouteArgs {
  const CompanyRouteArgs({
    required this.trader,
    this.key,
  });

  final _i34.Trader trader;

  final _i30.Key? key;

  @override
  String toString() {
    return 'CompanyRouteArgs{trader: $trader, key: $key}';
  }
}

/// generated route for
/// [_i20.CompanySecondPage]
class CompanySecondRoute extends _i29.PageRouteInfo<CompanySecondRouteArgs> {
  CompanySecondRoute({
    required _i34.Trader trader,
    required _i31.ServiceModel service,
    _i30.Key? key,
  }) : super(
          CompanySecondRoute.name,
          path: '/entreprisebis',
          args: CompanySecondRouteArgs(
            trader: trader,
            service: service,
            key: key,
          ),
        );

  static const String name = 'CompanySecondRoute';
}

class CompanySecondRouteArgs {
  const CompanySecondRouteArgs({
    required this.trader,
    required this.service,
    this.key,
  });

  final _i34.Trader trader;

  final _i31.ServiceModel service;

  final _i30.Key? key;

  @override
  String toString() {
    return 'CompanySecondRouteArgs{trader: $trader, service: $service, key: $key}';
  }
}

/// generated route for
/// [_i21.PasswordClientPage]
class PasswordClientRoute extends _i29.PageRouteInfo<PasswordClientRouteArgs> {
  PasswordClientRoute({
    required _i35.Client client,
    _i30.Key? key,
  }) : super(
          PasswordClientRoute.name,
          path: '/client_login',
          args: PasswordClientRouteArgs(
            client: client,
            key: key,
          ),
        );

  static const String name = 'PasswordClientRoute';
}

class PasswordClientRouteArgs {
  const PasswordClientRouteArgs({
    required this.client,
    this.key,
  });

  final _i35.Client client;

  final _i30.Key? key;

  @override
  String toString() {
    return 'PasswordClientRouteArgs{client: $client, key: $key}';
  }
}

/// generated route for
/// [_i22.PasswordTraderPage]
class PasswordTraderRoute extends _i29.PageRouteInfo<PasswordTraderRouteArgs> {
  PasswordTraderRoute({
    required _i34.Trader trader,
    required _i31.ServiceModel service,
    _i30.Key? key,
  }) : super(
          PasswordTraderRoute.name,
          path: '/trader_login',
          args: PasswordTraderRouteArgs(
            trader: trader,
            service: service,
            key: key,
          ),
        );

  static const String name = 'PasswordTraderRoute';
}

class PasswordTraderRouteArgs {
  const PasswordTraderRouteArgs({
    required this.trader,
    required this.service,
    this.key,
  });

  final _i34.Trader trader;

  final _i31.ServiceModel service;

  final _i30.Key? key;

  @override
  String toString() {
    return 'PasswordTraderRouteArgs{trader: $trader, service: $service, key: $key}';
  }
}

/// generated route for
/// [_i23.TypeServicePage]
class TypeServiceRoute extends _i29.PageRouteInfo<TypeServiceRouteArgs> {
  TypeServiceRoute({
    required _i34.Trader trader,
    required _i31.ServiceModel service,
    _i30.Key? key,
  }) : super(
          TypeServiceRoute.name,
          path: '/typeservice',
          args: TypeServiceRouteArgs(
            trader: trader,
            service: service,
            key: key,
          ),
        );

  static const String name = 'TypeServiceRoute';
}

class TypeServiceRouteArgs {
  const TypeServiceRouteArgs({
    required this.trader,
    required this.service,
    this.key,
  });

  final _i34.Trader trader;

  final _i31.ServiceModel service;

  final _i30.Key? key;

  @override
  String toString() {
    return 'TypeServiceRouteArgs{trader: $trader, service: $service, key: $key}';
  }
}

/// generated route for
/// [_i24.ProfilTraderPage]
class ProfilTraderRoute extends _i29.PageRouteInfo<ProfilTraderRouteArgs> {
  ProfilTraderRoute({
    required bool edit,
    required String choice,
    _i30.Key? key,
  }) : super(
          ProfilTraderRoute.name,
          path: '/profil_commercant',
          args: ProfilTraderRouteArgs(
            edit: edit,
            choice: choice,
            key: key,
          ),
        );

  static const String name = 'ProfilTraderRoute';
}

class ProfilTraderRouteArgs {
  const ProfilTraderRouteArgs({
    required this.edit,
    required this.choice,
    this.key,
  });

  final bool edit;

  final String choice;

  final _i30.Key? key;

  @override
  String toString() {
    return 'ProfilTraderRouteArgs{edit: $edit, choice: $choice, key: $key}';
  }
}

/// generated route for
/// [_i25.ProfilServicePage]
class ProfilServiceRoute extends _i29.PageRouteInfo<ProfilServiceRouteArgs> {
  ProfilServiceRoute({
    required String choice,
    required String idService,
    _i30.Key? key,
    required _i30.GlobalKey<_i30.ScaffoldState> formKey,
  }) : super(
          ProfilServiceRoute.name,
          path: '/profil_service',
          args: ProfilServiceRouteArgs(
            choice: choice,
            idService: idService,
            key: key,
            formKey: formKey,
          ),
        );

  static const String name = 'ProfilServiceRoute';
}

class ProfilServiceRouteArgs {
  const ProfilServiceRouteArgs({
    required this.choice,
    required this.idService,
    this.key,
    required this.formKey,
  });

  final String choice;

  final String idService;

  final _i30.Key? key;

  final _i30.GlobalKey<_i30.ScaffoldState> formKey;

  @override
  String toString() {
    return 'ProfilServiceRouteArgs{choice: $choice, idService: $idService, key: $key, formKey: $formKey}';
  }
}

/// generated route for
/// [_i26.ParameterPage]
class ParameterClientRoute
    extends _i29.PageRouteInfo<ParameterClientRouteArgs> {
  ParameterClientRoute({_i30.Key? key})
      : super(
          ParameterClientRoute.name,
          path: '/parameter_client',
          args: ParameterClientRouteArgs(key: key),
        );

  static const String name = 'ParameterClientRoute';
}

class ParameterClientRouteArgs {
  const ParameterClientRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'ParameterClientRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i27.AidePage]
class AideRoute extends _i29.PageRouteInfo<AideRouteArgs> {
  AideRoute({_i30.Key? key})
      : super(
          AideRoute.name,
          path: '/about-client',
          args: AideRouteArgs(key: key),
        );

  static const String name = 'AideRoute';
}

class AideRouteArgs {
  const AideRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'AideRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i28.AideCommercantPage]
class AideCommercantRoute extends _i29.PageRouteInfo<AideCommercantRouteArgs> {
  AideCommercantRoute({_i30.Key? key})
      : super(
          AideCommercantRoute.name,
          path: '/about-commercant',
          args: AideCommercantRouteArgs(key: key),
        );

  static const String name = 'AideCommercantRoute';
}

class AideCommercantRouteArgs {
  const AideCommercantRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'AideCommercantRouteArgs{key: $key}';
  }
}
