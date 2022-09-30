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
      body: Background(
        bottomImage: Images.mainBottom,
        bottomLeft: 0,
        topLeft: 0,
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50.vs),
                const WelcomeImage(),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: LoginAndSignupBtn(
                        navigationCallback: (routeName) {
                          Navigator.pushNamed(
                            context,
                            routeName,
                            arguments: {'currentWidget': context.widget},
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
