import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commuter/utils/sheetHelper.dart';
import 'package:commuter/widgets/accountSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commuter/widgets/ticket_Button.dart';
import 'package:provider/provider.dart';

class MyTicketsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.0),
          Center(
            child: Text(
              'My Tickets',
              style: TextStyle(
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Product Sans'),
            ),
          ),
          SizedBox(height: 40.0),
          user?.uid == null
              ? Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.blue.withOpacity(0.9),
                                  Colors.cyan,
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft),
                          ),
                          child: Icon(Icons.qr_code_rounded,
                              color: Colors.white, size: 44.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Create your account/ Sign in now!',
                          style: TextStyle(
                              fontSize: 46,
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Text(
                            'Log in to view your tickets.\nYour tickets will appear here',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                elevation: 6.0,
                                child: Container(
                                  height: 80.0,
                                  child: CupertinoButton(
                                    borderRadius: BorderRadius.circular(20.0),
                                    onPressed: () {
                                      showGeneralDialog(
                                        barrierDismissible: true,
                                        barrierLabel: 'Profile Sheet',
                                        barrierColor: Colors.black,
                                        context: context,
                                        transitionDuration:
                                            const Duration(milliseconds: 900),
                                        transitionBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return CupertinoModalTransition(
                                            animation: animation,
                                            child: child,
                                            behindChild: this.build(context),
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return CupertinoFullscreenDialogTransition(
                                            primaryRouteAnimation: animation,
                                            secondaryRouteAnimation:
                                                secondaryAnimation,
                                            child: ProfileSheet(),
                                            linearTransition: false,
                                          );
                                        },
                                      );
                                      Navigator.pop(context);
                                    },
                                    color: Colors.amber,
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                          fontFamily: 'Product Sans'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("UserData")
                          .document(user.uid)
                          .collection("MyReservations")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          );
                        }

                        if (snapshot?.data?.documents?.length == 0) {
                          return Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.red.withOpacity(0.9),
                                            Colors.pink,
                                          ],
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft),
                                    ),
                                    child: Icon(Icons.calendar_today,
                                        color: Colors.white, size: 44.0),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Oops!',
                                    style: TextStyle(
                                        fontSize: 46,
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30.0, right: 30.0),
                                    child: Text(
                                      'Sorry, You currently have no recent bookings. Make a reservation and they\'ll appear here',
                                      style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontSize: 22,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]),
                          );
                        } else {
                          return Stack(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 10.0),
                              child: Text(
                                'Here are your recent tickets schedules',
                                textScaleFactor: .8,
                                style: TextStyle(
                                    fontFamily: 'Celliad',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 38.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                height: size.height - 400,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.documents.length,
                                    itemBuilder: (context, index) {
                                      return TicketButton(
                                        busName: snapshot.data.documents[index]
                                            ['bus_name'],
                                        bookingDate: snapshot.data
                                            .documents[index]['booking_date'],
                                        ticketNumber: snapshot.data
                                            .documents[index]['ticket_number'],
                                        busCompany: snapshot.data
                                            .documents[index]['bus_company'],
                                        clientName: snapshot.data
                                            .documents[index]['first_name'],
                                        clientPhone: snapshot.data
                                            .documents[index]['phoneNumber'],
                                        tripRoute: snapshot.data
                                            .documents[index]['trip_route'],
                                        seatNumber: snapshot.data
                                            .documents[index]['seat_number'],
                                        busPhone: snapshot.data.documents[index]
                                            ['bus_phone'],
                                      );
                                    }),
                              ),
                            )
                          ]);
                        }
                      })),
        ],
      ),
    );
  }
}

