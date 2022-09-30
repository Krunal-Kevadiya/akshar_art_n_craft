import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.hp),
      width: 80.wp,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.s),
            child: Text(
              SignUpString.orLabel.tr().toUpperCase(),
              style: theme.textTheme.overline?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDarkTheme
                      ? AppColors.primaryLightColor
                      : AppColors.primaryColor,),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: AppColors.gray,
        height: 1.s,
      ),
    );
  }
}
