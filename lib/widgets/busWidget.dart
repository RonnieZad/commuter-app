import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commuter/screens/busInfoBook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BusWidget extends StatelessWidget {
  var data;
  int index;
  final String image,
      busCodeName,
      busName,
      oldPrice,
      newPrice,
      tripRoute,
      fullDescription,
      departHour,
      phone;
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

  BusWidget(
      {Key key,
      this.image,
      this.data,
      this.busCodeName,
      this.oldPrice,
      this.destination,
      this.busName,
      this.departHour,
      this.newPrice,
      this.sliderImages,
      this.tripRoute,
      this.phone,
      this.index,
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

      this.fullDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetails(
              index: index,
                image: image,
                data: data,
                departTime: departHour,
                sliderImages: sliderImages,
                newPrice: newPrice,
                destination: destination,
                phone: phone,
                seat: seat,
                seat2: seat2,
                seat3: seat3,
                seat4: seat4,
                seat5: seat5,
                seat6: seat6,
                seat7: seat7,
                seat8: seat8,
                seat9: seat9,
                seat10: seat10,
                seat11: seat11,
                seat12: seat12,
                seat13: seat13,
                seat14: seat14,
                seat15: seat15,
                seat16: seat16,
                seat17: seat17,
                seat18: seat18,
                seat19: seat19,
                seat20: seat20,
                seat21: seat21,
                seat22: seat22,
                seat23: seat23,
                seat24: seat24,
                seat25: seat25,
                seat26: seat26,
                seat27: seat27,
                seat28: seat28,
                seat29: seat29,
                seat30: seat30,
                seat31: seat31,
                seat32: seat32,
                seat33: seat33,
                seat34: seat34,
                seat35: seat35,
                seat36: seat36,
                oldPrice: oldPrice,
                name: 'Kayoola ' + busCodeName,
                tripRoute: tripRoute,
                description: fullDescription,
                coverImage: image),
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
                imageUrl: image,
                placeholder: (context, url) {
                  return Image.asset(
                    'assets/images/laoder_image.png',
                    fit: BoxFit.cover,
                  );
                },
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
                  child: Text(tripRoute,
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
                                  busName + ', ' + busCodeName,
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
                                      'UGX,' + newPrice,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Product Sans',
                                      ),
                                    ),
                                    Text(
                                      'UGX,' + oldPrice,
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
                                  'Time: ${departHour.toString()}',
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
