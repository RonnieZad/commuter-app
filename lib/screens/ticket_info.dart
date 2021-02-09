import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketInfoPage extends StatefulWidget {
  final String ticketNumber,
      bookingDate,
      busCompany,
      clientName,
      clientPhone,
      busName,
      tripRoute,
      seatNumber,
      busPhone;

  const TicketInfoPage(
      {Key key,
      @required this.busName,
      this.ticketNumber,
      this.bookingDate,
      this.busCompany,
      this.clientName,
      this.clientPhone,
      this.tripRoute,
      this.seatNumber,
      this.busPhone})
      : super(key: key);

  @override
  _TicketInfoPageState createState() => _TicketInfoPageState();
}

class _TicketInfoPageState extends State<TicketInfoPage> {
  bool blindTicket = true;

  String _isVerifried = 'NOT AUTHORISED';

  LocalAuthentication authentication = LocalAuthentication();

  Future<void> _getAuth() async {
    bool isAuthorised = false;

    try {
      isAuthorised = await authentication.authenticateWithBiometrics(
          androidAuthStrings: AndroidAuthMessages(
              signInTitle: 'User Verification',
              fingerprintHint: 'Touch ID to authenticate',
              goToSettingsButton: 'Open Settings',
              fingerprintRequiredTitle: 'Authenticate to continue',
              cancelButton: 'Cancel',
              fingerprintNotRecognized: 'Sorry, no such fingerprint',
              fingerprintSuccess: 'Verification Successful!',
              goToSettingsDescription: 'Go to seetings, to set up Touch ID'),
          localizedReason: "Scan your fingerprint to continue",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _isVerifried = isAuthorised ? 'Authorised' : 'Not Authorised';
      isAuthorised ? blindTicket = false : blindTicket = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Ticket Information',
                    style: TextStyle(
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Product Sans'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Display this e-ticket to the Conductor while onboard ',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Product Sans'),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 600.0,
                        height: 800.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/ticketTemplate.png')),
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      Positioned(
                        top: 90.0,
                        right: 55.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ticket No: ',
                                  style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(
                                  widget.ticketNumber,
                                  style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Date: ',
                                  style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  widget.bookingDate,
                                  style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.busCompany + ' BUS SERVICES',
                                    style: TextStyle(
                                        fontFamily: 'Dark Seed',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 26.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Name: ',
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    widget.clientName,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Phone: ',
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    widget.clientPhone,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Bus name: ',
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    widget.busName,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Trip: ',
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    widget.tripRoute,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Seat No.: ',
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'SN-' + widget.seatNumber,
                                    style: TextStyle(
                                        fontFamily: 'Product Sans',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Center(
                                child: Container(
                                  width: 220,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                  child: QrImage(
                                    data:
                                        'For help & inquiry, Please call Tel: 0776703612, For help & inquiry, Please call Tel: 0776703612',
                                    version: QrVersions.auto,
                                    size: 220,
                                    gapless: true,
                                    embeddedImage: AssetImage(
                                        'assets/images/icon_launcher.png'),
                                    embeddedImageStyle: QrEmbeddedImageStyle(
                                      size: Size(49, 49),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  launch('tel:${widget.busPhone}');
                                  HapticFeedback.selectionClick();
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        'For help & inquiry, Please call Tel:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Product Sans',
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ${widget.busPhone}',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: 'Product Sans',
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                        children: <TextSpan>[],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: CupertinoButton(
                      color: Colors.amber,
                      child: Text('Share ETA'),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          blindTicket
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      _getAuth();
                    },
                    child: Container(
                      height: size.height,
                      width: size.width,
                      color: Colors.black26,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 108.0),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '$_isVerifried',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Product Sans',
                                          color: Colors.white,
                                          fontSize: 34.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '\n\nAuthenticate to view Ticket',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Product Sans',
                                              fontSize: 24.0),
                                        ),
                                      ])),
                            ),
                          ),
                          Align(
                            alignment: Alignment(-0.06, 0),
                            child: IconButton(
                                icon: Icon(Icons.fingerprint_rounded,
                                    size: 67.0, color: Colors.white),
                                onPressed: () {
                                  HapticFeedback.selectionClick();
                                  _getAuth();
                                }),
                          ),
                          Align(
                            alignment: Alignment(0, 0.2),
                            child: Text('Tap button to unlock',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14.0),
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
