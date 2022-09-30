import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './signup_form.dart';
import './social_sign_up.dart';
import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Background(
        topLeft: 0,
        bottomLeft: 0,
        topImage: Images.signupTop,
        bottomImage: Images.mainBottom,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomAppBar(
                isFullScreen: true,
                isBackAllow: true,
                title: SignUpString.signUpTitle.tr().toUpperCase(),
              ),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SvgPicture.asset(Vectors.signup),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 16.vs),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignUpForm(
                      navigationCallback: (routeName) {
                        Navigator.pushNamed(
                          context,
                          routeName,
                          arguments: {'currentWidget': context.widget},
                        );
                      },
                      homeCallback: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home,
                          ModalRoute.withName(Routes.root),
                          arguments: {'currentWidget': context.widget},
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SocialSignUp()
            ],
          ),
        ),
      ),
    );
  }
}
