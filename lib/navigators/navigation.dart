import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './Routes.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../modules/modules.dart';

class Navigation {
  Navigation._();

  static Map<
      String,
      Widget Function(
        BuildContext context, {
        Map<String, dynamic>? arguments,
      })> routes = {
    Routes.root: (context, {arguments}) => const IndicatorPage(),
    Routes.welcome: (context, {arguments}) => const WelcomePage(),
    Routes.signIn: (context, {arguments}) => const SignInPage(),
    Routes.signUp: (context, {arguments}) => const SignUpPage(),
    Routes.forgot: (context, {arguments}) => const ForgotPage(),
    Routes.verify: (context, {arguments}) => const VerifyPage(),
    Routes.home: (context, {arguments}) => const HomePage(),
    Routes.productList: (context, {arguments}) => ProductListPage(
          model: arguments != null ? arguments['model'] as CatalogModel : null,
        ),
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
        if ((userSnapshot.data?.emailVerified ?? false) == true) {
          return const HomePage();
        } else {
          return const VerifyPage();
        }
      }
      return const WelcomePage();
    }
    return const IndicatorPage();
  }

  static Widget getDrawerScreen(DrawerMenuModel currentItem) {
    switch (currentItem.routes) {
      case DrawerMenuString.home:
        return HomeView();
      case DrawerMenuString.category:
        return CatalogPage(
          title: CatalogString.categoryTitle.tr(),
          type: FirestoreOperationType.category,
        );
      case DrawerMenuString.subCategory:
        return CatalogPage(
          title: CatalogString.subCategoryTitle.tr(),
          type: FirestoreOperationType.subCategory,
        );
      case DrawerMenuString.brand:
        return CatalogPage(
          title: CatalogString.brandTitle.tr(),
          type: FirestoreOperationType.brand,
        );
      case DrawerMenuString.fabric:
        return CatalogPage(
          title: CatalogString.fabricTitle.tr(),
          type: FirestoreOperationType.fabric,
        );
      case DrawerMenuString.product:
        return ProductPage(
          title: ProductString.productTitle.tr(),
          type: FirestoreOperationType.product,
        );
      case DrawerMenuString.shopByCategory:
        return const CategoryPage();
      case DrawerMenuString.videos:
        return const VideosPage();
      case DrawerMenuString.signIn:
        return const SignInPage();
      case DrawerMenuString.wishlist:
        return const WishlistPage();
      case DrawerMenuString.orders:
        return const OrdersPage();
      case DrawerMenuString.profile:
        return const ProfilePage();
      case DrawerMenuString.testimonials:
        return const TestimonialsPage();
      case DrawerMenuString.contactUs:
        return const ContactUsPage();
      case DrawerMenuString.aboutUs:
        return const AboutUsPage();
      case DrawerMenuString.shareApp:
        return const ShareAppPage();
      case DrawerMenuString.rateUs:
        return const RateUsPage();
      default:
        return HomeView();
    }
  }

  static Widget getCatalogBottomTabScreen(
    int? index,
    FirestoreOperationType type,
    CurvedNavigationBarState? navBarState,
  ) {
    switch (index) {
      case 0:
        return CatalogAddEdit(type: type, navBarState: navBarState);
      case 1:
        return CatalogList(type: type, navBarState: navBarState);
      case 2:
        return CatalogDeleteList(type: type, navBarState: navBarState);
      default:
        return CatalogAddEdit(type: type, navBarState: navBarState);
    }
  }

  static Widget getProductBottomTabScreen(
    int? index,
    FirestoreOperationType type,
    CurvedNavigationBarState? navBarState,
  ) {
    switch (index) {
      case 0:
        return ProductAddEdit(type: type, navBarState: navBarState);
      case 1:
        return ProductList(type: type, navBarState: navBarState);
      case 2:
        return ProductDeleteList(type: type, navBarState: navBarState);
      default:
        return ProductAddEdit(type: type, navBarState: navBarState);
    }
  }
}
