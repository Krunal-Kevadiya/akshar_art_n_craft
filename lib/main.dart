import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './firebase_options.dart';
import './modules/modules.dart';
import './providers/providers.dart';
import './services/services.dart';
import './themes/themes.dart';
import './translations/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: Translations.supportedLocales,
      path: Translations.path, // <-- change the path of the translation files
      fallbackLocale: Translations.fallbackLocale,
      child: AutoResponsive(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(),
            ),
            ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider(),
            ),
          ],
          child: MyApp(
            databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
          ),
        ),
      ),
    ),
  );
}
