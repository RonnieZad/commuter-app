import 'dart:async';
import 'dart:ui';
import 'package:commuter/screens/search_page.dart';
import 'package:commuter/utils/sheetHelper.dart';
import 'package:commuter/widgets/covid_info_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commuter/models/bus_route_model.dart';
import 'package:commuter/widgets/accountSheet.dart';
import 'package:commuter/widgets/busWidget.dart';
import 'package:commuter/constants/strings.dart';
import 'package:commuter/screens/bus_company_details.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _queryTextContoller = TextEditingController();
  int _currentPage = 0;
  int time = 500;
  int selectedItem = 0;

  double pageOffset = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 8), (Timer timer) {
      if (_currentPage < sliderSafetyTips.length - 1) {
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
    final Size size = MediaQuery.of(context).size;
    List<BusRouteModel> busRoutes = Provider.of<List<BusRouteModel>>(context);
    var user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26.0),
                bottomRight: Radius.circular(26.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, right: 20.0, left: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Commuter',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyan,
                                      fontSize: 48.0,
                                      fontFamily: 'Pattaya-Regular'),
                                ),
                              ],
                            ),
                            Text(
                              'Simple, cheap and fast!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                  color: Colors.black,
                                  fontFamily: 'Celliad'),
                            ),
                          ]),
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              HapticFeedback.selectionClick();

                              //  PaymentGateway.instance.generateToken();

                              if (user?.uid == null) {
                                showGeneralDialog(
                                  barrierDismissible: true,
                                  barrierLabel: 'Account Sheet',
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
                                      secondaryRouteAnimation:
                                          secondaryAnimation,
                                      child: AccountSheet(),
                                      linearTransition: false,
                                    );
                                  },
                                );
                              } else {
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
                                      behindChild: this.build(this.context),
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return CupertinoFullscreenDialogTransition(
                                      primaryRouteAnimation: animation,
                                      secondaryRouteAnimation:
                                          secondaryAnimation,
                                      child: ProfileSheet(),
                                      linearTransition: false,
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(36.0),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/joanne.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 10, bottom: 35.0, top: 30.0),
                  child: Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(size.width * 0.07),
                    child: Container(
                      height: size.width * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.07)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            controller: _queryTextContoller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontFamily: 'Product Sans',
                                color: Colors.black45,
                                fontSize: size.width * 0.041,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: size.width * 0.022),
                              hintText: 'Search for any city, destination...',
                              suffixIcon: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: IconButton(
                                      icon: Icon(Icons.search,
                                          size: 22.0, color: Colors.black),
                                      onPressed: () {
                                        HapticFeedback.selectionClick();
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);

                                        if (!currentFocus.hasPrimaryFocus &&
                                            currentFocus.focusedChild != null) {
                                          currentFocus.focusedChild.unfocus();
                                        }

                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => SearchResult(
                                              queryText:
                                                  _queryTextContoller.text,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                ListView(physics: BouncingScrollPhysics(), children: <Widget>[
         GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  showGeneralDialog(
                    barrierDismissible: true,
                    barrierLabel: 'Covid-19 Sheet',
                    barrierColor: Colors.black,
                    context: context,
                    transitionDuration: const Duration(milliseconds: 900),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return CupertinoModalTransition(
                        animation: animation,
                        child: child,
                        behindChild: this.build(this.context),
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return CupertinoFullscreenDialogTransition(
                        primaryRouteAnimation: animation,
                        secondaryRouteAnimation: secondaryAnimation,
                        child: Covid19InfoSheet(),
                        linearTransition: false,
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'COVI9-19 Guide lines',
                          style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        SizedBox(width: 6.0),
                        Icon(Icons.info_outline_rounded),
                        Spacer(),
                        Text(
                          'See more',
                          style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 12.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: <Widget>[
                      Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.cyan.withOpacity(0.3),
                                  Colors.orange.withOpacity(0.3)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Wash your hands',
                                        style: TextStyle(
                                            fontFamily: 'Product Sans',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Ensure to use sanitiser or a lot of water',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.normal),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.cyan.withOpacity(0.3),
                                  Colors.red.withOpacity(0.3)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Keep social distance',
                                        style: TextStyle(
                                            fontFamily: 'Product Sans',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Keep one sit between you and next passenger',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.normal),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.cyan.withOpacity(0.3),
                                  Colors.green.withOpacity(0.3)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Wear a face mask',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Properly cover your face with a shield to protect yourself',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.normal),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.cyan.withOpacity(0.3),
                                  Colors.brown.withOpacity(0.3)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Don\' touch soft parts',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'These include eyes, ears, nose and mouth',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Product Sans',
                                            fontWeight: FontWeight.normal),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
          Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 28.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'New Kayoola Bus',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 3.0),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 3.0),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
       Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300.0,
                  child: PageView.builder(
                    itemCount: busRoutes?.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext bc, int index) {
                      return BusWidget(
                        index: index,
                        data: busRoutes[index].data,
                        busCodeName: busRoutes[index]?.busCode,
                        busName: busRoutes[index]?.busName,
                        destination: busRoutes[index]?.destination,
                        image: busRoutes[index]?.imagePath,
                        newPrice: busRoutes[index]?.busFare,
                        oldPrice: busRoutes[index]?.busFareOld,
                        tripRoute: busRoutes[index]?.route,
                        fullDescription: busRoutes[index]?.busInfo,
                        sliderImages: busRoutes[index]?.gallery,
                        phone: busRoutes[index]?.phone,
                        departHour: busRoutes[index]?.travelTime,
                        seat: busRoutes[index]?.seat,
                        seat2: busRoutes[index]?.seat2,
                        seat3: busRoutes[index]?.seat3,
                        seat4: busRoutes[index]?.seat4,
                        seat5: busRoutes[index]?.seat5,
                        seat6: busRoutes[index]?.seat6,
                        seat7: busRoutes[index]?.seat7,
                        seat8: busRoutes[index]?.seat8,
                        seat9: busRoutes[index]?.seat9,
                        seat10: busRoutes[index]?.seat10,
                        seat11: busRoutes[index]?.seat11,
                        seat12: busRoutes[index]?.seat12,
                        seat13: busRoutes[index]?.seat13,
                        seat14: busRoutes[index]?.seat14,
                        seat15: busRoutes[index]?.seat15,
                        seat16: busRoutes[index]?.seat16,
                        seat17: busRoutes[index]?.seat17,
                        seat18: busRoutes[index]?.seat18,
                        seat19: busRoutes[index]?.seat19,
                        seat20: busRoutes[index]?.seat20,
                        seat21: busRoutes[index]?.seat21,
                        seat22: busRoutes[index]?.seat22,
                        seat23: busRoutes[index]?.seat23,
                        seat24: busRoutes[index]?.seat24,
                        seat25: busRoutes[index]?.seat25,
                        seat26: busRoutes[index]?.seat26,
                        seat27: busRoutes[index]?.seat27,
                        seat28: busRoutes[index]?.seat28,
                        seat29: busRoutes[index]?.seat29,
                        seat30: busRoutes[index]?.seat30,
                        seat31: busRoutes[index]?.seat31,
                        seat32: busRoutes[index]?.seat32,
                        seat33: busRoutes[index]?.seat33,
                        seat34: busRoutes[index]?.seat34,
                        seat35: busRoutes[index]?.seat35,
                        seat36: busRoutes[index]?.seat36,
                      );
                    },
                  ),
                ),
              ),
          Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 28.0, horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Popular Bus Companies ',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 3.0),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 3.0),
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(children: <Widget>[
                    _buildPopularBusCompany('assets/images/babyCoach.png',
                        'Baby Coaches', babyCoachesDescription, context),
                    SizedBox(width: 6.0),
                    _buildPopularBusCompany('assets/images/gagaCoach.png',
                        'Gaga Coaches', babyCoachesDescription, context),
                    SizedBox(width: 6.0),
                    _buildPopularBusCompany('assets/images/tesoCoach.png',
                        'Teso Coaches', babyCoachesDescription, context),
                    SizedBox(width: 6.0),
                    _buildPopularBusCompany('assets/images/horizonCoach.png',
                        'Horizon Buses', babyCoachesDescription, context)
                  ]),
                ),
              ),
              SizedBox(height: 45.0),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'Safety tips',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 35.0),
              Container(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  itemCount: sliderSafetyTips.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(sliderSafetyTips[index]),
                              fit: BoxFit.cover)),
                    );
                  },
                ),
              ),
              
              SizedBox(height: 100.0),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularBusCompany(
      String image, String category, String description, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PopularBusCompanyDetails(
                  title: category,
                  imageCover: image,
                  description: description))),
      child: Column(
        children: [
          Container(
            width: 220,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fitWidth)),
          ),
          SizedBox(height: 10.0),
          Text(category, style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

