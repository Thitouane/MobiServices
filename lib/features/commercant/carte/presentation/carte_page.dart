import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:mobideliv/core/presentation/client/app_bar.dart';

import 'package:mobideliv/core/presentation/commercant/navbar.dart';
import 'package:mobideliv/core/utils/utils.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:mobideliv/features/commercant/carte/data/cubit/point/point_event.dart';
import 'package:mobideliv/features/commercant/carte/presentation/popup_detail.dart';
import 'package:mobideliv/features/commercant/carte/presentation/point_detail_page.dart';

import '../../../../core/router/router.gr.dart';
import '../../../authentification/presentation/data/data_sources/auth_repository.dart';
import '../../../client/accueil/domain/entity/service_model.dart';
import '../../../client/carte/data/cubit/address/address_cubit.dart';
import '../../../client/carte/data/cubit/coordonate/coordonate_cubit.dart';
import '../../../client/carte/data/cubit/location/location_cubit.dart';
import '../data/cubit/point/point_bloc.dart';
import '../data/cubit/point/point_state.dart';
import '../data/point_repo.dart';
import '../domain/entity/point_arret.dart';

class CarteCommercantPage extends StatefulWidget {
  const CarteCommercantPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartePageState();
  }
}

class _CartePageState extends State<CarteCommercantPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PopupController _popupLayerController = PopupController();
  late MapController _mapController;
  late List<Marker> _markers;
  late List<ServiceModel> _searchedQueries;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use `MapController` as needed
      _mapController = MapController();
    });
    _markers = [];
    _searchedQueries = [];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
          LocationCubit()..getCurrentLocation()
        ),
        BlocProvider(create: (context) =>
          PointBloc(
              pointRepository: PointRepository()
          )..add(GetMyData())
        ),
        BlocProvider(
            create: (context) => CoordonateCubit()
        ),
      ],
      child: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
            body: Stack(
              fit: StackFit.expand,
              children: [
                _getBody(context)
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // TODO : attention id
                AutoRouter.of(context).push(PointDetailRoute(point: PointModel(
                  adresse: "",
                  arret: "",
                  arrive: "",
                  commercant: "",
                  point: const GeoPoint(0,0),
                  service: "",
                  name: ""
                )));
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(Icons.add),
            )
        )
    );
  }

  Widget _getBody(BuildContext context) {
    return BlocBuilder<PointBloc, PointState>(
        builder: (context, state) {
          if (state is PointLoaded) {
            List<PointModel> data = state.point;
            _markers = data.map((point) =>
                Marker(
                    point: LatLng(
                        point.point.latitude, point.point.longitude),
                    width: 60,
                    height: 60,
                    builder: (context) {
                      /* TODO : if (point.isDepart) { } */
                      return const Icon(
                        Icons.location_on_rounded,
                        size: 60,
                        color: Colors.orangeAccent,
                      );
                    }
                )).toList();
            return BlocBuilder<CoordonateCubit, CoordonateState>(
                builder: (context, state) {
                  return BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoaded) {
                          double? lat = state.content?.latitude;
                          double? lng = state.content?.longitude;
                          LatLng location = LatLng(lat!, lng!);
                          return FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                                center: location,
                                zoom: 9.2,
                                onTap: (position, latlng) {
                                  _popupLayerController.hideAllPopups();
                                },
                                interactiveFlags: InteractiveFlag
                                    .drag | InteractiveFlag.pinchZoom
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                  markers: _markers
                              ),
                              PopupMarkerLayerWidget(
                                  options: PopupMarkerLayerOptions(
                                      popupController: _popupLayerController,
                                      markers: _markers,
                                      markerRotateAlignment: PopupMarkerLayerOptions
                                          .rotationAlignmentFor(
                                          AnchorAlign
                                              .top),
                                      popupBuilder: (
                                          BuildContext context,
                                          Marker marker) {
                                        for (PointModel point in data) {
                                          if (point.point.longitude ==
                                              marker.point.longitude &&
                                              point.point.latitude ==
                                                  marker.point
                                                      .latitude) {
                                            return CommercantDetail(
                                                marker, point);
                                          }
                                        }
                                        return const Text("error");
                                      }
                                  )
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                  });
                }
                );
          } else if (state is PointError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}