import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          AppString.welcome.tr().toUpperCase(),
          style: theme.textTheme.overline
              ?.copyWith(fontSize: 16.ms, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 32.vs),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                Vectors.chat,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: 32.vs),
      ],
    );
  }
}
