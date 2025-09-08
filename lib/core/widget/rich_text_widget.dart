import 'package:clean_architucture/core/extension/string_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle? textStyle;
  final TextStyle? highlightStyle;
  final VoidCallback? onTap;

  const CustomRichText({
    super.key,
    required this.text,
    required this.highlight,
    this.textStyle,
    this.highlightStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.titleCase,
            style: textStyle ?? DefaultTextStyle.of(context).style,
          ),

          TextSpan(
            text: ' $highlight'.titleCase,
            style:
                highlightStyle ??
                TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.gradient1,
                ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
