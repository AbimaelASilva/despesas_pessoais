import 'dart:async';

import 'package:despesas_pessoais/app/generalUse/formateDate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Timer? timer;

class GenericController extends GetxController {
  final myBlackColor = Color(0xAA2C061F);
  final myOrangeColor = Color(0xAAD89216);
  String myTime = '';
  updaHourMinute() {
    String hourAdjuste = DateTime.now().hour < 10 ? '0' : '';
    myTime = '$hourAdjuste${DateTime.now().hour}h:${DateTime.now().minute}m';

    // print(myTime);

    update();
    Timer.periodic(Duration(minutes: 1), (Timer t) => updaHourMinute());
  }

/*
  initializeClock() {
    updaHourMinute();
    Timer.periodic(Duration(minutes: 1), (Timer t) => updaHourMinute());
  }
  */
}
