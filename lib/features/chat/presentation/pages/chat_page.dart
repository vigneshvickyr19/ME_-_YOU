import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Chat Page", style: TextStyle(color: AppColors.white)),
    );
  }
}
