import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class ShareAppPage extends StatelessWidget {
  const ShareAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerString.shareAppMenu.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    Images.banner,
                    width: 100.wp,
                    height: 64.5.wp,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(25.s),
                    child: Column(
                      children: <Widget>[
                        Text(
                          ShareAppString.shareApp.tr(),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.overline?.copyWith(
                            fontSize: 15.ms,
                            fontWeight: FontWeight.w600,
                            color: isDarkTheme
                                ? AppColors.primaryLightColor
                                : AppColors.primaryColor,
                          ),
                        ),
                        const Expanded(child: Spacer()),
                        SizedBox(height: 16.vs),
                        RoundedButton(
                          title: DrawerString.shareAppMenu.tr().toUpperCase(),
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
