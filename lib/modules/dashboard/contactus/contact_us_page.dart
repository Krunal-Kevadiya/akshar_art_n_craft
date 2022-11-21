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
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerString.contactUsMenu.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.s),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  Images.mainTop,
                  width: 30.wp,
                  height: 35.wp,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 16.vs),
              Container(
                width: 90.wp,
                padding: EdgeInsets.all(5.s),
                margin: EdgeInsets.only(bottom: 10.vs),
                decoration: const BoxDecoration(
                  color: AppColors.gray,
                ),
                child: Text(
                  ContactUsString.byAddress.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.overline?.copyWith(
                    fontSize: 15.ms,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    backgroundColor: AppColors.gray,
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
                  color: AppColors.gray,
                ),
                child: Text(
                  ContactUsString.byPhone.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.overline?.copyWith(
                    fontSize: 15.ms,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    backgroundColor: AppColors.gray,
                  ),
                ),
              ),
              // ListView.separated(
              //   itemCount: ContactUsString.byPhoneDesc.length,
              //   itemBuilder: (context, index) {
              //     final item = ContactUsString.byPhoneDesc[index];
              //     return ListTile(
              //       leading: SvgPicture.asset(
              //         Vectors.add,
              //         height: 20.s,
              //         width: 20.s,
              //         color: isDarkTheme ? AppColors.white : AppColors.black,
              //       ),
              //       title: Text(
              //         item.name.tr(),
              //         style: theme.textTheme.overline?.copyWith(
              //           fontSize: 15.ms,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       subtitle: Text(
              //         item.phone?.tr() ?? '',
              //         style: theme.textTheme.overline?.copyWith(
              //           fontSize: 15.ms,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //       style: ListTileStyle.drawer,
              //     );
              //   },
              //   separatorBuilder: (context, index) {
              //     return const Divider(height: 0.5);
              //   },
              // ),
              // ContactUsString.byPhoneDesc.forEach(
              //   (item) => ListTile(
              //     leading: SvgPicture.asset(
              //       Vectors.add,
              //       height: 20.s,
              //       width: 20.s,
              //       color: isDarkTheme ? AppColors.white : AppColors.black,
              //     ),
              //     title: Text(
              //       item.name.tr(),
              //       style: theme.textTheme.overline?.copyWith(
              //         fontSize: 15.ms,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     subtitle: Text(
              //       item.phone?.tr() ?? '',
              //       style: theme.textTheme.overline?.copyWith(
              //         fontSize: 15.ms,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     style: ListTileStyle.drawer,
              //   ),
              // ),
              SizedBox(height: 16.vs),
              Container(
                width: 90.wp,
                padding: EdgeInsets.all(5.s),
                margin: EdgeInsets.only(bottom: 10.vs),
                decoration: const BoxDecoration(
                  color: AppColors.gray,
                ),
                child: Text(
                  ContactUsString.byEmail.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.overline?.copyWith(
                    fontSize: 15.ms,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                    backgroundColor: AppColors.gray,
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
      ),
    );
  }
}
