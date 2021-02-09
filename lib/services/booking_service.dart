import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingService {
  BookingService._privateConstructor();
  static final BookingService instance = BookingService._privateConstructor();

  static var now = DateTime.now();
  static var year = DateTime.now().year;
  static var month = DateFormat.MMMM().format(now);
  static var week = DateTime.now().weekday;

  storeBookingData(
    BuildContext context,
    String ticketNumber,
    String bookingDate,
    String busCompanyName,
    String clientName,
    String clientPhone,
    String busName,
    String tripRoute,
    String seatNumber,
    String busPhone,
  ) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var uid = user.uid;
    var phoneNumber = user.phoneNumber;
    final databaseReference = Firestore.instance;

    await databaseReference
        .collection("UserData/$uid/MyReservations")
        .document()
        .setData({
      'ticket_number': ticketNumber,
      'booking_date': bookingDate,
      'bus_company': busCompanyName,
      'first_name': clientName,
      'phoneNumber': phoneNumber,
      'bus_name': busName,
      'trip_route': tripRoute,
      'seat_number': seatNumber,
      'bus_phone': busPhone,
    });

    await databaseReference
        .collection("Reservations")
        .document(year.toString())
        .collection(month)
        .document(week.toString())
        .collection('Sold Tickets')
        .document()
        .setData({
      'ticket_number': ticketNumber,
      'booking_date': bookingDate,
      'bus_company': busCompanyName,
      'first_name': clientName,
      'phoneNumber': phoneNumber,
      'bus_name': busName,
      'trip_route': tripRoute,
      'seat_number': seatNumber,
      'bus_phone': busPhone,
    });
  }
}
