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

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerMenuString.shareApp.tr()),
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
                          ShareAppString.shareAppDesc.tr(),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 15.ms,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(height: 16.vs),
                        RoundedButton(
                          title: DrawerMenuString.shareApp.tr().toUpperCase(),
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
