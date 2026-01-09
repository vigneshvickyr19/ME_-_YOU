import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum SnackbarType { success, error, warning, info }

class AppSnackbar {
  /// Show an animated custom snackbar
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Determine icon and color
    Color backgroundColor;
    IconData iconData;
    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors.success;
        iconData = Icons.check_circle;
        break;
      case SnackbarType.error:
        backgroundColor = AppColors.error;
        iconData = Icons.error;
        break;
      case SnackbarType.warning:
        backgroundColor = AppColors.warning;
        iconData = Icons.warning;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = AppColors.info;
        iconData = Icons.info;
        break;
    }

    // Create overlay entry
    final overlay = OverlayEntry(
      builder: (context) {
        return _AnimatedSnackbar(
          message: message,
          icon: iconData,
          backgroundColor: backgroundColor,
          actionLabel: actionLabel,
          onAction: onAction,
          duration: duration,
        );
      },
    );

    // Insert overlay
    Overlay.of(context).insert(overlay);

    // Remove after duration + animation
    Future.delayed(duration + const Duration(milliseconds: 500), () {
      overlay.remove();
    });
  }
}

class _AnimatedSnackbar extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Duration duration;

  const _AnimatedSnackbar({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    this.actionLabel,
    this.onAction,
    required this.duration,
  });

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.0), // start off-screen bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Auto-reverse after duration
    Future.delayed(widget.duration, () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: AppColors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (widget.actionLabel != null && widget.onAction != null)
                    TextButton(
                      onPressed: widget.onAction,
                      child: Text(
                        widget.actionLabel!,
                        style: const TextStyle(color: AppColors.white),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
