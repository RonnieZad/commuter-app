import 'package:commuter/constants/strings.dart';
import 'package:commuter/screens/my_tickets.dart';
import 'package:commuter/services/booking_service.dart';
import 'package:commuter/services/calendar_service.dart';
import 'package:commuter/services/database_service.dart';
import 'package:commuter/services/payment_gateway.dart';
import 'package:commuter/services/weather_service.dart';
import 'package:commuter/utils/customToast.dart';
import 'package:commuter/utils/shared_prefs.dart';
import 'package:commuter/utils/sheetHelper.dart';
import 'package:commuter/widgets/accountSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingSheet extends StatefulWidget {
  BookingSheet._privateConstructor();
  static final BookingSheet instance = BookingSheet._privateConstructor();

  String seatNumber = '';
  String destination, tripRoute, busPhone;
  String departTime;
  String busFare;
  String busName;
  int index;

  var data;
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

  BookingSheet({
    this.index,
    this.destination,
    this.busFare,
    this.busPhone,
    this.data,
    this.tripRoute,
    this.busName,
    this.departTime,
    this.seat,
    this.seat2,
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
    Key key,
  }) : super(key: key);

  @override
  _BookingSheet createState() => _BookingSheet();
}

class _BookingSheet extends State<BookingSheet> {
  bool isDialogPopped = false;
  PageController pageController = PageController();
  String userEmail;
  static var now = new DateTime.now();
  var timeNow = DateFormat.yMMMd().format(now);

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            userEmail = prefValue.getString('email') ?? '';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var ticketNumber = randomNumeric(4);
    return DraggableScrollableSheet(
      minChildSize: 0.50,
      initialChildSize: 1,
      builder: (context, controller) {
        return CupertinoBottomSheet(
          child: NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification notification) {
              if (!isDialogPopped &&
                  notification.extent == notification.minExtent) {
                isDialogPopped = true;
                Navigator.of(context).pop();
              }
              return false;
            },
            child: CupertinoApp(
              debugShowCheckedModeBanner: false,
              title: 'Commutter',
              color: Colors.cyan,
              home: CustomScrollView(
                controller: controller,
                shrinkWrap: false,
                slivers: [
                  CupertinoSliverNavigationBar(
                    backgroundColor: Colors.grey[200],
                    largeTitle: Text(
                      'Make Reservation',
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle,
                    ),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Done',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Product Sans'),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: pageController,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Seat configuration',
                                          style: TextStyle(
                                              color: Colors.black,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Container(
                                          height: 480.0,
                                          width: 220.0,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1.2),
                                              color: Colors.cyan,
                                              borderRadius:
                                                  BorderRadius.circular(22.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 68.0,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                        child: Center(
                                                          child: Text('Door 1',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Product Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 8.0,
                                                              right: 8.0),
                                                      child: Container(
                                                        height: 30.0,
                                                        width: 68.0,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.blueGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                        child: Center(
                                                            child: Text(
                                                          'Driver',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat,
                                                    widget.seat.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat2.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat2,
                                                    widget.seat2.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat3.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat3,
                                                    widget.seat3.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat4.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat4,
                                                    widget.seat4.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat5.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat5,
                                                    widget.seat5.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat6.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat6,
                                                    widget.seat6.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat7.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat7,
                                                    widget.seat7.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat8.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat8,
                                                    widget.seat8.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat9.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat9,
                                                    widget.seat9.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat10.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat10,
                                                    widget.seat10.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat11.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat11,
                                                    widget.seat11.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat12.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat12,
                                                    widget.seat12.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat13.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat13,
                                                    widget.seat13.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat14.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat14,
                                                    widget.seat14.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat15.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat15,
                                                    widget.seat15.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat16.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat16,
                                                    widget.seat16.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat17.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat17,
                                                    widget.seat17.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat18.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat18,
                                                    widget.seat18.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat19.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat19,
                                                    widget.seat19.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat20.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat20,
                                                    widget.seat20.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat21.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat21,
                                                    widget.seat21.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat22.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat22,
                                                    widget.seat22.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat23.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat23,
                                                    widget.seat23.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat24.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat24,
                                                    widget.seat24.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat25.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat25,
                                                    widget.seat25.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat26.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat26,
                                                    widget.seat26.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat27.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat27,
                                                    widget.seat27.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat28.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat28,
                                                    widget.seat28.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat29.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat29,
                                                    widget.seat29.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat30.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat30,
                                                    widget.seat30.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat31.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat31,
                                                    widget.seat31.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat32.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat32,
                                                    widget.seat32.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                seatRow(
                                                  {
                                                    widget.seat33.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat33,
                                                    widget.seat33.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat34.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat34,
                                                    widget.seat34.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat35.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat35,
                                                    widget.seat35.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                  {
                                                    widget.seat36.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'id',
                                                            orElse: () => null)
                                                        .value,
                                                    widget.seat36,
                                                    widget.seat36.entries
                                                        .firstWhere(
                                                            (element) =>
                                                                element.key ==
                                                                'status',
                                                            orElse: () => null)
                                                        .value,
                                                  },
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Container(
                                                        height: 38.0,
                                                        width: 189.0,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .lightGreen,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                        child: Center(
                                                            child: Text(
                                                          'Trunk',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 220.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                              "Details",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontFamily: 'Product Sans'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 14.0,
                                          ),
                                          Container(
                                            width: 200.0,
                                            height: 200.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/joanne.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                user?.uid == null
                                                    ? ''
                                                    : user.displayName,
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Phone: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                user?.uid == null
                                                    ? ''
                                                    : user.phoneNumber,
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Address: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                user?.uid == null
                                                    ? ''
                                                    : user.photoUrl,
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Email: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                userEmail,
                                                style: TextStyle(
                                                  fontFamily: 'Product Sans',
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Bus Stage: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                widget.destination,
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Bus Stops: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "Bukoto, Ntinda",
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Bus Fare.: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                'UGX ' + widget.busFare,
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Departure time: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                widget.departTime,
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Arrival time: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                "15:00",
                                                style: TextStyle(
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6.0),
                                          GestureDetector(
                                            onTap: () {
                                              HapticFeedback.selectionClick();
                                              showGeneralDialog(
                                                barrierDismissible: true,
                                                barrierLabel: 'Account Sheet',
                                                barrierColor: Colors.black,
                                                context: context,
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 900),
                                                transitionBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return _CupertinoModalTransition(
                                                    animation: animation,
                                                    child: child,
                                                    behindChild: this
                                                        .build(this.context),
                                                  );
                                                },
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return CupertinoFullscreenDialogTransition(
                                                    primaryRouteAnimation:
                                                        animation,
                                                    secondaryRouteAnimation:
                                                        secondaryAnimation,
                                                    child: ProfileSheet(),
                                                    linearTransition: false,
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: 200.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.red),
                                              child: Center(
                                                  child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              )),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 30.0,
                                          width: 34.0,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Seat Available',
                                            style: TextStyle(
                                                fontFamily: 'Product Sans'))
                                      ],
                                    ),
                                    SizedBox(width: 20.0),
                                    Row(
                                      children: [
                                        Container(
                                          height: 30.0,
                                          width: 34.0,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 3.2),
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Seat Selected',
                                          style: TextStyle(
                                              fontFamily: 'Product Sans'),
                                        )
                                      ],
                                    ),
                                    SizedBox(width: 20.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 30.0,
                                          width: 34.0,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('Seat Taken',
                                            style: TextStyle(
                                                fontFamily: 'Product Sans'))
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.0),
                                Divider(indent: 56.0, endIndent: 56.0),
                                Center(
                                  child: Text(
                                    'You can also book any other day when you wish to travel and we shall send you a reminder',
                                    style:
                                        TextStyle(fontFamily: 'Product Sans'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  height: 130.0,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (DateTime value) async {
                                      await Future.delayed(
                                          Duration(milliseconds: 300));
                                      showCupertinoDialog(
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: Text('Confirm Action'),
                                              content: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    text:
                                                        'Do you want to reserve your seat\n',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    children: [
                                                      TextSpan(
                                                        text: widget.seatNumber,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextSpan(
                                                        text: ' on this date ',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: DateFormat.yMMMd()
                                                            .format(value),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      TextSpan(
                                                        text: '?',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                              actions: [
                                                CupertinoContextMenuAction(
                                                  child: Center(
                                                    child: Text('Accept'),
                                                  ),
                                                  onPressed: () async {
                                                    await Future.delayed(
                                                        Duration(seconds: 2));
                                                    CalendarClient.instance.insert(
                                                        title:
                                                            'Bus Reservation, seat ${widget.seatNumber}',
                                                        startTime: value,
                                                        endTime: DateTime.now()
                                                            .add(Duration(
                                                                days: 1)));
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                CupertinoContextMenuAction(
                                                  child: Center(
                                                      child: Text('Cancel')),
                                                  onPressed: () {
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            );
                                          },
                                          context: context);
                                    },
                                    initialDateTime: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    ),
                                    maximumYear: DateTime.now().year,
                                    minimumYear: DateTime.now().year,
                                    maximumDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month.toInt(),
                                      DateTime.now().day.toInt() + 5,
                                    ),
                                    minimumDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Center(
                                  child: Text(
                                    'You\'ll receive a ticket shortly after payment has been accepted ',
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .color,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 18.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            HapticFeedback.selectionClick();
                                            print('Selected seat is ' +
                                                widget.seatNumber);
                                            if (BookingSheet
                                                .instance.seatNumber.isEmpty) {
                                              CustomToast.instance.showToast(
                                                  'Select a Seat to continue',
                                                  Colors.amber,
                                                  Colors.white);
                                            } else {
                                              BookingService.instance
                                                  .storeBookingData(
                                                      context,
                                                      ticketNumber,
                                                      timeNow.toString(),
                                                      widget.busName,
                                                      user.displayName,
                                                      user.phoneNumber,
                                                      widget.busName,
                                                      widget.tripRoute,
                                                      BookingSheet
                                                          .instance.seatNumber,
                                                      widget.busPhone);
                                              WeahterService.instance
                                                  .queryWeather(
                                                      widget.destination);

                                              PaymentGateway.instance
                                                  .startTransaction(
                                                      widget.busFare,
                                                      '0776703612');

                                              await Future.delayed(
                                                  Duration(seconds: 4));

                                              print(PaymentGateway
                                                  .instance.successful);

                                              if (PaymentGateway
                                                  .instance.successful) {
                                                pageController.nextPage(
                                                  curve: Curves.decelerate,
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                );
                                              }
                                            }
                                          },
                                          child: Container(
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              color: Colors.amber,
                                            ),
                                            child: Center(
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      text: 'Pay using\n',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Product Sans',
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'MTN MOMO',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Product Sans',
                                                              fontSize: 16.3,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            HapticFeedback.selectionClick();
                                            print('Selected seat is ' +
                                                widget.seatNumber);
                                            if (BookingSheet
                                                .instance.seatNumber.isEmpty) {
                                              CustomToast.instance.showToast(
                                                  'Select a Seat to continue',
                                                  Colors.amber,
                                                  Colors.white);
                                            } else {
                                              // PaymentGateway.instance
                                              //     .startTransaction(
                                              //         '4000', '0776703612');
                                              PaymentGateway.instance
                                                  .startPayment(context, '2000',
                                                      '0702703612');
                                              // pageController.nextPage(
                                              //   curve: Curves.decelerate,
                                              //   duration: Duration(
                                              //       milliseconds: 800),
                                              // );
                                            }
                                          },
                                          child: Container(
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              color: Colors.redAccent,
                                            ),
                                            child: Center(
                                              child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      text: 'Pay using\n',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Product Sans',
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Airtel | Card',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Product Sans',
                                                              fontSize: 16.3,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ])),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            StatefulBuilder(builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  Text('Thank you for Booking!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Product Sans',
                                          fontSize: 34.0)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      'Your reservation information has been saved',
                                      style: TextStyle(
                                          fontFamily: 'Product Sans',
                                          fontSize: 17.0)),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Table(
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(children: <Widget>[
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Product Sans'),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text('Seat no.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Product Sans'),
                                            textAlign: TextAlign.center),
                                        Text('Destination',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Product Sans'),
                                            textAlign: TextAlign.center),
                                        Text('Departure',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Product Sans'),
                                            textAlign: TextAlign.center),
                                        Text('Ticket no.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Product Sans'),
                                            textAlign: TextAlign.center),
                                      ]),
                                      TableRow(children: <Widget>[
                                        Text(user.displayName,
                                            textAlign: TextAlign.center),
                                        Text(BookingSheet.instance.seatNumber,
                                            textAlign: TextAlign.center),
                                        Text(widget.destination,
                                            textAlign: TextAlign.center),
                                        Text(widget.departTime,
                                            textAlign: TextAlign.center),
                                        Text('CBT-' + ticketNumber,
                                            textAlign: TextAlign.center),
                                      ])
                                    ],
                                  ),
                                  SizedBox(height: 60.0),
                                  Text('Paid using mobile money'),
                                  SizedBox(
                                    height: 200.0,
                                  ),
                                  Text(
                                    'This is how it looks in ' +
                                        WeahterService.instance.data.city,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'It is partly ',
                                        style: TextStyle(
                                            fontFamily: 'Product Sans'),
                                      ),
                                      Text(
                                        cloudy.contains(WeahterService
                                                .instance.data.description[0].id
                                                .toString())
                                            ? 'Cloudy '
                                            : rainy.contains(WeahterService
                                                    .instance
                                                    .data
                                                    .description[0]
                                                    .id
                                                    .toString())
                                                ? ' Raining '
                                                : stormy.contains(WeahterService
                                                        .instance
                                                        .data
                                                        .description[0]
                                                        .id
                                                        .toString())
                                                    ? ' Raining with thunderstorm'
                                                    : clear.contains(
                                                            WeahterService
                                                                .instance
                                                                .data
                                                                .description[0]
                                                                .id
                                                                .toString())
                                                        ? ' Sunny '
                                                        : '',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Product Sans'),
                                      ),
                                      Text(
                                        'with ' +
                                            WeahterService.instance.data
                                                .description[0].description
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Product Sans'),
                                      )
                                    ],
                                  ),
                                  Text(
                                    cloudy.contains(WeahterService
                                            .instance.data.description[0].id
                                            .toString())
                                        ? 'You may want to carry a sweater'
                                        : rainy.contains(WeahterService
                                                .instance.data.description[0].id
                                                .toString())
                                            ? ' You may want to carry an umbrella'
                                            : stormy.contains(WeahterService
                                                    .instance
                                                    .data
                                                    .description[0]
                                                    .id
                                                    .toString())
                                                ? 'You may want to carry a sweater and umbrella'
                                                : clear.contains(WeahterService
                                                        .instance
                                                        .data
                                                        .description[0]
                                                        .id
                                                        .toString())
                                                    ? 'Wear light clothes, the temperatures may get high'
                                                    : '',
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Product Sans'),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Powered By OpenWeather API',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Product Sans'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 140.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CupertinoButton(
                                          color: Colors.cyan,
                                          onPressed: () {
                                            setState(() {});
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyTicketsPage()));
                                          },
                                          child: Text(
                                            'Go to Tickets',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ]))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget seatRow(
    Set data,
    Set data1,
    Set data2,
    Set data3,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          BusSeat(
            seatPosition: data.first,
            map: data.elementAt(1),
            data: widget.data,
            index: widget.index,
            seatSelected: data.last,
          ),
          BusSeat(
            seatPosition: data1.first,
            map: data1.elementAt(1),
            data: widget.data,
            index: widget.index,
            seatSelected: data1.last,
          ),
          Spacer(),
          BusSeat(
            seatPosition: data2.first,
            map: data2.elementAt(1),
            data: widget.data,
            index: widget.index,
            seatSelected: data2.last,
          ),
          BusSeat(
            seatPosition: data3.first,
            map: data3.elementAt(1),
            data: widget.data,
            index: widget.index,
            seatSelected: data3.last,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BusSeat extends StatefulWidget {
  final String seatPosition;
  bool seatSelected;
  var data;
  var map;
  int index;

  BusSeat({this.seatPosition, this.map, this.data, this.index, this.seatSelected = false});
  @override
  _BusSeatState createState() => _BusSeatState();
}

class _BusSeatState extends State<BusSeat> {
  Color seatColor = Colors.black;
  bool currentSeat = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return GestureDetector(
      onTap: () {
        if (!widget.seatSelected) {
          showCupertinoDialog(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('Confirm Action'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Do you want to reserve this seat\nS-',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${widget.seatPosition} ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '?',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]),
                  ),
                  actions: [
                    CupertinoContextMenuAction(
                      child: Center(
                        child: Text('Accept'),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.seatSelected = !widget.seatSelected;
                          currentSeat = !currentSeat;
                          SharedPreferencesUtil.instance
                              .setBoolValue('curr', currentSeat);
                          DatabaseHelper.instance.updateSeatAvailability(
                              widget.index,
                              widget.data,
                              widget.seatSelected,
                              int.parse(widget.seatPosition),
                              user.uid);

                          BookingSheet.instance.seatNumber =
                              widget.seatPosition;
                          print(widget.seatPosition);
                          print('seat is ' + BookingSheet.instance.seatNumber);
                        });
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoContextMenuAction(
                      child: Center(child: Text('Cancel')),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
              context: context);
        } else {
          showCupertinoDialog(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text('Confirm Action'),
                  content: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Do you want to dislodge this seat\nS- ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '${widget.seatPosition} ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '?',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]),
                  ),
                  actions: [
                    CupertinoContextMenuAction(
                      child: Center(
                        child: Text('Dislodge'),
                      ),
                      onPressed: () {
                        print(widget.map.entries
                            .firstWhere((element) => element.key == 'takenBy',
                                orElse: () => null)
                            .value);

                        if (widget.map.entries
                                .firstWhere(
                                    (element) => element.key == 'takenBy',
                                    orElse: () => null)
                                .value ==
                            user.uid) {
                          setState(() {
                            widget.seatSelected = !widget.seatSelected;
                            //    currentSeat = !currentSeat;
                            SharedPreferencesUtil.instance
                                .setBoolValue('curr', currentSeat);

                            DatabaseHelper.instance.updateSeatAvailability(
                                widget.index,
                                widget.data,
                                widget.seatSelected,
                                int.parse(widget.seatPosition),
                                '');
                          });
                        } else {
                          CustomToast.instance.showToast(
                              'Sorry, you are not the owner of this seat',
                              Colors.red,
                              Colors.white);
                        }
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoContextMenuAction(
                      child: Center(child: Text('Cancel')),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
              context: context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: 8.0,
        ),
        child: Container(
          height: 30.0,
          width: 34.0,
          decoration: BoxDecoration(
              border: currentSeat
                  ? Border.all(color: Colors.black, width: 3.2)
                  : Border.all(color: Colors.transparent),
              color: widget.seatSelected ? Colors.amber : seatColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
              child: Text(
            widget.seatPosition,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}

class _CupertinoModalTransition extends StatelessWidget {
  final Animation<double> animation;
  final Curve animationCurve;
  final Widget child;
  final Widget behindChild;

  const _CupertinoModalTransition({
    Key key,
    @required this.animation,
    @required this.child,
    @required this.behindChild,
    this.animationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var startRoundCorner = 0.0;
    final paddingTop = MediaQuery.of(context).padding.top;
    if (Theme.of(context).platform == TargetPlatform.iOS && paddingTop > 20) {
      startRoundCorner = 12.5;
    }

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: animationCurve ?? Curves.bounceIn,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AnimatedBuilder(
        animation: curvedAnimation,
        child: child,
        builder: (context, child) {
          final progress = curvedAnimation.value;
          final yOffset = progress * paddingTop;
          final scale = 1 - progress / 10;
          final radius = progress == 0
              ? 0.0
              : (1 - progress) * startRoundCorner + progress * 12;
          return Stack(
            children: [
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(color: Colors.black),
              ),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Transform.translate(
                  offset: Offset(0, yOffset),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: behindChild,
                    ),
                  ),
                ),
              ),
              child,
            ],
          );
        },
      ),
    );
  }
}
