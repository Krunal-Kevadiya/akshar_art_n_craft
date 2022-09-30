import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/strings.dart';
import '../themes/themes.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
    this.signin = true,
    required this.press,
  });
  final bool signin;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final color =
        isDarkTheme ? AppColors.primaryLightColor : AppColors.primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          signin
              ? SignInString.signInDescription.tr()
              : SignUpString.signUpDescription.tr(),
          style: TextStyle(color: color),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            signin
                ? SignUpString.signUpTitle.tr()
                : SignInString.signInTitle.tr(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
