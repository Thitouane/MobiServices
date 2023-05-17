import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:mobideliv/core/router/router.gr.dart';
import 'package:mobideliv/features/commercant/carte/presentation/point_detail_page.dart';

import '../../../client/accueil/domain/entity/service_model.dart';
import '../domain/entity/point_arret.dart';

class CommercantDetail extends StatefulWidget {
  final Marker marker;
  final PointModel point;

  const CommercantDetail(this.marker, this.point, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupDetailState();
}

class _PopupDetailState extends State<CommercantDetail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(PointDetailRoute(point: widget.point));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(Icons.location_on_rounded),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }
  
  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              widget.point.adresse,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Row(
              children: [
                const Icon(
                  Icons.access_time_outlined,
                  size: 10.0,
                ),
                Text(
                  widget.point.arrive,
                  style: const TextStyle(
                      fontSize: 10.0
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 10.0,
                ),
                Text(
                  widget.point.arret,
                  style: const TextStyle(
                      fontSize: 10.0
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}