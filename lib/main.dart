import 'dart:ui';

import 'package:commuter/screens/my_tickets.dart';
import 'package:commuter/screens/settings.dart';
import 'package:commuter/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:commuter/screens/main_screen.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'models/bus_route_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    OKToast(
        animationCurve: Curves.easeIn,
        animationBuilder: Miui10AnimBuilder(),
        animationDuration: Duration(milliseconds: 200),
        duration: Duration(seconds: 3),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
        StreamProvider<List<BusRouteModel>>.value(
          value: DatabaseClient().getbuses,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Commuter',
          theme: ThemeData(
            brightness: Brightness.light,
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                   TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            ),
            primarySwatch: Colors.cyan,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Mainpage(),
        ),
      ),
    );
  }
}

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currntPage = 0;
  var pages = [new MainScreen(), new MyTicketsPage(), new SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[pages[currntPage], _appbottombar()],
      ),
    );
  }

  Widget _appbottombar() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: BottomNavigationBar(
            elevation: 22.0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black26,
            unselectedFontSize: 12,
            currentIndex: currntPage,
            items: [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home, color: Colors.black),
                title: Text('Home',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'Product Sans')),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_giftcard_rounded, color: Colors.black),
                  title: Text('Tickets',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'Product Sans'))),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings, color: Colors.black),
                  title: Text('Settings',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'Product Sans'))),
            ],
            iconSize: 24,
            selectedLabelStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.white,
            onTap: (int index) {
              setState(() {
                currntPage = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
