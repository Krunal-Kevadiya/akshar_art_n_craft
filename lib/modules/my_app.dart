import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../builders/builders.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../navigators/navigators.dart';
import '../providers/providers.dart';
import '../services/services.dart';
import '../themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.databaseBuilder});

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        return AuthWidgetBuilder(
          databaseBuilder: databaseBuilder,
          builder:
              (BuildContext context, AsyncSnapshot<UserModel?> userSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppString.appTitle.tr(),
              theme: CustomTheme.getLightTheme(),
              darkTheme: CustomTheme.getDarkTheme(),
              themeMode: themeProviderRef.getThemeMode,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: Navigation.initHome(userSnapshot, context),
              onGenerateRoute: Navigation.onGenerateRoute,
            );
          },
        );
      },
    );
  }
}
