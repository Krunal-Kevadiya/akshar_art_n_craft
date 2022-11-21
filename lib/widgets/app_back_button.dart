import 'package:flutter/material.dart';

import '../themes/themes.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({required this.isFullScreen, super.key});
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 25.s,
        color: isFullScreen ? AppColors.black : AppColors.white,
      ),
      onPressed: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
