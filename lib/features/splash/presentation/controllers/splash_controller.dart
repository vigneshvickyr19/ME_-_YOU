import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_routes.dart';

class SplashController {
  static void navigateToHome(BuildContext context) {
    Timer(const Duration(milliseconds: 2200), () {
      Navigator.pushReplacementNamed(context, AppRoutes.getStarted);
    });
  }
}
