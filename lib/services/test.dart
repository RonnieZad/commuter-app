import 'package:commuter/constants/sercrets.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

main() {
  String url = "https://sandbox.momodeveloper.mtn.com/collection/token/";
  const threshold = const Duration(seconds: 2);
  new Timer.periodic(threshold, (Timer t) => startTransaction('url', ''));
  //print('hello');
}

startTransaction(String amountToPay, String clientPhone) async {
  //  var ref = randomNumeric(4);
  String url =
      "https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay";
  Map map = {
    "amount": amountToPay,
    "currency": "EUR",
    "externalId": 'ref',
    "payer": {"partyIdType": "MSISDN", "partyId": clientPhone},
    "payerMessage": "Payment for your Bus Ticket",
    "payeeNote": "Thank you for using Commuter"
  };

  apiRequest(url, map);
}

Future apiRequest(String url, Map jsonMap) async {
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
    print('Transaction is successful');
  } else {
    //   successful = true;
  }

  //return successful;
}

Future<String> tokenRequest(String url) async {
  var uuid = Uuid();
  bool isPreserveHeaderCase = true;

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

  request.headers
      .set('Authorization', uuid, preserveHeaderCase: isPreserveHeaderCase);

  request.headers.set(
      'Ocp-Apim-Subscription-Key', Secrets.MTN_MOMO_SUBSCRIPTION_KEY,
      preserveHeaderCase: isPreserveHeaderCase);
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
    //  successful = true;
  }

  return 'successful';
}

// Future<String> tokenRequest(String url) async {
//   var uuid = Uuid();
//   bool isPreserveHeaderCase = true;

//   HttpClient httpClient = new HttpClient();
//   HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

//   request.headers
//       .set('Authorization', uuid, preserveHeaderCase: isPreserveHeaderCase);

//   request.headers.set(
//       'Ocp-Apim-Subscription-Key', Secrets.MTN_MOMO_SUBSCRIPTION_KEY,
//       preserveHeaderCase: isPreserveHeaderCase);
//   HttpClientResponse response = await request.close();

//   String reply = await response.transform(utf8.decoder).join();
//   httpClient.close();
//   print(response.reasonPhrase);
//   print("${response.statusCode}");

//   print(request.headers);
//   print("${response.statusCode}");
//   if (response.statusCode == 200) {
//     print('Transaction is successful');
//   } else {}

//   return reply;
// }
