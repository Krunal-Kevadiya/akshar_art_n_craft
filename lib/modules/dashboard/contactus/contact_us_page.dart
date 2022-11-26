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
        title: Text(DrawerString.contactUsMenu.tr()),
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
                  Container(
                    width: 90.wp,
                    padding: EdgeInsets.all(5.s),
                    margin: EdgeInsets.only(bottom: 10.vs),
                    decoration: const BoxDecoration(
                      color: AppColors.assets,
                    ),
                    child: Text(
                      ContactUsString.byAddress.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.overline?.copyWith(
                        fontSize: 15.ms,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Text(
                    ContactUsString.byAddressDesc.tr(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.overline?.copyWith(
                      fontSize: 15.ms,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.vs),
                  Container(
                    width: 90.wp,
                    padding: EdgeInsets.all(5.s),
                    margin: EdgeInsets.only(bottom: 10.vs),
                    decoration: const BoxDecoration(
                      color: AppColors.assets,
                    ),
                    child: Text(
                      ContactUsString.byPhone.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.overline?.copyWith(
                        fontSize: 15.ms,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Column(
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
                              style: theme.textTheme.overline?.copyWith(
                                fontSize: 15.ms,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              item.phone?.tr() ?? '',
                              style: theme.textTheme.overline?.copyWith(
                                fontSize: 15.ms,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ListTileStyle.list,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 16.vs),
                  Container(
                    width: 90.wp,
                    padding: EdgeInsets.all(5.s),
                    margin: EdgeInsets.only(bottom: 10.vs),
                    decoration: const BoxDecoration(
                      color: AppColors.assets,
                    ),
                    child: Text(
                      ContactUsString.byEmail.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.overline?.copyWith(
                        fontSize: 15.ms,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  Text(
                    ContactUsString.byEmailDesc.tr(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.overline?.copyWith(
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
}
