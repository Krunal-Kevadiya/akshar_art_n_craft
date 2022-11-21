import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './signin_form.dart';
import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Background(
              topLeft: 0,
              bottomRight: 0,
              bottomImageWidthFactor: 35.s,
              child: Column(
                children: <Widget>[
                  CustomAppBar(
                    isFullScreen: true,
                    isBackAllow: true,
                    title: SignInString.signInTitle.tr().toUpperCase(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.s),
                    child: Column(
                      children: <Widget>[
                        SvgPicture.asset(Vectors.signin),
                        SizedBox(height: 32.vs),
                        SignInForm(
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
