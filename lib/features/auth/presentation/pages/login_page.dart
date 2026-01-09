import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showEmailError = false;
  bool _showPasswordError = false;
  bool _isButtonEnabled = false;

  void _validateInputs() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    setState(() {
      _showEmailError = email.isNotEmpty && !emailRegex.hasMatch(email);
      _showPasswordError = password.isNotEmpty && password.length < 6;
      _isButtonEnabled = emailRegex.hasMatch(email) && password.length >= 6;
    });
  }

  void _onSubmit() {
    if (!_isButtonEnabled) {
      _validateInputs();
      AppSnackbar.show(
        context,
        message: "Please fix the errors before continuing",
        type: SnackbarType.error,
      );
      return;
    }

    AppSnackbar.show(
      context,
      message: "Login successful",
      type: SnackbarType.success,
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: AppBackButton(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              const Text(
                "Login with email",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Enter your credentials to access your account.",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Email
              AppInput(
                label: "Email",
                hint: "Enter your email",
                controller: _emailController,
                showError: _showEmailError,
                errorMessage: "Invalid email address",
                onChanged: (_) => _validateInputs(),
              ),
              const SizedBox(height: 16),

              // Password
              AppInput(
                label: "Password",
                hint: "Enter password",
                controller: _passwordController,
                showError: _showPasswordError,
                errorMessage: "Password must be at least 6 characters",
                onChanged: (_) => _validateInputs(),
                isPassword: true,
              ),
              const SizedBox(height: 10),

              // Forgot Password (✔️ ADDED & FIXED)
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Continue Button
              AppButton(
                text: "Continue",
                onPressed: _onSubmit,
                isEnabled: _isButtonEnabled,
              ),

              const SizedBox(height: 24),

              // Sign Up text
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.signUp);
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
