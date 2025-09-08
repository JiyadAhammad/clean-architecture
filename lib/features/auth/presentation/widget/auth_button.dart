import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widget/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.onTap,
    this.buttonActive = false,
    this.isLoading = false,
    this.buttonText = 'Continue',
    super.key,
  });

  final VoidCallback onTap;
  final bool isLoading;
  final String buttonText;
  final bool buttonActive;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = isLoading ? 50 : constraints.maxWidth;

        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width,
            height: 50,
            curve: Curves.easeInOut,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonActive
                    ? AppColors.greyColor
                    : AppColors.gradient2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isLoading ? 25 : 12),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: isLoading ? null : onTap,
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axis: Axis.horizontal,
                      child: child,
                    ),
                  );
                },
                child: isLoading
                    ? const Center(
                        child: SizedBox(
                          key: ValueKey('loader'),
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : Center(
                        child: TextWidget(
                          buttonText,
                          key: const ValueKey('text'),
                          textAlign: TextAlign.center,
                          color: AppColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
