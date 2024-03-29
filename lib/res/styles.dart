import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppStyles {
  static var addressBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.00),
    borderSide: const BorderSide(color: AppColors.grey),
  );
  static var underLineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  );

  static var focusedTransparentBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.00),
    borderSide: const BorderSide(color: Colors.transparent),
  );
  static var energyBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.00),
    borderSide: const BorderSide(color: Colors.transparent),
  );
}

errorTextStyle(context) => TextStyle(
    fontSize: 10,
    color: Theme.of(context).errorColor,
    fontWeight: FontWeight.w500,
    height: 1.4);