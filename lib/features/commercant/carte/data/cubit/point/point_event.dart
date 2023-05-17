import 'package:equatable/equatable.dart';
import 'package:mobideliv/features/commercant/carte/domain/entity/point_arret.dart';

import '../../../../../client/accueil/domain/entity/service_model.dart';

abstract class PointEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMyData extends PointEvent {
  GetMyData();
}

class UpdateMyData extends PointEvent {
  final PointModel point;

  UpdateMyData(this.point);
}

class AddData extends PointEvent {
  final PointModel point;
  final ServiceModel service;

  AddData(this.point, this.service);
}


class GetComData extends PointEvent {
  final String mail;

  GetComData(this.mail);
}

class DelPoint extends PointEvent {
  final PointModel point;

  DelPoint(this.point);
}