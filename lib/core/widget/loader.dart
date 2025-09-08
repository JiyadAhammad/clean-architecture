import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/colors.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: AppColors.gradient1,
        size: 200,
        secondRingColor: AppColors.gradient2,
        thirdRingColor: AppColors.gradient3,
      ),
    );
  }
}
