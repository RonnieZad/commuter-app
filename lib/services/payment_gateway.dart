import 'package:commuter/constants/sercrets.dart';
import 'package:commuter/utils/customToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class PaymentGateway {
  PaymentGateway._privateConstructor();

  static final PaymentGateway instance = PaymentGateway._privateConstructor();

  generateToken() {
    String url = "https://sandbox.momodeveloper.mtn.com/collection/token/";

    var query_params = {
      "Authorization": 'c82df4eb-3c22-4f4c-88a1-3f4dead34b86',
      "Ocp-Apim-Subscription-Key": 'c82df4eb-3c22-4f4c-88a1-3f4dead34b86',
      "token_type": 'token_type'
    };
    //const threshold = const Duration(seconds: 1);
    //  new Timer.periodic(threshold, (Timer t) => tokenRequest(url, query_params));
    tokenRequest(url, query_params);
  }

  bool successful = false;
  List<SubAccount> subAccounts = [];

  startTransaction(String amountToPay, String clientPhone) async {
    var ref = randomNumeric(4);
    String url =
        "https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay";
    Map map = {
      "amount": amountToPay,
      "currency": "EUR",
      "externalId": ref,
      "payer": {"partyIdType": "MSISDN", "partyId": clientPhone},
      "payerMessage": "Payment for your Bus Ticket",
      "payeeNote": "Thank you for using Commuter"
    };

    apiRequest(url, map);
  }

  Future<String> tokenRequest(String url, Map data) async {
    var uuid = Uuid();
    bool isPreserveHeaderCase = true;
    String requestId = uuid.v4();
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

    request.headers.set('Authorization', requestId,
        preserveHeaderCase: isPreserveHeaderCase);
    request.headers.set(
        'Ocp-Apim-Subscription-Key', Secrets.MTN_MOMO_SUBSCRIPTION_KEY,
        preserveHeaderCase: isPreserveHeaderCase);
    request.add(utf8.encode(json.encode(data)));
    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(response.reasonPhrase);
    print("${response.statusCode}");

    print(request.headers);
    print("${response.statusCode}");
    if (response.statusCode == 200) {
      print('Transaction is successful');
    } else {
      successful = true;
    }

    return reply;
  }

  Future<bool> apiRequest(String url, Map jsonMap) async {
    var uuid = Uuid();
    bool isPreserveHeaderCase = true;
    String requestId = uuid.v4();
    String auth = 'Bearer ' + Secrets.MTN_MOMO_AUTH_TOKEN;
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('Content-Type', 'application/json',
        preserveHeaderCase: isPreserveHeaderCase);
    request.headers
        .set('Authorization', auth, preserveHeaderCase: isPreserveHeaderCase);
    request.headers.set('X-Target-Environment', Secrets.MTN_MOMO_ENVIRONMENT,
        preserveHeaderCase: isPreserveHeaderCase);
    request.headers.set('X-Reference-Id', requestId,
        preserveHeaderCase: isPreserveHeaderCase);
    request.headers.set(
        'Ocp-Apim-Subscription-Key', Secrets.MTN_MOMO_SUBSCRIPTION_KEY,
        preserveHeaderCase: isPreserveHeaderCase);
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();

    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(response.reasonPhrase);
    print("${response.statusCode}");
    print("${response.headers}");
    print("${response.connectionInfo}");
    print(request.headers);
    print("${response.statusCode}");
    if (response.statusCode == 200) {
      CustomToast.instance.showToast(
          'MTN MOMO Transaction is successful ', Colors.green, Colors.white);
      print('Transaction is successful');
    } else {
      successful = true;
    }

    return successful;
  }

  void startPayment(
      BuildContext context, String amountToPay, String userPhone) async {
    var initializer = RavePayInitializer(
        amount: double.parse(amountToPay),
        email: 'zadcorna@gmmail.com',
        userPhone: userPhone,
        publicKey: Secrets.FLUTTERWAVE_PUBLIC_KEY,
        encryptionKey: Secrets.FLUTTERWAVE_ENCRYPTION_KEY,
        subAccounts: subAccounts.isEmpty ? null : null)
      ..redirectUrl
      ..acceptCardPayments = true
      ..acceptUgMobileMoneyPayments = true
      ..displayEmail = true
      ..displayAmount = true
      ..staging = false
      ..displayFee = true
      ..email = 'zadcorna@gmmail.com'
      ..fName = 'firstName'
      ..lName = 'lastName'
      ..narration = 'narration' ?? ''
      ..txRef = 'refPaymentNo'
      ..country = 'UG'
      ..currency = 'UGX'
      ..companyLogo = Image.asset(
        'assets/images/icon_launcher.png',
        scale: 1,
      )
      ..companyName = Text(
        'Commuter',
        style: TextStyle(color: Colors.black, fontFamily: 'Product sans'),
      )
      ..orderRef = 'orderRef';

    var response = await RavePayManager().prompt(
        context: context,
        initializer: initializer,
        onTransactionComplete: (RaveResult raveResult) {
          showCupertinoDialog(
            context: context,
            builder: (context) => new CupertinoAlertDialog(
              title: new Text('Prompt'),
              content: new Text(raveResult?.message),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          );
        });
    print(response);
  }
}
