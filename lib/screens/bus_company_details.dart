import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:commuter/widgets/bookingSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:commuter/widgets/textTrimmer.dart';

class PopularBusCompanyDetails extends StatefulWidget {
  final String title, imageCover, description;

  const PopularBusCompanyDetails(
      {Key key, this.title, this.imageCover, this.description})
      : super(key: key);
  @override
  _PopularBusCompanyDetailsState createState() =>
      _PopularBusCompanyDetailsState();
}

class _PopularBusCompanyDetailsState extends State<PopularBusCompanyDetails> {
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Filter",
        style: TextStyle(fontFamily: 'Product Sans', fontSize: 18.0)),
    1: Text("Sort",
        style: TextStyle(fontFamily: 'Product Sans', fontSize: 18.0)),
  };
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.4,
        backgroundColor: Color.fromRGBO(222, 222, 224, 1),
        centerTitle: true,
        elevation: 0.0,
        title: Text(widget.title,
            style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
               HapticFeedback.selectionClick();
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Color.fromRGBO(222, 222, 224, 1),
      body: Stack(children: <Widget>[
        Column(
          children: [
            Container(
              width: 540.0,
              height: 300.0,
              child: PageView(
                children: [
                  Center(
                    child: Container(
                      width: 540.0,
                      height: 500.0,
                      child: Image.asset(
                        widget.imageCover,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 540.0,
                      height: 500.0,
                      child: Image.asset(
                        'assets/images/joanne.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 540.0,
                      height: 500.0,
                      child: Image.asset(
                        'assets/images/joanne.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 300.0, left: 0.0, right: 0.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'widget.name',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'widget.oldPrice',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Text(
                            'widget.newPrice',
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Text(
                        'About company',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.favorite_border,
                              color: Colors.red, size: 34.0),
                          onPressed: () {}),
                      SizedBox(width: 4.0),
                      IconButton(
                          icon: Icon(CupertinoIcons.share,
                              color: Colors.black, size: 34.0),
                          onPressed: () {})
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Text('View fleet',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                CupertinoSlidingSegmentedControl(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  children: myTabs,
                  groupValue: segmentedControlGroupValue,
                  onValueChanged: (i) {
                    setState(() {
                      segmentedControlGroupValue = i;
                    });
                  },
                ),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildProductCard(
                            size,
                            'https://ug.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/11/54323/1.jpg?6949',
                            'Departure: 12:00pm\nUG 5434P',
                            'UGX165,000',
                            'UGX200,000',
                            'KLA - EBB',
                            'The 32\" backlit LED panel of the television produces eye catching\r\n\r\nHD resolution images that are simply stunning to look at. This TV also has a number of ports to keep you well connected at all times, and these include the USB and HDMI ports. \r\n\r\n\r\n\r\nAvailable exclusively at Jumia Uganda, order for this Digital HDTV at an unbeatable price and let us deliver straight to your doorstep. \r\n\r\n\r\n32\" LED Display\r\nThe Wegastar 32 inch HD LED TV\u2019s makes a perfect addition to contemporary rooms. When switched on, the backlit LED screen churns out images and videos with amazing contrast and details.\r\n\r\nHigh Definition TV\r\nThe Wegastar 32\" HD LED display generates amazingly clear, razor sharp images with a resolution of 720p HD.\r\n\r\nDigital LED Technology\r\nWitness the entire RCG spectrum brought to life on your screen. The Wegastar  LED TV brings you exceptionally vibrant and true-to-life images delivered just as the director imagined.\r\n\r\n\r\nExplorer More Connectivity Options\r\nThe TV features 1 USB ports, and 1 HDMI ports to which you can connect your DVD players, cameras, external hard drives, and more. Now you can enjoy all your multimedia content of these gadgets on the big screen, right from the comfort of your couch. It also features a VGA & PC audio input.',
                            context),
                        SizedBox(width: 8.0),
                        _buildProductCard(
                            size,
                            'https://ug.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/11/54323/1.jpg?6949',
                            'Departure: 12:00pm\nUG 5434P',
                            'UGX165,000',
                            'UGX200,000',
                            'KLA - EBB',
                            'The 32\" backlit LED panel of the television produces eye catching\r\n\r\nHD resolution images that are simply stunning to look at. This TV also has a number of ports to keep you well connected at all times, and these include the USB and HDMI ports. \r\n\r\n\r\n\r\nAvailable exclusively at Jumia Uganda, order for this Digital HDTV at an unbeatable price and let us deliver straight to your doorstep. \r\n\r\n\r\n32\" LED Display\r\nThe Wegastar 32 inch HD LED TV\u2019s makes a perfect addition to contemporary rooms. When switched on, the backlit LED screen churns out images and videos with amazing contrast and details.\r\n\r\nHigh Definition TV\r\nThe Wegastar 32\" HD LED display generates amazingly clear, razor sharp images with a resolution of 720p HD.\r\n\r\nDigital LED Technology\r\nWitness the entire RCG spectrum brought to life on your screen. The Wegastar  LED TV brings you exceptionally vibrant and true-to-life images delivered just as the director imagined.\r\n\r\n\r\nExplorer More Connectivity Options\r\nThe TV features 1 USB ports, and 1 HDMI ports to which you can connect your DVD players, cameras, external hard drives, and more. Now you can enjoy all your multimedia content of these gadgets on the big screen, right from the comfort of your couch. It also features a VGA & PC audio input.',
                            context),
                      ]),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildProductCard(
                            size,
                            'https://ug.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/11/54323/1.jpg?6949',
                            'Departure: 12:00pm\nUG 5434P',
                            'UGX165,000',
                            'UGX200,000',
                            'KLA - EBB',
                            'The 32\" backlit LED panel of the television produces eye catching\r\n\r\nHD resolution images that are simply stunning to look at. This TV also has a number of ports to keep you well connected at all times, and these include the USB and HDMI ports. \r\n\r\n\r\n\r\nAvailable exclusively at Jumia Uganda, order for this Digital HDTV at an unbeatable price and let us deliver straight to your doorstep. \r\n\r\n\r\n32\" LED Display\r\nThe Wegastar 32 inch HD LED TV\u2019s makes a perfect addition to contemporary rooms. When switched on, the backlit LED screen churns out images and videos with amazing contrast and details.\r\n\r\nHigh Definition TV\r\nThe Wegastar 32\" HD LED display generates amazingly clear, razor sharp images with a resolution of 720p HD.\r\n\r\nDigital LED Technology\r\nWitness the entire RCG spectrum brought to life on your screen. The Wegastar  LED TV brings you exceptionally vibrant and true-to-life images delivered just as the director imagined.\r\n\r\n\r\nExplorer More Connectivity Options\r\nThe TV features 1 USB ports, and 1 HDMI ports to which you can connect your DVD players, cameras, external hard drives, and more. Now you can enjoy all your multimedia content of these gadgets on the big screen, right from the comfort of your couch. It also features a VGA & PC audio input.',
                            context),
                        SizedBox(width: 8.0),
                        _buildProductCard(
                            size,
                            'https://ug.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/11/54323/1.jpg?6949',
                            'Departure: 12:00pm\nUG 5434P',
                            'UGX165,000',
                            'UGX200,000',
                            'KLA - EBB',
                            'The 32\" backlit LED panel of the television produces eye catching\r\n\r\nHD resolution images that are simply stunning to look at. This TV also has a number of ports to keep you well connected at all times, and these include the USB and HDMI ports. \r\n\r\n\r\n\r\nAvailable exclusively at Jumia Uganda, order for this Digital HDTV at an unbeatable price and let us deliver straight to your doorstep. \r\n\r\n\r\n32\" LED Display\r\nThe Wegastar 32 inch HD LED TV\u2019s makes a perfect addition to contemporary rooms. When switched on, the backlit LED screen churns out images and videos with amazing contrast and details.\r\n\r\nHigh Definition TV\r\nThe Wegastar 32\" HD LED display generates amazingly clear, razor sharp images with a resolution of 720p HD.\r\n\r\nDigital LED Technology\r\nWitness the entire RCG spectrum brought to life on your screen. The Wegastar  LED TV brings you exceptionally vibrant and true-to-life images delivered just as the director imagined.\r\n\r\n\r\nExplorer More Connectivity Options\r\nThe TV features 1 USB ports, and 1 HDMI ports to which you can connect your DVD players, cameras, external hard drives, and more. Now you can enjoy all your multimedia content of these gadgets on the big screen, right from the comfort of your couch. It also features a VGA & PC audio input.',
                            context),
                      ]),
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildProductCard(
      Size size,
      String image,
      String description,
      String oldPrice,
      String newPrice,
      String discount,
      String fullDescription,
      BuildContext context) {
    return InkWell(
      onTap: () {
         HapticFeedback.selectionClick();
        showGeneralDialog(
          barrierDismissible: true,
          barrierLabel: 'Booking Sheet',
          barrierColor: Colors.black,
          context: context,
          transitionDuration: const Duration(milliseconds: 920),
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return _CupertinoModalTransition(
              animation: animation,
              child: child,
              behindChild: this.build(this.context),
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return CupertinoFullscreenDialogTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,

              /// Content of your dialog
              child: BookingSheet(),
              linearTransition: true,
            );
          },
        );
      },
      child: Container(
        width: 220.0,
        height: 320.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Container(
                width: 80.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child: Center(
                  child: Text(discount,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 220,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 18.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            oldPrice,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            newPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
          Positioned(
            right: 0.0,
            left: 0.0,
            bottom: 99.0,
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.3),
                    ),
                    width: size.width * 0.16,
                    height: size.width * 0.16,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showGeneralDialog(
                                barrierDismissible: true,
                                barrierLabel: 'Booking Sheet',
                                barrierColor: Colors.black,
                                context: context,
                                transitionDuration:
                                    const Duration(milliseconds: 920),
                                transitionBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return _CupertinoModalTransition(
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

                                    /// Content of your dialog
                                    child: BookingSheet(),
                                    linearTransition: true,
                                  );
                                },
                              );
                            },
                            child: Container(
                                width: 100.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(CupertinoIcons.bus,
                                          color: Colors.black),
                                      Text('Book',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))
                                    ])),
                          ),
                        ])),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _CupertinoModalTransition extends StatelessWidget {
  /// Animation that [child] will use for entry or leave
  final Animation<double> animation;

  /// Animation curve to be applied to [animation]
  ///
  /// Defaults to [Curves.easeOut]
  final Curve animationCurve;

  /// Widget that will be displayed at the top
  final Widget child;

  /// Widget that will be displayed behind [child]
  ///
  /// Usually this is the route that shows this model
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
      // See: https://kylebashour.com/posts/finding-the-real-iphone-x-corner-radius
    }

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: animationCurve ?? Curves.bounceIn,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      /// Because the first element of the stack below is a black coloured
      /// container, this is required
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
                // onTap: Navigator.of(context).pop,
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
