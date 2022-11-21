import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './Routes.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../modules/modules.dart';

class Navigation {
  Navigation._();

  static Map<String, Widget Function(BuildContext context, {Object? arguments})>
      routes = {
    Routes.root: (context, {arguments}) => const IndicatorPage(),
    Routes.welcome: (context, {arguments}) => const WelcomePage(),
    Routes.signIn: (context, {arguments}) => const SignInPage(),
    Routes.signUp: (context, {arguments}) => const SignUpPage(),
    Routes.forgot: (context, {arguments}) => const ForgotPage(),
    Routes.home: (context, {arguments}) => const HomePage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = settings.name;
    final arguments = settings.arguments;
    final pageContentBuilder = name != null ? routes[name] : null;
    final argumentsMap =
        (arguments ?? <String, dynamic>{}) as Map<String, dynamic>;
    final currentWidget = argumentsMap['currentWidget'] as Widget?;
    if (currentWidget != null) {
      argumentsMap.remove('currentWidget');
    }

    if (pageContentBuilder != null) {
      return PageRouteBuilder(
        settings: RouteSettings(name: name, arguments: argumentsMap),
        pageBuilder: (context, _, __) =>
            pageContentBuilder(context, arguments: argumentsMap),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-1, 0),
              ).animate(animation),
              child: currentWidget,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            )
          ],
        ),
      );
    }
    throw UnsupportedError('Unknown route: $name');
  }

  static Widget initHome(
    AsyncSnapshot<UserModel?> userSnapshot,
    BuildContext context,
  ) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      if (userSnapshot.hasData) {
        if (userSnapshot.data?.emailVerified == true) {
          return const HomePage();
        } else {
          return const VerifyPage();
        }
      }
      return const HomePage();
      return const WelcomePage();
    }
    return const IndicatorPage();
  }

  static Widget getDrawerScreen(DrawerMenuModel currentItem) {
    switch (currentItem.routes) {
      case DrawerString.homeMenu:
        return const HomeView();
      case DrawerString.categoryMenu:
        return CatalogPage(
          title: CatalogString.categoryTitle.tr(),
          type: FirestoreOperationType.category,
        );
      case DrawerString.subCategoryMenu:
        return CatalogPage(
          title: CatalogString.subCategoryTitle.tr(),
          type: FirestoreOperationType.subCategory,
        );
      case DrawerString.brandMenu:
        return CatalogPage(
          title: CatalogString.brandTitle.tr(),
          type: FirestoreOperationType.brand,
        );
      case DrawerString.fabricMenu:
        return CatalogPage(
          title: CatalogString.fabricTitle.tr(),
          type: FirestoreOperationType.fabric,
        );
      case DrawerString.productMenu:
        return const ProductPage();
      case DrawerString.shopByCategoryMenu:
        return const CategoryPage();
      case DrawerString.videosMenu:
        return const VideosPage();
      case DrawerString.signInMenu:
        return const SignInPage();
      case DrawerString.wishlistMenu:
        return const WishlistPage();
      case DrawerString.ordersMenu:
        return const OrdersPage();
      case DrawerString.profileMenu:
        return const ProfilePage();
      case DrawerString.testimonialsMenu:
        return const TestimonialsPage();
      case DrawerString.contactUsMenu:
        return const ContactUsPage();
      case DrawerString.aboutUsMenu:
        return const AboutUsPage();
      case DrawerString.shareAppMenu:
        return const ShareAppPage();
      case DrawerString.rateUsMenu:
        return const RateUsPage();
      default:
        return const HomeView();
    }
  }

  static Widget getCatalogBottomTabScreen(
    int? index,
    FirestoreOperationType type,
  ) {
    switch (index) {
      case 0:
        return CatalogAddEdit(type: type);
      case 1:
        return CatalogList(type: type);
      case 2:
        return CatalogDeleteList(type: type);
      default:
        return CatalogAddEdit(type: type);
    }
  }
}
