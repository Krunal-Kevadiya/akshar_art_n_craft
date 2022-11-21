import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    required this.navigationCallback,
    super.key,
  });
  final void Function(String routeName) navigationCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedButton(
          title: SignInString.signInTitle.tr().toUpperCase(),
          press: () => navigationCallback(Routes.signIn),
        ),
        SizedBox(height: 16.vs),
        RoundedButton(
          title: SignUpString.signUpTitle.tr().toUpperCase(),
          backgroundColor: AppColors.primaryLightColor,
          press: () => navigationCallback(Routes.signUp),
        ),
      ],
    );
  }
}
