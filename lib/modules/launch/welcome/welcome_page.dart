import 'package:flutter/material.dart';

import './login_signup_btn.dart';
import './welcome_image.dart';
import '../../../assets/assets.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(isFullScreen: true),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Background(
              bottomImage: Images.mainBottom,
              bottomLeft: 0,
              topLeft: 0,
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const WelcomeImage(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.s),
                    child: LoginAndSignupBtn(
                      navigationCallback: (routeName) {
                        Navigator.pushNamed(
                          context,
                          routeName,
                          arguments: {'currentWidget': this},
                        );
                      },
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
