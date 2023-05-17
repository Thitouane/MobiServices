
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mobideliv/features/client/carte/data/cubit/address/address_cubit.dart';
import 'package:mobideliv/features/client/carte/presentation/popup_detail.dart';
import 'package:mobideliv/features/client/carte/presentation/popup_it_detail.dart';

import '../../../../core/presentation/client/app_bar.dart';
import '../../../../core/presentation/client/navbar.dart';
import '../../../commercant/carte/data/cubit/point/point_bloc.dart';
import '../../../commercant/carte/data/cubit/point/point_event.dart';
import '../../../commercant/carte/data/cubit/point/point_state.dart';
import '../../../commercant/carte/data/point_repo.dart';
import '../../../commercant/carte/domain/entity/point_arret.dart';
import '../../accueil/domain/entity/service_model.dart';
import '../data/cubit/coordonate/coordonate_cubit.dart';
import '../data/cubit/location/location_cubit.dart';

class ItineraireCommercantPage extends StatefulWidget {
  final ServiceModel service;

  const ItineraireCommercantPage(this.service, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ItinerairePageState();
  }
}

class _ItinerairePageState extends State<ItineraireCommercantPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PopupController _popupLayerController = PopupController();
  late MapController _mapController;
  late List<Marker> _markers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use `MapController` as needed
      _mapController = MapController();
    });
    _markers = [];
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
            )..add(GetComData(widget.service.id!))
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
                        center: LatLng(50.609954, 3.141405),
                        zoom: 9.2,
                        onTap: (position, latlng) {
                          _popupLayerController.hideAllPopups();
                        },
                        interactiveFlags: InteractiveFlag.drag | InteractiveFlag.pinchZoom
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
                                  .rotationAlignmentFor(AnchorAlign.top),
                              popupBuilder: (BuildContext context, Marker marker) {
                                for (PointModel point in data) {
                                  if (point.point.longitude ==
                                      marker.point.longitude &&
                                      point.point.latitude ==
                                          marker.point.latitude) {
                                    return PopupItDetail(marker, point);
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