import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../models/models.dart';

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
        routes: DrawerString.productMenu,
        type: MenuType.header,
      ),
      DrawerMenuModel(
        text: DrawerString.shopForMenuTitle.tr(),
        type: MenuType.menuTitle,
      ),
      DrawerMenuModel(
        text: DrawerString.homeMenu.tr(),
        icon: Icons.cottage,
        routes: DrawerString.homeMenu,
        type: MenuType.menuItem,
      )
    ];

    if (isAdmin && isLogin) {
      list.addAll([
        DrawerMenuModel(
          text: DrawerString.categoryMenu.tr(),
          icon: Icons.style,
          routes: DrawerString.categoryMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.subCategoryMenu.tr(),
          icon: Icons.widgets,
          routes: DrawerString.subCategoryMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.brandMenu.tr(),
          icon: Icons.sell,
          routes: DrawerString.brandMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.fabricMenu.tr(),
          icon: Icons.dns,
          routes: DrawerString.fabricMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.productMenu.tr(),
          icon: Icons.token,
          routes: DrawerString.productMenu,
          type: MenuType.menuItem,
        )
      ]);
    }

    list.addAll([
      DrawerMenuModel(
        text: DrawerString.shopByCategoryMenu.tr(),
        icon: Icons.store,
        routes: DrawerString.shopByCategoryMenu,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerString.videosMenu.tr(),
        icon: Icons.ondemand_video,
        routes: DrawerString.videosMenu,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerString.myAccountMenuTitle.tr(),
        type: MenuType.menuTitle,
      )
    ]);

    if (!isLogin) {
      list.add(
        DrawerMenuModel(
          text: DrawerString.signInMenu.tr(),
          icon: Icons.lock,
          routes: DrawerString.signInMenu,
          type: MenuType.menuItem,
        ),
      );
    }

    if (isLogin) {
      list.addAll([
        DrawerMenuModel(
          text: DrawerString.wishlistMenu.tr(),
          icon: Icons.favorite,
          routes: DrawerString.wishlistMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.ordersMenu.tr(),
          icon: Icons.shopping_basket,
          routes: DrawerString.ordersMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.profileMenu.tr(),
          icon: Icons.account_circle,
          routes: DrawerString.profileMenu,
          type: MenuType.menuItem,
        ),
        DrawerMenuModel(
          text: DrawerString.logoutMenu.tr(),
          icon: Icons.key,
          routes: DrawerString.logoutMenu,
          type: MenuType.menuItem,
        )
      ]);
    }

    list.addAll([
      DrawerMenuModel(
        text: DrawerString.hellAndSupportMenuTitle.tr(),
        type: MenuType.menuTitle,
      ),
      DrawerMenuModel(
        text: DrawerString.testimonialsMenu.tr(),
        icon: Icons.chat,
        routes: DrawerString.testimonialsMenu,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerString.contactUsMenu.tr(),
        icon: Icons.contact_mail,
        routes: DrawerString.contactUsMenu,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerString.aboutUsMenu.tr(),
        icon: Icons.personal_injury,
        routes: DrawerString.aboutUsMenu,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerString.shareAppMenu.tr(),
        icon: Icons.share,
        routes: DrawerString.shareAppMenu,
        type: MenuType.menuItem,
      ),
      DrawerMenuModel(
        text: DrawerString.rateUsMenu.tr(),
        icon: Icons.star,
        routes: DrawerString.rateUsMenu,
        type: MenuType.menuItem,
      )
    ]);

    return list;
  }
}
