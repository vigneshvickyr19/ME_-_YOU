import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/app_snackbar.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final TextEditingController _codeController = TextEditingController();
  bool _showError = false;
  bool _isButtonEnabled = false;

  void _validateCode(String value) {
    setState(() {
      _isButtonEnabled = value.trim().length == 6; // assuming 6-digit code
      _showError = value.isNotEmpty && !_isButtonEnabled;
    });
  }

  void _onSubmit() {
    final code = _codeController.text.trim();
    if (!_isButtonEnabled) {
      setState(() => _showError = true);
      AppSnackbar.show(
        context,
        message: "Please enter a valid 6-digit code",
        type: SnackbarType.error,
      );
      return;
    }

    // Navigate to create password page
    Navigator.pushNamed(context, AppRoutes.createPassword);
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: AppBackButton(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Verify Code",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Enter the 6-digit code sent to your email.",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 32),
            AppInput(
              label: "Verification Code",
              hint: "Enter code",
              controller: _codeController,
              showError: _showError,
              errorMessage: "Invalid code",
              onChanged: _validateCode,
            ),
            const Spacer(),
            AppButton(
              text: "Verify",
              onPressed: _onSubmit,
              isEnabled: _isButtonEnabled,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
