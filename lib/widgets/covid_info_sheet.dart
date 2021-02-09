import 'package:commuter/utils/sheetHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Covid19InfoSheet extends StatefulWidget {
  Covid19InfoSheet({
    Key key,
  }) : super(key: key);

  @override
  _Covid19InfoSheet createState() => _Covid19InfoSheet();
}

class _Covid19InfoSheet extends State<Covid19InfoSheet> {
  bool isDialogPopped = false;

  @override
  Widget build(BuildContext context) {
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
              theme: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                      textStyle: TextStyle(fontFamily: 'Product Sans'))),
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
                        'COVID-19 Guide lines',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle,
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                  height: 600,
                                  width: 400,
                                  child: Image.asset('assets/images/virus.png',
                                      fit: BoxFit.contain)),
                              Positioned(
                                bottom: 0.0,
                                right: 20.0,
                                left: 20.0,
                                child: Container(
                                    height: 600,
                                    width: 400,
                                    child: Image.asset(
                                        'assets/images/virus.png',
                                        fit: BoxFit.contain)),
                              ),
                              Column(children: [
                                SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  'COVID-19 is an acute disease in humans caused by a coronavirus, which is characterized mainly by fever and cough and is capable of progressing to secere symptoms and in some cases death, especialy in older people and those with underlying health conditions. It was originally identified in China in 2019 and became pandemic in 2020',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Product Sans',
                                      fontSize: 18.0,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 18.0,
                                ),
                                Text(
                                  'Signs & Symptoms',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Product Sans',
                                      fontSize: 26.0,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 130.0,
                                      height: 130.0,
                                      child: Image.asset(
                                        'assets/images/cough.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'COUGH, ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .color,
                                                fontFamily: 'Product Sans'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'this one of the major signs of COVID-19, however this might not the be case with sympotomatic persons. Visit a doctor if you experience  ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' sore throat, shortness of breath ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text: 'and ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text: ' chest pain',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'FEVER, ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .color,
                                                fontFamily: 'Product Sans'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'after 2-14 days after exposure to the virus   ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text: ' you may experience ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text:
                                                    'fever or chill, fatigue, muscle or body aches',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text:
                                                    '. You may wan to visit a doctor if you see these signs',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: 130.0,
                                      height: 130.0,
                                      child: Image.asset(
                                        'assets/images/fever.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 130.0,
                                      height: 130.0,
                                      child: Image.asset(
                                        'assets/images/headache.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'HEADACHE, ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .color,
                                                fontFamily: 'Product Sans'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'migraines that last forever could be the other sign. Other symptoms may include ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' congestion or runny nose, vomiting, new loss of taste or smell ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                              TextSpan(
                                                text: 'and ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18.0,
                                ),
                                Text(
                                  'Prevention & Control',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Product Sans',
                                      fontSize: 26.0,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 14.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 130.0,
                                      height: 130.0,
                                      child: Image.asset(
                                        'assets/images/wash_hands.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'WEAR MASK, ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .color,
                                                fontFamily: 'Product Sans'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'wear a mask when physical distancing is not possible. Don\'t touch your eyes, nose or mouth. Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'WASH HANDS, ',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .color,
                                                fontFamily: 'Product Sans'),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'clean your hands often. Use soap and a lot of  water, or an alcohol-based hand rub. Stay home if you feel unwell ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    fontFamily: 'Product Sans'),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      width: 130.0,
                                      height: 130.0,
                                      child: Image.asset(
                                        'assets/images/wear_mask.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text:
                                          'This information is brought to you by the\n',
                                      style: TextStyle(
                                          fontFamily: 'Product Sans',
                                          fontSize: 16.0,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Ministry of Health',
                                            style: TextStyle(
                                                fontFamily: 'Product Sans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.black),
                                            children: <TextSpan>[])
                                      ]),
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                  onTap: _launchURL,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Visit ',
                                      style: TextStyle(
                                          fontFamily: 'Product Sans',
                                          fontSize: 16.0,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              'https://www.health.go.ug/covid',
                                          style: TextStyle(
                                              fontFamily: 'Product Sans',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber),
                                        ),
                                        TextSpan(
                                          text: ' for more information',
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        elevation: 6.0,
                                        child: Container(
                                          height: 80.0,
                                          child: CupertinoButton(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            onPressed: () {
                                              HapticFeedback.selectionClick();
                                              Navigator.pop(context);
                                            },
                                            color: Colors.amber,
                                            child: Text(
                                              'OK, I understand',
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
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                              ]),
                            ],
                          ),
                        ),
                      )
                    ]))
                  ]),
            ),
          ),
        );
      },
    );
  }

  _launchURL() async {
    const url = 'https://www.health.go.ug/covid';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
