import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../themes/themes.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(VerifyEmailString.verifyEmailTitle.tr()),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.s),
          child: Text(
            ErrorString.fbVerifyEmail.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              fontSize: 15.ms,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
