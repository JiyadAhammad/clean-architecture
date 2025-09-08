import 'package:flutter/material.dart';

import '../enums/error_enums.dart';
import '../theme/colors.dart';
import '../widget/text_widget.dart';

void showSnackBar(
  BuildContext context, {
  required ErrorEnums errorType,
  required String content,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (errorType == ErrorEnums.success) ...{
              Icon(Icons.check, color: AppColors.success),
            } else if (errorType == ErrorEnums.error) ...{
              Icon(Icons.clear, color: AppColors.error),
            } else ...{
              Icon(Icons.error, color: AppColors.alert),
            },
            Expanded(child: TextWidget(content)),
          ],
        ),
      ),
    );
}
