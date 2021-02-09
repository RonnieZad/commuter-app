import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commuter/models/bus_route_model.dart';
import 'package:commuter/models/user_data_model.dart';
import 'package:commuter/utils/customToast.dart';
import 'package:flutter/material.dart';

class DatabaseClient {
  final Firestore _firestore = Firestore.instance;
  final String busRoutesLink = '/baserepo/busRoutes/listing';
  final String userAccount = '/baserepo/busRoutes/listing';

  Stream<List<BusRouteModel>> get getbuses {
    return _firestore.collection(busRoutesLink).snapshots().map(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map(
                (DocumentSnapshot doc) => BusRouteModel(
                  imagePath: doc.data['bus_cover_image'] ?? '',
                  busName: doc.data['bus_name'] ?? '',
                  busCode: doc.data['bus_code'] ?? '',
                  data: querySnapshot,
                  busInfo: doc.data['bus_info'] ?? '',
                  route: doc.data['route'] ?? '',
                  destination: List.from(doc.data['destination']),
                  phone: doc.data['phone'] ?? '',
                  travelDate: doc.data['tarvel_date'] ?? '',
                  travelTime: doc.data['travel_time'] ?? '',
                  busFare: doc.data['bus_fare'] ?? '',
                  busFareOld: doc.data['bus_fare_old'] ?? '',
                  seat: Map.from(doc.data['seat1']),
                  seat2: Map.from(doc.data['seat2']),
                  seat3: Map.from(doc.data['seat3']),
                  seat4: Map.from(doc.data['seat4']),
                  seat5: Map.from(doc.data['seat5']),
                  seat6: Map.from(doc.data['seat6']),
                  seat7: Map.from(doc.data['seat7']),
                  seat8: Map.from(doc.data['seat8']),
                  seat9: Map.from(doc.data['seat9']),
                  seat10: Map.from(doc.data['seat10']),
                  seat11: Map.from(doc.data['seat11']),
                  seat12: Map.from(doc.data['seat12']),
                  seat13: Map.from(doc.data['seat13']),
                  seat14: Map.from(doc.data['seat14']),
                  seat15: Map.from(doc.data['seat15']),
                  seat16: Map.from(doc.data['seat16']),
                  seat17: Map.from(doc.data['seat17']),
                  seat18: Map.from(doc.data['seat18']),
                  seat19: Map.from(doc.data['seat19']),
                  seat20: Map.from(doc.data['seat20']),
                  seat21: Map.from(doc.data['seat21']),
                  seat22: Map.from(doc.data['seat22']),
                  seat23: Map.from(doc.data['seat23']),
                  seat24: Map.from(doc.data['seat24']),
                  seat25: Map.from(doc.data['seat25']),
                  seat26: Map.from(doc.data['seat26']),
                  seat27: Map.from(doc.data['seat27']),
                  seat28: Map.from(doc.data['seat28']),
                  seat29: Map.from(doc.data['seat29']),
                  seat30: Map.from(doc.data['seat30']),
                  seat31: Map.from(doc.data['seat31']),
                  seat32: Map.from(doc.data['seat32']),
                  seat33: Map.from(doc.data['seat33']),
                  seat34: Map.from(doc.data['seat34']),
                  seat35: Map.from(doc.data['seat35']),
                  seat36: Map.from(doc.data['seat36']),
                  gallery: List.from(doc.data['bus_slider_image']),
                ),
              )
              .toList(),
        );
  }

  Stream<List<UserDataModel>> get getUserData {
    return _firestore.collection(userAccount).snapshots().map(
          (QuerySnapshot querySnapshot) => querySnapshot.documents
              .map(
                (DocumentSnapshot doc) => UserDataModel(
                  name: doc.data['accountHolder'] ?? '',
                  phoneNumber: doc.data['phoneNumber'] ?? '',
                  address: doc.data['address'] ?? '',
                ),
              )
              .toList(),
        );
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  void updateSeatAvailability(
      int index, var snapshot, var newData, int location, String clientID) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await Firestore.instance
            .runTransaction((Transaction myTransaction) async {
          await myTransaction.update(
            snapshot.documents[index].reference,
            {
              'seat$location': {"id": "$location", "status": newData, "takenBy" : clientID}
            },
          );
          CustomToast.instance.showToast(
              'Your seat has been reserved for you, cheers', Colors.green, Colors.white);
        });
      }
    } on SocketException catch (_) {
      CustomToast.instance.showToast(
          'Cannot reserve seat now, please check your internet',
          Colors.red,
          Colors.white);
    }
  }
}
