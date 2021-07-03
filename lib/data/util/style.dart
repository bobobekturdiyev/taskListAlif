import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_list_alif/data/util/colors.dart';

class MyTextStyle {
  static final TextStyle ubuntuBold = TextStyle(
    fontFamily: 'UbuntuBold',
    fontSize: 14,
    color: MyColors.white,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle ubuntuMedium = TextStyle(
    fontFamily: 'UbuntuMedium',
    fontSize: 14,
    color: MyColors.white,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle ubuntuRegular = TextStyle(
    fontFamily: 'UbuntuRegular',
    fontSize: 14,
    color: MyColors.white,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle ubuntuLight = TextStyle(
    fontFamily: 'UbuntuLight',
    fontSize: 14,
    color: MyColors.white,
    fontWeight: FontWeight.w300,
  );
}
