import 'package:flutter/material.dart';
import '../themes/themes.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.title,
      required this.press,
      this.backgroundColor,
      this.textColor,
      this.fontSize,});

  final String title;
  final VoidCallback press;
  final double? fontSize;
  final Color? backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = updateBackgroundColor(theme);
    final txtColor = updateTextColor(theme, bgColor);
    return SizedBox(
        width: 100.wp,
        height: 45.s,
        child: ElevatedButton(
            onPressed: press,
            style: theme.elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.disabled)
                    ? bgColor.withOpacity(0.5)
                    : bgColor;
              }),
            ),
            child: Text(title,
                style: theme.textTheme.caption?.copyWith(
                    color: txtColor,
                    fontSize: fontSize?.ms ?? 14.ms,
                    fontWeight: FontWeight.bold,),),),);
  }

  Color updateBackgroundColor(ThemeData theme) {
    final isDarkTheme = theme.brightness == Brightness.dark;
    var newBackgroundColor = backgroundColor;
    if (isDarkTheme) {
      if (newBackgroundColor == AppColors.primaryLightColor) {
        newBackgroundColor = AppColors.primaryColor;
      } else if (newBackgroundColor == AppColors.primaryColor) {
        newBackgroundColor = AppColors.primaryLightColor;
      }
    }
    return newBackgroundColor ??
        (isDarkTheme ? AppColors.primaryLightColor : AppColors.primaryColor);
  }

  Color updateTextColor(ThemeData theme, Color bgColor) {
    final isDarkTheme = theme.brightness == Brightness.dark;
    var newTextColor = textColor;
    if (isDarkTheme) {
      if (newTextColor == AppColors.primaryLightColor) {
        newTextColor = AppColors.primaryColor;
      } else if (newTextColor == AppColors.primaryColor) {
        newTextColor = AppColors.primaryLightColor;
      }
    }
    final isDarkBackground = bgColor.computeLuminance() > 0.5;
    return newTextColor ??
        (isDarkBackground ? AppColors.black : AppColors.white);
  }
}
