import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class CustomToast {
  CustomToast._privateConstructor();

  static final CustomToast instance = CustomToast._privateConstructor();

  showToast(String message, Color bgColor, Color textColor) {
    Widget widget = Material(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.transparent,
      elevation: 3.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: 330.0,
          height: 69.0,
          color: bgColor,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Product Sans'),
            ),
          )),
        ),
      ),
    );
    showToastWidget(
      widget,
      position: ToastPosition.top,
      animationCurve: Curves.easeInOut,
      animationBuilder: Miui10AnimBuilder(),
      animationDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 4),
    );
  }

  showLoaderOverlay() {
    Widget loaderOverlay = IgnorePointer(
      child: Container(
        child: SizedBox(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      valueColor: AlwaysStoppedAnimation(
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    showToastWidget(
      loaderOverlay,
      position: ToastPosition.center,
      animationCurve: Curves.easeInOut,
      animationBuilder: Miui10AnimBuilder(),
      animationDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 5),
    );
  }
}
