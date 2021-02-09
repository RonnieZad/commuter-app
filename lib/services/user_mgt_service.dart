import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileService {
  UserProfileService._privateConstructor();

  static final UserProfileService instance =
      UserProfileService._privateConstructor();

  createRecord(
    BuildContext context,
    String firstName,
    String address,
  ) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var uid = user.uid;
    var phoneNumber = user.phoneNumber;
    final databaseReference = Firestore.instance;

    await databaseReference.collection("UserData").document(uid).setData({
      'first_name': firstName,
      'phoneNumber': phoneNumber,
      'address': address,
    });

    FirebaseAuth.instance.currentUser().then((val) {
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.displayName = firstName;
      updateUser.photoUrl = address;

      val.updateProfile(updateUser);
      user.reload();
    });
  }
}
