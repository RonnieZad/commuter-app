import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commuter/utils/sheetHelper.dart';
import 'package:commuter/widgets/bookingSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:commuter/widgets/textTrimmer.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetails extends StatefulWidget {
  var data;
  int index;
  final String image,
      oldPrice,
      newPrice,
      tripRoute,
      description,
      name,
      departTime,
      phone,
      coverImage;
  final List sliderImages, destination;
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

  TripDetails(
      {Key key,
      this.image,
      this.index,
      this.oldPrice,
      this.data,
      this.newPrice,
      this.destination,
      this.tripRoute,
      this.description,
      this.departTime,
      this.name,
      this.phone,
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
      this.sliderImages,
      this.coverImage})
      : super(key: key);
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  int _currentPage = 0;
  int time = 500;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  int selectedItem = 0;
  double pageOffset = 0;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.sliderImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.addListener(() {
        setState(() => pageOffset = _pageController.page);
      });
      !_pageController.hasClients
          ? _pageController.initialPage
          : _pageController.animateToPage(
              _currentPage,
              duration: Duration(milliseconds: 360),
              curve: Curves.linear,
            );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromRGBO(222, 222, 224, 1),
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(222, 222, 224, 1),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'Trip details\n${widget.tripRoute}',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            )),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 540.0,
                      height: 400.0,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: BouncingScrollPhysics(),
                        itemCount: widget.sliderImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 540.0,
                            height: 500.0,
                            child: CachedNetworkImage(
                              imageUrl: widget.sliderImages[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'UGX,' + widget.newPrice,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                'UGX,' + widget.oldPrice,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 14.0),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Amenities',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: <Widget>[
                            buildAmenitiesIcon(Icons.wifi, 'Free Wifi', size),
                            buildAmenitiesIcon(Icons.spa, 'TV', size),
                            buildAmenitiesIcon(Icons.local_bar, 'Food', size),
                            buildAmenitiesIcon(
                                Icons.library_music, 'Music', size),
                            buildAmenitiesIcon(
                                Icons.beach_access, 'Luxury', size),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 14.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Text(
                            'Bus description',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          SizedBox(width: 4.0),
                          IconButton(
                              icon: Icon(CupertinoIcons.share,
                                  color: Colors.black, size: 34.0),
                              onPressed: () {
                                Share.share(
                                    'Hi there, check out ${widget.name} on the Commuter App if you are traveling ${widget.tripRoute}. Prices have been cut from UGX${widget.oldPrice} to UGX${widget.oldPrice}  ');
                              })
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DescriptionTextWidget(
                        text: widget.description,
                      ),
                    ),
                    SizedBox(height: 80.0),
                  ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color.fromRGBO(222, 222, 224, 1),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          launch("tel:${widget.phone}");
                        },
                        child: Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(14.0)),
                          child: Center(
                            child: Icon(Icons.phone, color: Colors.white),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          showGeneralDialog(
                            barrierDismissible: true,
                            barrierLabel: 'Booking Sheet',
                            barrierColor: Colors.black,
                            context: context,
                            transitionDuration:
                                const Duration(milliseconds: 900),
                            transitionBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return CupertinoModalTransition(
                                animation: animation,
                                child: child,
                                behindChild: this.build(this.context),
                              );
                            },
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return CupertinoFullscreenDialogTransition(
                                primaryRouteAnimation: animation,
                                secondaryRouteAnimation: secondaryAnimation,
                                child: BookingSheet(
                                  index: widget.index,
                                  busPhone: widget.phone,
                                  tripRoute: widget.tripRoute,
                                  departTime: widget.departTime,
                                  busName: widget.name,
                                  data: widget.data,
                                  destination: widget.destination[0],
                                  busFare: widget.newPrice,
                                  seat: widget.seat,
                                  seat2: widget.seat2,
                                  seat3: widget.seat3,
                                  seat4: widget.seat4,
                                  seat5: widget.seat5,
                                  seat6: widget.seat6,
                                  seat7: widget.seat7,
                                  seat8: widget.seat8,
                                  seat9: widget.seat9,
                                  seat10: widget.seat10,
                                  seat11: widget.seat11,
                                  seat12: widget.seat12,
                                  seat13: widget.seat13,
                                  seat14: widget.seat14,
                                  seat15: widget.seat15,
                                  seat16: widget.seat16,
                                  seat17: widget.seat17,
                                  seat18: widget.seat18,
                                  seat19: widget.seat19,
                                  seat20: widget.seat20,
                                  seat21: widget.seat21,
                                  seat22: widget.seat22,
                                  seat23: widget.seat23,
                                  seat24: widget.seat24,
                                  seat25: widget.seat25,
                                  seat26: widget.seat26,
                                  seat27: widget.seat27,
                                  seat28: widget.seat28,
                                  seat29: widget.seat29,
                                  seat30: widget.seat30,
                                  seat31: widget.seat31,
                                  seat32: widget.seat32,
                                  seat33: widget.seat33,
                                  seat34: widget.seat34,
                                  seat35: widget.seat35,
                                  seat36: widget.seat36,
                                ),
                                linearTransition: false,
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 400.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(14.0)),
                          child: Center(
                            child: Text(
                              'Reserve seat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget buildAmenitiesIcon(IconData iconhere, String title, Size size) {
    return Column(
      children: <Widget>[
        Container(
          width: size.width * 0.15,
          height: size.width * 0.18,
          child: Card(
              margin: EdgeInsets.only(right: 8, bottom: 24),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Icon(iconhere, color: Colors.cyan)),
        ),
        Text(title,
            style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}


