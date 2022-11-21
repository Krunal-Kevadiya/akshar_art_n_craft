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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.s),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(Vectors.signup),
                    SizedBox(height: 16.vs),
                    SignUpForm(
                      navigationCallback: (routeName, isRemoveUntil) {
                        if (isRemoveUntil) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            routeName,
                            ModalRoute.withName(Routes.root),
                            arguments: {'currentWidget': this},
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            routeName,
                            arguments: {'currentWidget': this},
                          );
                        }
                      },
                    ),
                    const SocialSignUp()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
