import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'nav_item.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.home,
            label: "Home",
            isActive: currentIndex == 0,
            onTap: () => onChanged(0),
          ),
          NavItem(
            icon: Icons.chat_bubble_outline,
            label: "Chat",
            isActive: currentIndex == 1,
            onTap: () => onChanged(1),
          ),
          NavItem(
            icon: Icons.person_outline,
            label: "Profile",
            isActive: currentIndex == 2,
            onTap: () => onChanged(2),
          ),
        ],
      ),
    );
  }
}
