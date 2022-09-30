import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.isFullScreen = false,
    this.isBackAllow = false,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String? title;
  final bool isFullScreen, isBackAllow;

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
      leading: isBackAllow
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isFullScreen ? AppColors.black : AppColors.white,
              ),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              style: theme.textTheme.overline
                  ?.copyWith(fontSize: 16.ms, fontWeight: FontWeight.w800),
            )
          : null,
    );
  }
}
