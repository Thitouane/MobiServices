import 'package:auto_route/annotations.dart';
import 'package:mobideliv/features/authentification/authentification_page.dart';
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_client_page.dart';
import 'package:mobideliv/features/authentification/presentation/widget/formulaire_company.dart';
import 'package:mobideliv/features/client/about/about_page.dart';
import 'package:mobideliv/features/client/accueil/presentation/widgets/ambulant_detail_page.dart';
import 'package:mobideliv/features/client/accueil/presentation/widgets/at_home_detail_page.dart';
import 'package:mobideliv/features/client/carte/presentation/add_point_page.dart';
import 'package:mobideliv/features/client/carte/presentation/carte_itineraire.dart';
import 'package:mobideliv/features/client/favoris/presentation/favoris_page.dart';
import 'package:mobideliv/features/client/global_widgets/presentation/global_widgets.dart';
import 'package:mobideliv/features/client/parameter/parameter_client_page.dart';
import 'package:mobideliv/features/client/profil/presentation/profil_page.dart';
import 'package:mobideliv/features/client/rdv/presentation/rdv.dart';
import 'package:mobideliv/features/client/rdv/presentation/rdv_detail.dart';
import 'package:mobideliv/features/commercant/about/about_page.dart';
import 'package:mobideliv/features/commercant/carte/presentation/carte_page.dart';
import 'package:mobideliv/features/client/accueil/presentation/home_page.dart';
import 'package:mobideliv/features/client/carte/presentation/carte_page.dart';
import 'package:mobideliv/features/commercant/carte/presentation/point_detail_page.dart';
import '../../features/authentification/presentation/widget/formulaire_company_page_2.dart';
import '../../features/authentification/presentation/widget/formulaire_password_client.dart';
import '../../features/authentification/presentation/widget/formulaire_password_trader.dart';
import '../../features/authentification/presentation/widget/type_service_page.dart';
import '../../features/client/carte/presentation/add_point_detail_page.dart';
import '../../features/client/rdv/presentation/rdv_all.dart';
import '../../features/commercant/accueil/presentation/home_page.dart';
import '../../features/commercant/accueil/presentation/rdv_detail.dart';
import '../../features/commercant/profil/profil_trader_page.dart';
import '../../features/commercant/profil/widget/profil_service_page.dart';

@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(path: "/client-home", page: HomeClientPage, name: "HomePageRoute"),
  AutoRoute(path: "/commercant-home", page: HomeCommercantPage, name: "HomeCommercantRoute"),
  AutoRoute(page: AmbulantDetailPage),
  AutoRoute(page: AtHomeDetailPage),

  AutoRoute(page: RdvPage, path: '/rdv-client',),
  AutoRoute(page: RdvAllPage, path: '/rdv-all',),
  AutoRoute(page: RdvDetailPage, path: '/rdv-detail',),
  AutoRoute(page: RdvComDetailPage, path: '/rdv-detail',),

  AutoRoute(page: AddPointPage, path: '/add-point',),
  AutoRoute(page: AddPointDetailPage, path: '/add-point-detail',),

  AutoRoute(path: "/profil", page: ProfilPage, name: "ProfilRoute"),
  AutoRoute(path: "/favoris", page: FavorisPage, name: "Favoris"),

  AutoRoute(path: "/carte-client", page: CarteClientPage),
  AutoRoute(path: "/carte-commercant", page: CarteCommercantPage),
  AutoRoute(path: "/point-detail", page: PointDetailPage),
  AutoRoute(path: '/itineraire-commercant', page: ItineraireCommercantPage),

  AutoRoute(path: "/login", page: LoginPage),
  AutoRoute(path: "/accueil", page: WelcomePage, initial: true),
  AutoRoute(path: "/entreprise", page: CompanyPage),
  AutoRoute(path: "/entreprisebis", page: CompanySecondPage),
  AutoRoute(path: "/client_login", page: PasswordClientPage),
  AutoRoute(path: "/trader_login", page: PasswordTraderPage),
  AutoRoute(path: "/typeservice", page: TypeServicePage),

  AutoRoute(path: "/profil_commercant", page: ProfilTraderPage),
  AutoRoute(path: "/profil_service", page: ProfilServicePage),

  AutoRoute(path: "/parameter_client", page: ParameterPage, name: "ParameterClientRoute"),
  AutoRoute(path:'/about-client', page: AidePage),
  AutoRoute(path:'/about-commercant', page: AideCommercantPage),
])
class $AppRouter {}
