import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerMenuString.contactUs.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: SingleChildScrollView(
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
            Padding(
              padding: EdgeInsets.all(25.s),
              child: Column(
                children: <Widget>[
                  header(
                    theme,
                    ContactUsString.byAddressTitle.tr(),
                  ),
                  Text(
                    ContactUsString.byAddressDesc.tr(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 15.ms,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.vs),
                  header(
                    theme,
                    ContactUsString.byPhoneTitle.tr(),
                  ),
                  phoneList(theme),
                  SizedBox(height: 16.vs),
                  header(
                    theme,
                    ContactUsString.byEmailTitle.tr(),
                  ),
                  Text(
                    ContactUsString.byEmailDesc.tr(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontSize: 15.ms,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header(ThemeData theme, String data) {
    return Container(
      width: 90.wp,
      padding: EdgeInsets.all(5.s),
      margin: EdgeInsets.only(bottom: 10.vs),
      decoration: const BoxDecoration(
        color: AppColors.assets,
      ),
      child: Text(
        data,
        textAlign: TextAlign.center,
        style: theme.textTheme.labelSmall?.copyWith(
          fontSize: 15.ms,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget phoneList(ThemeData theme) {
    return Column(
      children: ContactUsString.byPhoneDesc
          .map(
            (item) => ListTile(
              leading: Container(
                height: 100.hp,
                width: 20.s,
                alignment: Alignment.center,
                child: Icon(
                  Icons.call,
                  size: 30.s,
                  color: AppColors.green,
                ),
              ),
              title: Text(
                item.name.tr(),
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 15.ms,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                item.phone?.tr() ?? '',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 15.ms,
                  fontWeight: FontWeight.w600,
                ),
              ),
              horizontalTitleGap: 15.s,
              style: ListTileStyle.list,
            ),
          )
          .toList(),
    );
  }
}
