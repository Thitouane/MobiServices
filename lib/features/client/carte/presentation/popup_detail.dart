import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:mobideliv/core/router/router.gr.dart';

import '../../accueil/domain/entity/service_model.dart';

class PopupDetail extends StatefulWidget {
  final Marker marker;
  final ServiceModel service;

  const PopupDetail(this.marker, this.service, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupDetailState();
}

class _PopupDetailState extends State<PopupDetail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(AmbulantDetailRoute(commercant: widget.service));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                widget.service.at_home
                  ? Icons.home
                  : Icons.local_shipping
              ),
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
              widget.service.name,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Text(
              widget.service.adresse!,
              style: const TextStyle(
                  fontSize: 10.0
              ),
            )
          ],
        ),
      ),
    );
  }
}