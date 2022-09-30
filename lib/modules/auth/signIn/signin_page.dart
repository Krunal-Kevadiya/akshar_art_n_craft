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
      body: SingleChildScrollView(
        child: Background(
          topLeft: 0,
          bottomRight: 0,
          bottomImageWidthFactor: 35,
          child: Column(
            children: <Widget>[
              CustomAppBar(
                isFullScreen: true,
                isBackAllow: true,
                title: SignInString.signInTitle.tr().toUpperCase(),
              ),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SvgPicture.asset(Vectors.signin),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 32.vs),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SignInForm(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
