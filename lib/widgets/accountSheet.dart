import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commuter/services/otp_input.dart';
import 'package:commuter/services/user_mgt_service.dart';
import 'package:commuter/utils/shared_prefs.dart';
import 'package:commuter/utils/sheetHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AccountSheet extends StatefulWidget {
  AccountSheet._privateConstructor();
  static final AccountSheet instance = AccountSheet._privateConstructor();

  AccountSheet({
    Key key,
  }) : super(key: key);

  @override
  _AccountSheet createState() => _AccountSheet();
}

class _AccountSheet extends State<AccountSheet> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isDialogPopped = false;
  bool showMessageBox = false;
  bool showOTP = false;
  bool isValid = false;
  bool isCodeSent = false;
  String _verificationId;
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerPhone = TextEditingController();
  TextEditingController textEditingControllerLocay = TextEditingController();

  TextEditingController _pinEditingController = TextEditingController();
  PageController pageController = PageController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    onVerifyCode();
  }

  Future<Null> validate(StateSetter updateState) async {
    print("validate phone : ${_phoneNumberController.text.length}");
    if (_phoneNumberController.text.length == 9) {
      updateState(() {
        isValid = true;
      });
    }
  }

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
                        'Create Account',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle,
                      ),
                      trailing: CupertinoButton(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Product Sans'),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter state) {
                            return PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Get Started!',
                                        style: TextStyle(
                                            fontSize: 44.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Product Sans'),
                                      ),
                                      Text(
                                        'Sign up using phone number',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontFamily: 'Product Sans'),
                                      ),
                                      SizedBox(
                                        height: 200.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 60.0,
                                          child: CupertinoTextField(
                                            prefix: Icon(
                                                Icons.phone_android_rounded),
                                            placeholder: 'Phone number',
                                            controller:
                                                textEditingControllerPhone,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.cyan.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            onSubmitted: (_) {
                                              onVerifyCode();
                                              if (isValid) {
                                                setState(() {
                                                  showOTP = true;
                                                });
                                                onVerifyCode();
                                              } else {
                                                validate(state);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'A verification code is going to be sent to you',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Product Sans'),
                                        ),
                                      ),
                                      SizedBox(height: 245.0),
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
                                                      BorderRadius.circular(
                                                          20.0),
                                                  onPressed: () {
                                                    onVerifyCode();
                                                    if (isValid) {
                                                      setState(() {
                                                        showOTP = true;
                                                      });
                                                      onVerifyCode();
                                                    } else {
                                                      validate(state);
                                                    }
                                                    HapticFeedback
                                                        .selectionClick();
                                                    pageController.nextPage(
                                                      curve: Curves.decelerate,
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                    );
                                                  },
                                                  color: Colors.amber,
                                                  child: Text(
                                                    'Sign up',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        fontFamily:
                                                            'Product Sans'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Get Started!',
                                        style: TextStyle(
                                            fontSize: 44.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Product Sans'),
                                      ),
                                      Text(
                                        'Sign up using phone number',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontFamily: 'Product Sans'),
                                      ),
                                      SizedBox(
                                        height: 200.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 80,
                                          child: PinInputTextField(
                                            pinLength: 6,
                                            decoration: BoxLooseDecoration(
                                                strokeColor: Colors.amber,
                                                hintText: '000000'),
                                            controller: _pinEditingController,
                                            autoFocus: false,
                                            textInputAction:
                                                TextInputAction.done,
                                            onSubmit: (pin) {
                                              if (pin.length == 6) {
                                                onFormSubmitted();
                                              } else {
                                                ///    showToast("You entered a wrong verification code", Colors.lightBlue);
                                                Toast.show(
                                                    'You entered a wrong verification code',
                                                    context,
                                                    duration: 2,
                                                    backgroundColor: Colors.red,
                                                    backgroundRadius: 12);
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Enter verification code to create your profile',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Product Sans'),
                                        ),
                                      ),
                                      SizedBox(height: 245.0),
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
                                                      BorderRadius.circular(
                                                          20.0),
                                                  onPressed: () {
                                                    if (_pinEditingController
                                                            .text.length ==
                                                        6) {
                                                      onFormSubmitted();
                                                    } else {
                                                      Toast.show(
                                                          'You entered a wrong verification code',
                                                          context,
                                                          duration: 2,
                                                          backgroundColor:
                                                              Colors.red,
                                                          backgroundRadius: 12);
                                                    }
                                                    HapticFeedback
                                                        .selectionClick();

                                                    pageController.nextPage(
                                                      curve: Curves.decelerate,
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                    );
                                                  },
                                                  color: Colors.amber,
                                                  child: Text(
                                                    'Continue',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        fontFamily:
                                                            'Product Sans'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                Column(children: [
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Container(
                                    width: 200.0,
                                    height: 200.0,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                        'assets/images/joanne.jpg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60.0,
                                      child: CupertinoTextField(
                                        prefix: Icon(Icons.person),
                                        controller: textEditingControllerName,
                                        placeholder: 'Name',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60.0,
                                      child: CupertinoTextField(
                                        prefix:
                                            Icon(Icons.location_city_rounded),
                                        controller: textEditingControllerLocay,
                                        placeholder: 'Address',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 245.0),
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
                                                UserProfileService.instance
                                                    .createRecord(
                                                  context,
                                                  textEditingControllerName
                                                      .text,
                                                  //_uploadedFileURL,
                                                  textEditingControllerLocay
                                                      .text,
                                                );
                                              },
                                              color: Colors.green,
                                              child: Text(
                                                'Finish',
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
                                  )
                                ]),
                              ],
                            );
                          }),
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

  void onVerifyCode() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    //bool _hasAccount = (preference.getBool('hasAccount') ?? false);
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          Toast.show('Error validating OTP', context,
              duration: 2, backgroundColor: Colors.red, backgroundRadius: 12);
          // if (_hasAccount) {
          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //       builder: (context) => CreateAccount(),
          //   //     ));
          // } else {
          //   // Navigator.pushAndRemoveUntil(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //       builder: (context) => Pager(),
          //   //     ),
          //   //     (Route<dynamic> route) => false);
          // }
        } else {
          Toast.show('Error validating OTP', context,
              duration: 2, backgroundColor: Colors.red, backgroundRadius: 12);
        }
      }).catchError((error) {
        Toast.show('Try again in sometime', context,
            duration: 2, backgroundColor: Colors.red, backgroundRadius: 12);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+2560${textEditingControllerPhone.text}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void onFormSubmitted() async {
    SharedPreferences preference = await SharedPreferences.getInstance();

    bool _hasAccount = (preference.getBool('hasAccount') ?? false);
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) {
      if (value.user != null) {
        print(value.user.displayName);
        Toast.show('Error validating OTP', context,
            duration: 2, backgroundColor: Colors.red, backgroundRadius: 12);
        // if (_hasAccount) {
        //   // Navigator.push(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //       builder: (context) => CreateAccount(),
        //   //     ));
        // } else {
        //   // Navigator.pushAndRemoveUntil(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //       builder: (context) => Pager(),
        //   //     ),
        //   //     (Route<dynamic> route) => false);
        // }
      } else {
        Toast.show('Error validating verification code, try again', context,
            duration: 2, backgroundColor: Colors.red, backgroundRadius: 12);
      }
    }).catchError((error) {
      Toast.show('Sorry, Something went wrong', context,
          duration: 2, backgroundColor: Colors.red, backgroundRadius: 12);
    });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    String imagePath = pickedFile.path;

    setState(() {
      if (pickedFile != null) {
        // _image = File(pickedFile.path);
        // _uploadedFileURL = imagePath;
        // // thumbnail = Img.copyResize(Img.decodeImage(_image.readAsBytesSync()),
        // //     width: 120);
        print(imagePath);
      } else {
        print('No image selected.');
      }
    });
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    Key key,
    @required this.textEditingController,
  }) : super(key: key);

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 65.0,
        child: CupertinoTextField(
          controller: textEditingController,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.cyan.shade200,
              borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    );
  }
}

class ProfileSheet extends StatefulWidget {
  ProfileSheet._privateConstructor();
  static final AccountSheet instance = AccountSheet._privateConstructor();

  ProfileSheet({
    Key key,
  }) : super(key: key);

  @override
  _ProfileSheet createState() => _ProfileSheet();
}

class _ProfileSheet extends State<ProfileSheet> {
  bool isDialogPopped = false;

  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerLocay = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            textEditingControllerEmail.text =
                prefValue.getString('email') ?? '';
          })
        });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    String imagePath = pickedFile.path;

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // _uploadedFileURL = imagePath;
        // // thumbnail = Img.copyResize(Img.decodeImage(_image.readAsBytesSync()),
        // //     width: 120);
        print(imagePath);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    textEditingControllerName.text = user.displayName;
    textEditingControllerLocay.text = user.photoUrl;

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
                              'Profile Information',
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .navLargeTitleTextStyle,
                            ),
                            trailing: CupertinoButton(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Product Sans'),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(children: [
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  GestureDetector(
                                    onTap: getImage,
                                    child: Container(
                                      width: 200.0,
                                      height: 200.0,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          'assets/images/joanne.jpg',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60.0,
                                      child: CupertinoTextField(
                                        prefix: Icon(Icons.person),
                                        controller: textEditingControllerName,
                                        placeholder: 'Name',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60.0,
                                      child: CupertinoTextField(
                                        prefix: Icon(Icons.email_rounded),
                                        controller: textEditingControllerEmail,
                                        placeholder: 'Email',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60.0,
                                      child: CupertinoTextField(
                                        prefix:
                                            Icon(Icons.location_city_rounded),
                                        controller: textEditingControllerLocay,
                                        placeholder: 'Address',
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.cyan.shade200,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 245.0),
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
                                                UserProfileService.instance
                                                    .createRecord(
                                                  context,
                                                  textEditingControllerName
                                                      .text,
                                                  textEditingControllerLocay
                                                      .text,
                                                );
                                                SharedPreferencesUtil.instance
                                                    .setStringValue(
                                                        'email',
                                                        textEditingControllerEmail
                                                            .text);
                                                Navigator.pop(context);
                                                print(user.uid);
                                              },
                                              color: Colors.green,
                                              child: Text(
                                                'Update',
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
                                  )
                                ]),
                              ),
                            )
                          ]))
                        ]))));
      },
    );
  }
}
