import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerMenuString.aboutUs.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Image.asset(
                Images.banner,
                width: 100.wp,
                height: 64.5.wp,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.s),
              child: Text(
                AboutUsString.aboutUsDesc.tr(),
                textAlign: TextAlign.justify,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 15.ms,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
