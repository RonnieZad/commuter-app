import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:commuter/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget buildFAQ(String question, String answer) {
      return InkWell(
        borderRadius: BorderRadius.circular(14.0),
        onTap: () {
          showModalBottomSheet(
            barrierColor: Colors.black26,
            isDismissible: true,
            elevation: 30.0,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.0),
                  topRight: Radius.circular(22.0)),
            ),
            builder: (BuildContext context) {
              return Container(
                width: size.width,
                height: size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22.0),
                        topRight: Radius.circular(22.0)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Frequently Asked Questions',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Product Sans',
                            fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        question,
                        style: TextStyle(
                            fontFamily: 'Product Sans', fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        answer,
                        style: TextStyle(
                            fontFamily: 'Product Sans', fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      );
    }

    Widget talkToUs(String title, Icon icon, Function action) {
      return InkWell(
        borderRadius: BorderRadius.circular(14.0),
        onTap: action,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              icon,
              SizedBox(
                width: 14.0,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(      
      body: Column(
        children: [
          SizedBox(height: 80.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Settings',
                style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Product Sans'),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(CupertinoIcons.settings_solid, size: 42.0)
            ],
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Find quick info to help you on your travel experience here',
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontFamily: 'Product Sans',
              ),
            ),
          ),
          SizedBox(height: 10.0),
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
                    'Frequently Asked Questions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          buildFAQ('1.  How do I make an order', frequentlyASkedQuestions[0]),
          buildFAQ(
              '2.  How do I see my Ticket?', frequentlyASkedQuestions[1]),
          buildFAQ('3.  How do I pay?', frequentlyASkedQuestions[2]),
          SizedBox(height: 10.0),
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
                    'Talk to us',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.0),
          talkToUs('Call', Icon(Icons.call), () {
            launch("tel:0776703612");
          }),
          talkToUs(
              'Send a message',
              Icon(
                Icons.message,
              ), () {
            launch("sms:0776703612");
          }),
          talkToUs('Whatsapp', Icon(CupertinoIcons.chat_bubble), () async {
            var phone = 256702703612;
            await launch(
                "https://wa.me/$phone?text=Hello there, I have got an inquiry to raise");
          }),
          Spacer(),
          Text(
            'Commuter V.1.0.0 ',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Product Sans'),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }
}
