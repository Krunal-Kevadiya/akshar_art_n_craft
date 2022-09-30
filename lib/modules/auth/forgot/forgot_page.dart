import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './forgot_form.dart';
import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Background(
          topLeft: 0,
          bottomRight: 0,
          topImage: Images.signupTop,
          bottomImageWidthFactor: 35,
          child: Column(
              children: <Widget>[
                CustomAppBar(
                    isFullScreen: true,
                    isBackAllow: true,
                    title: ForgotPasswordString.forgotPasswordTitle
                        .tr()
                        .toUpperCase(),),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: SvgPicture.asset(
                        Vectors.forgotPassword,
                        height: 400.s,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                SizedBox(height: 32.vs),
                Row(
                  children: const [
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: ForgotForm(),
                    ),
                    Spacer(),
                  ],
                )
              ],),
        ),
      ),
    );
  }
}
