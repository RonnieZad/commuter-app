import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commuter/screens/busInfoBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchResult extends StatelessWidget {
  final String queryText;
  SearchResult({this.queryText});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SearchPageTopPart(searchedItem: queryText),
            SizedBox(height: 20.0),
            FlightListingBottomPart(queryText: queryText),
          ],
        ),
      ),
    );
  }
}

class FlightListingBottomPart extends StatefulWidget {
  final String queryText;
  FlightListingBottomPart({this.queryText});
  @override
  FlightListingBottomPartState createState() {
    return new FlightListingBottomPartState();
  }
}

class FlightListingBottomPartState extends State<FlightListingBottomPart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collectionGroup('listing').where(
              'destination',
              arrayContainsAny: [widget.queryText],
            ).snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : _buildDealsList(context, snapshot.data.documents);
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildDealsList(BuildContext context, List<DocumentSnapshot> snapshots) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshots.length,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SearchCards(
            index: index,
            searchFields: SearchFields.fromSnapshot(snapshots[index]));
      });
}

class SearchFields {
  final String route,
      busName,
      busInfo,
      busCode,
      price,
      phone,
      travelTime,
      travelDate,
      busFareOld,
      imagePath;
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
  final List destination, album;

  SearchFields.fromMap(Map<String, dynamic> map)
      : assert(map['route'] != null),
        assert(map['bus_info'] != null),
        assert(map['bus_name'] != null),
        assert(map['bus_cover_image'] != null),
        destination = List.from(map['destination']),
        album = List.from(map['bus_slider_image']),
        route = map['route'],
        travelTime = map['travel_time'],
        travelDate = map['travel_date'],
        phone = map['phone'],
        price = map['bus_fare'],
        busFareOld = map['bus_fare_old'],
        imagePath = map['bus_cover_image'],
        busCode = map['bus_code'],
        busName = map['bus_name'],
        busInfo = map['bus_info'];

  SearchFields.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data);
}

class SearchCards extends StatelessWidget {
  final SearchFields searchFields;
  final int index;

  SearchCards({this.searchFields, this.index});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        HapticFeedback.vibrate();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetails(
              //busCodeName: searchFields.busCode,
              index: index,
              name: searchFields.busName + searchFields.busCode,
              destination: searchFields.destination,
              image: searchFields.imagePath,
              newPrice: searchFields.price,
              oldPrice: searchFields.busFareOld,
              tripRoute: searchFields.route,
              description: searchFields.busInfo,
              sliderImages: searchFields.album,
              phone: searchFields.phone,
              seat: searchFields.seat,
              seat2: searchFields.seat2,
              seat3: searchFields.seat3,
              seat4: searchFields.seat4,
              seat5: searchFields.seat5,
              seat6: searchFields.seat6,
              seat7: searchFields.seat7,
              seat8: searchFields.seat8,
              seat9: searchFields.seat9,
              seat10: searchFields.seat10,
              seat11: searchFields.seat11,
              seat12: searchFields.seat12,
              seat13: searchFields.seat13,
              seat14: searchFields.seat14,
              seat15: searchFields.seat15,
              seat16: searchFields.seat16,
              seat17: searchFields.seat17,
              seat18: searchFields.seat18,
              seat19: searchFields.seat19,
              seat20: searchFields.seat20,
              seat21: searchFields.seat21,
              seat22: searchFields.seat22,
              seat23: searchFields.seat23,
              seat24: searchFields.seat24,
              seat25: searchFields.seat25,
              seat26: searchFields.seat26,
              seat27: searchFields.seat27,
              seat28: searchFields.seat28,
              seat29: searchFields.seat29,
              seat30: searchFields.seat30,
              seat31: searchFields.seat31,
              seat32: searchFields.seat32,
              seat33: searchFields.seat33,
              seat34: searchFields.seat34,
              seat35: searchFields.seat35,
              seat36: searchFields.seat36,
              //   departHour: searchFields.travelTime
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 320.0,
              child: CachedNetworkImage(
                imageUrl: searchFields.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 100.0,
                height: 65.0,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child: Center(
                  child: Text(searchFields.route,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 4.0),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade400,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Center(
                    child: Text(
                      'Book',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Product Sans',
                      ),
                    ),
                  )),
            ),
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                    ),
                    width: size.width * 0.16,
                    height: size.width * 0.16,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  searchFields.busName +
                                      ', ' +
                                      searchFields.busCode,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Product Sans',
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'UGX,' + searchFields.busFareOld,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Product Sans',
                                      ),
                                    ),
                                    Text(
                                      'UGX,' + searchFields.price,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontFamily: 'Product Sans',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Traveling on : ' +
                                      DateTime.now().day.toString() +
                                      'th Jan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Product Sans',
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Time: ${searchFields.travelTime.toString()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Product Sans',
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class SearchPageTopPart extends StatelessWidget {
  final String searchedItem;
  const SearchPageTopPart({this.searchedItem});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Material(
          elevation: 12.0,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22.0),
            bottomRight: Radius.circular(22.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22.0),
                bottomRight: Radius.circular(22.0),
              ),
              gradient: LinearGradient(colors: [Colors.cyan, Colors.blue]),
            ),
            height: 240.0,
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 20.0,
          left: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 180.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.cyan[200],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(
                  'Text',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Product Sans'),
                )),
              ),
              SizedBox(
                width: 4.0,
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              SizedBox(
                width: 4.0,
              ),
              Container(
                width: 180.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.cyan[300],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(
                  searchedItem,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Product Sans'),
                )),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 34.0, left: 10),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Center(
              child: Text("Search Result",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Product Sans',
                      fontSize: 24)),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You have searched for ',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: size.width * 0.037,
                        fontFamily: 'Product Sans')),
                Text(searchedItem,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.037,
                        fontFamily: 'Product Sans')),
              ],
            ),
          ],
        )
      ],
    );
  }
}
