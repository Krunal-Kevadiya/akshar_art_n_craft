import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './app_back_button.dart';
import '../themes/themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.isFullScreen = false,
    this.isBackAllow = false,
    // ignore: avoid_field_initializers_in_const_classes
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String? title;
  final bool isFullScreen;
  final bool isBackAllow;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor:
          isFullScreen ? AppColors.transparent : AppColors.primaryColor,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: isBackAllow ? AppBackButton(isFullScreen: isFullScreen) : null,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              style: theme.textTheme.labelSmall
                  ?.copyWith(fontSize: 16.ms, fontWeight: FontWeight.w800),
            )
          : null,
    );
  }
}
