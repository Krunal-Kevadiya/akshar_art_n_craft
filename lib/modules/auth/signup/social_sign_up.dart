import 'package:flutter/material.dart';

import './or_divider.dart';
import './social_icon.dart';
import '../../../assets/assets.dart';
import '../../../themes/themes.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialIcon(
              icon: Vectors.facebook,
              press: () {},
            ),
            SocialIcon(
              icon: Vectors.twitter,
              press: () {},
            ),
            SocialIcon(
              icon: Vectors.googlePlus,
              press: () {},
            ),
          ],
        ),
        SizedBox(height: 50.vs)
      ],
    );
  }
}
