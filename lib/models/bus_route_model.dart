import 'package:flutter/material.dart';

class BusRouteModel {
  var data;
  @required
  final String imagePath,
      busName,
      busCode,
      route,
      travelDate,
      travelTime,
      busInfo,
      phone,
      busFareOld,
      busFare;

  Map seat,
      seat2,
      seat3,
      seat4,
      seat5,
      seat6,
      seat7,
      seat8,
      seat9,
      seat10,
      seat11,
      seat12,
      seat13,
      seat14,
      seat15,
      seat16,
      seat17,
      seat18,
      seat19,
      seat20,
      seat21,
      seat22,
      seat23,
      seat24,
      seat25,
      seat26,
      seat27,
      seat28,
      seat29,
      seat30,
      seat31,
      seat32,
      seat33,
      seat34,
      seat35,
      seat36;
  List gallery, destination;
  BusRouteModel(
      {this.seat2,
      this.seat3,
      this.seat4,
      this.seat5,
      this.seat6,
      this.seat7,
      this.seat8,
      this.seat9,
      this.seat10,
      this.seat11,
      this.seat12,
      this.seat13,
      this.seat14,
      this.seat15,
      this.seat16,
      this.seat17,
      this.seat18,
      this.seat19,
      this.seat20,
      this.seat21,
      this.seat22,
      this.seat23,
      this.seat24,
      this.seat25,
      this.seat26,
      this.seat27,
      this.seat28,
      this.seat29,
      this.seat30,
      this.seat31,
      this.seat32,
      this.seat33,
      this.seat34,
      this.seat35,
      this.seat36,
      this.route,
      this.data,
      this.travelDate,
      this.destination,
      this.travelTime,
      this.imagePath,
      this.busName,
      this.busCode,
      this.busInfo,
      this.phone,
      this.busFare,
      this.busFareOld,
      this.gallery,
      this.seat});
}


class Busseat {
  String seatId;
  bool seattatus;

  Busseat();

  Busseat.fromMap(Map<String, dynamic> data) {
    seatId = data['id'];
    seattatus = data['status'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': seatId,
      'status': seattatus,
    };
  }
}
