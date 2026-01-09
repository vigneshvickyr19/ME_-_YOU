import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_colors.dart';

enum AppButtonType { primary, transparent }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final String? iconPath;
  final bool isEnabled;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.iconPath,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = type == AppButtonType.primary;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(color: AppColors.white.withOpacity(0.15)),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isPrimary ? _buildPrimary() : _buildTransparent(),
      ),
    );
  }

  // ---------- PRIMARY BUTTON ----------
  Widget _buildPrimary() {
    return Ink(
      decoration: BoxDecoration(
        gradient: isEnabled
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.primary, AppColors.secondary],
              )
            : null,
        color: isEnabled ? null : AppColors.darkOverlay, // ✅ HERE
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isEnabled ? AppColors.black : AppColors.greyDark,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // ---------- TRANSPARENT BUTTON ----------
  Widget _buildTransparent() {
    return Container(
      decoration: BoxDecoration(
        color: isEnabled
            ? Colors.transparent
            : AppColors.darkOverlay, // ✅ HERE also
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null) ...[
            SvgPicture.asset(iconPath!, height: 20),
            const SizedBox(width: 12),
          ],
          Text(
            text,
            style: TextStyle(
              color: isEnabled ? AppColors.white : AppColors.greyDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
