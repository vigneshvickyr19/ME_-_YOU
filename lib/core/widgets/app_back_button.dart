import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppBackButton extends StatelessWidget {
  /// If routeName is null → Navigator.pop()
  /// If routeName is provided → Navigator.pushReplacementNamed()
  final String? routeName;

  const AppBackButton({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (routeName != null) {
          Navigator.pushReplacementNamed(context, routeName!);
        } else {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: 18,
        ),
      ),
    );
  }
}
