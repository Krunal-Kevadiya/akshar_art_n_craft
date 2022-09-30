import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../themes/themes.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    super.key,
    required this.icon,
    required this.press,
  });
  final String icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.s),
        padding: EdgeInsets.all(20.s),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.s,
            color: isDarkTheme
                ? AppColors.primaryColor
                : AppColors.primaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon,
            height: 20.s,
            width: 20.s,
            color: isDarkTheme
                ? AppColors.primaryLightColor
                : AppColors.primaryColor,),
      ),
    );
  }
}
