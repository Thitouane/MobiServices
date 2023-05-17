import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:mobideliv/features/commercant/carte/domain/entity/point_arret.dart';

class PopupItDetail extends StatefulWidget {
  final Marker marker;
  final PointModel service;

  const PopupItDetail(this.marker, this.service, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupDetailState();
}

class _PopupDetailState extends State<PopupItDetail> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(Icons.local_shipping),
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
              widget.service.adresse,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Text(
              widget.service.arrive,
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