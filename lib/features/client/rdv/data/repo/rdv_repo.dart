import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobideliv/features/authentification/presentation/data/data_sources/auth_repository.dart';
import 'package:mobideliv/features/client/accueil/data/repository/service_repo.dart';
import 'package:mobideliv/features/client/accueil/domain/entity/service_model.dart';

import 'package:mobideliv/features/client/profil/presentation/domain/entity/client_entity.dart';

import '../../../../commercant/profil/domain/entity/trader_entity.dart';
import '../../domain/entity/booking.dart';

class RdvRepository {
  CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
  final clients = FirebaseFirestore.instance.collection('client');

  Future<dynamic> addBooking({required BookingService newBooking}) async {
    try {
      await bookings.add(newBooking.toJson());
      return "done";
    }
    catch (e) {
      return Future.error("error");
    }
  }

  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return bookings
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots();
  }

  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    List<DateTimeRange> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }


  Future<List<BookingService>> getBooking(String id) async {
    List<BookingService> booking = [];
    try {
      final books = await bookings
          .where("serviceId", isEqualTo: id)
          .get();

      return booking;
    }
    catch (e) {
      return Future.error("error");
    }
  }

  Future<List<BookingModel>> getAll() async {
    List<BookingModel> booking = [];
    try {
      String id = (await FirestoreAuth().getCurrentUserId())!;
      final books = await bookings
          .where("userId", isEqualTo: id)
          .snapshots();

      books.forEach((element) {
       element.docs.forEach((element) async {
          BookingService boo = BookingService.fromJson(element.data() as Map<String, dynamic>);
          ServiceModel ser = await ServiceRepository().getService(boo.serviceId!);
          Trader com = await FirestoreAuth().getTrader(boo.serviceId!);
          booking.add(BookingModel(
              service: ser,
              commercant: com,
              booking: boo
          ));
        });
      });

      return booking;
    }
    catch (e) {
      return Future.error("error");
    }
  }

  Future<List<BookingModel>> getComAll() async {
    List<BookingModel> booking = [];
    try {
      String id = (await FirestoreAuth().getCurrentUserId())!;
      final books = await bookings
          .where("serviceId", isEqualTo: id)
          .snapshots();

      books.forEach((element) {
        element.docs.forEach((element) async {
          BookingService boo = BookingService.fromJson(element.data() as Map<String, dynamic>);
          ServiceModel ser = await ServiceRepository().getService(boo.serviceId!);
          Trader com = await FirestoreAuth().getTrader(boo.serviceId!);
          booking.add(BookingModel(
              service: ser,
              commercant: com,
              booking: boo
          ));
        });
      });

      return booking;
    }
    catch (e) {
      return Future.error("error");
    }
  }

  Future<BookingService> deleteOne(BookingService service) async {
    try {
      final books = await bookings
          .where("userId", isEqualTo: service.userId)
          .where("bookingStart", isEqualTo: service.bookingStart.toIso8601String())
          .where("bookingEnd", isEqualTo: service.bookingEnd.toIso8601String())
          .where("serviceId", isEqualTo: service.serviceId)
          .get().then( (querySnapshot) {
            querySnapshot.docs.forEach((element) async {
              await bookings.doc(element.id).delete();
              await Future.delayed(const Duration(seconds: 5));
            });
          });
      return service;
    } catch (e) {
      return Future.error("error");
    }
  }

  Future<String> getClientName(String identifiant) async {
    String data = "";
    try {
      final client = await clients
          .where('id', isEqualTo: identifiant)
          .get();

      client.docs.forEach((element) {
        data += element.data()['firstname'];
        data += " ";
        data += element.data()['name'];
      });
      return data;
    }
    catch (e){
      return Future.error(e.toString());
    }
  }
}
