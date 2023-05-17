import 'package:booking_calendar/booking_calendar.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';
import 'package:mobideliv/features/commercant/profil/domain/entity/trader_entity.dart';

class BookingModel {
  final ServiceModel? service;
  final Trader? commercant;
  final BookingService? booking;

  BookingModel({
    this.service,
    this.commercant,
    this.booking
  });
}