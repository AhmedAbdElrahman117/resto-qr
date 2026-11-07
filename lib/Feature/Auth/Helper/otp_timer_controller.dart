import 'dart:async';

import 'package:flutter/material.dart';

class OtpTimerController extends ValueNotifier<int> {
  OtpTimerController() : super(30);

  int tries = 1;
  Timer? timer;

  void checkTriesCount() {
    if (tries > 0 && tries <= 2) {
      value = 30;
    } else if (tries > 2 && tries <= 4) {
      value = 60;
    } else if (tries > 4 && tries <= 5) {
      value = 120;
    } else {
      value = 180;
    }
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(
      .new(milliseconds: 800),
      (time) {
        if (value > 0) {
          value--;
        } else {
          time.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
