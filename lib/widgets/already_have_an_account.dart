import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/strings.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    required this.press,
    super.key,
    this.signin = true,
  });
  final bool signin;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          signin
              ? SignInString.signInDescription.tr()
              : SignUpString.signUpDescription.tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            signin
                ? SignUpString.signUpTitle.tr()
                : SignInString.signInTitle.tr(),
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
