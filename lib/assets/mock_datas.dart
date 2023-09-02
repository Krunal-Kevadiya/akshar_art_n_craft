import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../themes/themes.dart';

class MockDatas {
  MockDatas._();

  //static const String image = 'image.svg';

  static List<DrawerMenuModel> getDrawerMenu({
    String? name,
    String? email,
    String? url,
    bool isLogin = false,
    bool isAdmin = false,
  }) {
    final list = <DrawerMenuModel>[
      DrawerMenuModel(
        text: name ?? 'Nan',
        email: email,
        url: url,
        routes: DrawerMenuString.product,
        type: MenuType.header,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.shopForSection.tr(),
        type: MenuType.menuTitle,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.home.tr(),
        icon: Icons.cottage,
        routes: DrawerMenuString.home,
        type: MenuType.menuItem,
      ),
    ];

    if (isAdmin && isLogin) {
      list.addAll([
        DrawerMenuModel(
          text: DrawerMenuString.category.tr(),
          icon: Icons.style,
          routes: DrawerMenuString.category,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.subCategory.tr(),
          icon: Icons.widgets,
          routes: DrawerMenuString.subCategory,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.brand.tr(),
          icon: Icons.sell,
          routes: DrawerMenuString.brand,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.fabric.tr(),
          icon: Icons.dns,
          routes: DrawerMenuString.fabric,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.product.tr(),
          icon: Icons.token,
          routes: DrawerMenuString.product,
          type: MenuType.menuItem,
        ),
      ]);
    }

    list.addAll([
      DrawerMenuModel(
        text: DrawerMenuString.shopByCategory.tr(),
        icon: Icons.store,
        routes: DrawerMenuString.shopByCategory,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.videos.tr(),
        icon: Icons.ondemand_video,
        routes: DrawerMenuString.videos,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.myAccountSection.tr(),
        type: MenuType.menuTitle,
      ),
    ]);

    if (!isLogin) {
      list.add(
        DrawerMenuModel(
          text: DrawerMenuString.signIn.tr(),
          icon: Icons.lock,
          routes: DrawerMenuString.signIn,
          type: MenuType.menuItem,
        ),
      );
    }

    if (isLogin) {
      list.addAll([
        DrawerMenuModel(
          text: DrawerMenuString.wishlist.tr(),
          icon: Icons.favorite,
          routes: DrawerMenuString.wishlist,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.orders.tr(),
          icon: Icons.shopping_basket,
          routes: DrawerMenuString.orders,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.profile.tr(),
          icon: Icons.account_circle,
          routes: DrawerMenuString.profile,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerMenuString.logout.tr(),
          icon: Icons.key,
          routes: DrawerMenuString.logout,
          type: MenuType.menuItem,
        ),
      ]);
    }

    list.addAll([
      DrawerMenuModel(
        text: DrawerMenuString.hellAndSupportSection.tr(),
        type: MenuType.menuTitle,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.testimonials.tr(),
        icon: Icons.chat,
        routes: DrawerMenuString.testimonials,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.contactUs.tr(),
        icon: Icons.contact_mail,
        routes: DrawerMenuString.contactUs,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.aboutUs.tr(),
        icon: Icons.personal_injury,
        routes: DrawerMenuString.aboutUs,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.shareApp.tr(),
        icon: Icons.share,
        routes: DrawerMenuString.shareApp,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerMenuString.rateUs.tr(),
        icon: Icons.star,
        routes: DrawerMenuString.rateUs,
        type: MenuType.menuItem,
      ),
    ]);

    return list;
  }

  static List<Widget> getCatalogMenu() {
    return [
      Icon(Icons.add, size: 25.s, color: AppColors.white),
      Icon(Icons.list, size: 25.s, color: AppColors.white),
      Icon(Icons.delete_sweep, size: 25.s, color: AppColors.white),
    ];
  }
}
