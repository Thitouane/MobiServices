import 'package:auto_route/auto_route.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:location/location.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';

import 'package:mobideliv/core/presentation/client/navbar.dart';
import 'package:mobideliv/core/utils/utils.dart';

import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:mobideliv/features/client/carte/data/cubit/address/address_cubit.dart';
import 'package:mobideliv/features/client/carte/presentation/popup_detail.dart';

import '../../../../core/router/router.gr.dart';
import '../../accueil/data/repository/service_repo.dart';
import '../../accueil/domain/entity/service_model.dart';
import '../data/cubit/location/location_cubit.dart';
import '../data/cubit/service/service_bloc.dart';
import '../data/cubit/service/service_event.dart';
import '../data/cubit/service/service_state.dart';


class CarteClientPage extends StatefulWidget {
  const CarteClientPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartePageState();
  }
}

class _CartePageState extends State<CarteClientPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PopupController _popupLayerController = PopupController();
  late MapController _mapController;
  late List<Marker> _markers;
  late List<ServiceModel> _services;
  late List<ServiceModel> _service_data;
  late bool _searched;
  late LatLng location;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use `MapController` as needed
      _mapController = MapController();
    });
    _markers = [];
    _services = [];
    _searched = false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
          LocationCubit()..getCurrentLocation()
        ),
        BlocProvider(create: (context) =>
          ServiceBloc(serviceRepository: ServiceRepository())..add(GetData())
        ),
      ],
        child: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar: CustomAppBar(
              scaffoldKey: _scaffoldKey,
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [_getBody(context), _buildFloatingSearchBar(context)],
            ),
            /* TODO
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // TODO
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.local_shipping),
            )*/));
  }

  Widget _getBody(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
      if (state is ServiceLoaded) {
        List<ServiceModel> data = state.mydata;
        _markers = data
            .map((service) => Marker(
                point:
                    LatLng(service.latLng.latitude, service.latLng.longitude),
                width: 60,
                height: 60,
                builder: (context) {
                  if (service.at_home) {
                    return const Icon(
                      Icons.location_on_rounded,
                      size: 60,
                      color: Colors.blueAccent,
                    );
                  } else {
                    return const Icon(
                      Icons.location_on_rounded,
                      size: 60,
                      color: Colors.orangeAccent,
                    );
                  }
                }))
            .toList();
        return BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
          if (state is LocationLoaded) {
            double? lat = state.content?.latitude;
            double? lng = state.content?.longitude;
            location = LatLng(lat!, lng!);
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                  center: location,
                  zoom: 9.2,
                  onTap: (_, __) {
                    _popupLayerController.hideAllPopups();
                  },
                  interactiveFlags: InteractiveFlag.drag | InteractiveFlag
                      .pinchZoom
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: _markers),
                PopupMarkerLayerWidget(
                    options: PopupMarkerLayerOptions(
                        popupController: _popupLayerController,
                        markers: _markers,
                        markerRotateAlignment:
                        PopupMarkerLayerOptions.rotationAlignmentFor(
                            AnchorAlign.top),
                        popupBuilder: (BuildContext context, Marker marker) {
                          for (ServiceModel service in data) {
                            if (service.latLng.longitude ==
                                marker.point.longitude &&
                                service.latLng.latitude ==
                                    marker.point.latitude) {
                              return PopupDetail(marker, service);
                            }
                          }
                          return const Text("error");
                        }))
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
      } else if (state is ServiceError) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget _buildFloatingSearchBar(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
        return FloatingSearchBar(
            hint: 'Rechercher',
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            automaticallyImplyDrawerHamburger: false,
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0.0,
            isScrollControlled: true,
            width: isPortrait ? 600 : 500,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            debounceDelay: const Duration(milliseconds: 500),
            onQueryChanged: (query) {
              final suggestions = _service_data.where((service) {
                return service.name.toLowerCase().contains(query.toLowerCase());
              }).toList();
              setState(() {
                if(suggestions.isNotEmpty) {
                  _searched = true;
                } else {
                  _searched = false;
                }
                _services = suggestions;
              });
            },
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction.searchToClear(
                showIfClosed: true,
              ),
            ],
            builder: (context, transition) {
              return BlocBuilder<ServiceBloc, ServiceState>(
                  builder: (context, state) {
                    if (state is ServiceLoaded) {
                      _service_data = state.mydata;
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                              color: Colors.white,
                              elevation: 4.0,
                              child: ListView.builder(
                                  itemCount: _searched
                                      ? _services.length
                                      : state.mydata.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(
                                            _searched
                                            ? _services[index].name
                                            : state.mydata[index].name
                                        ),
                                        onTap: () {
                                          AutoRouter.of(context).push(
                                            AmbulantDetailRoute(
                                                commercant: _searched
                                                    ? _services[index]
                                                    : state.mydata[index]
                                            )
                                          );
                                        },
                                      ),
                                    );
                                  }
                              )
                          )
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
            }
        );
      }
    );
  }
}