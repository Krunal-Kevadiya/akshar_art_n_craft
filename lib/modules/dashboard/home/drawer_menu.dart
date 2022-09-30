import 'package:flutter/material.dart';

import '../../../assets/assets.dart';
import '../../../models/models.dart';
import '../../../themes/themes.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({
    super.key,
    this.user,
    required this.currentItem,
    required this.onSelectedItem,
  }) {
    data = MockDatas.getDrawerMenu(
      name: user?.displayName,
      email: user?.email,
      url: user?.photoUrl,
      isLogin: user != null,
      isAdmin: user?.type == 'admin',
    );
  }
  final UserModel? user;
  late List<DrawerMenuModel> data;
  final DrawerMenuModel currentItem;
  final ValueChanged<DrawerMenuModel> onSelectedItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        switch (item.type) {
          case MenuType.header:
            return buildHeader(
              name: item.text,
              email: item.email,
              url: item.url,
              theme: theme,
              onClicked: () {
                onSelectedItem(item);
              },
            );
          case MenuType.menuTitle:
            return buildMenuTitleItem(text: item.text, theme: theme);
          case MenuType.menuItem:
            return buildMenuItem(
              text: item.text,
              icon: item.icon,
              theme: theme,
              isDarkTheme: isDarkTheme,
              onClicked: () {
                onSelectedItem(item);
              },
            );
        }
      },
    );
  }

  Widget buildHeader({
    String? url,
    required String name,
    String? email,
    required ThemeData theme,
    required VoidCallback onClicked,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.vs, horizontal: 15.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35.s,
              backgroundImage: url != null ? NetworkImage(url) : null,
            ),
            SizedBox(height: 10.vs),
            Text(
              name,
              style: theme.textTheme.caption
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              email ?? '',
              style: theme.textTheme.caption
                  ?.copyWith(fontWeight: FontWeight.w300, fontSize: 12.ms),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuTitleItem({required String text, required ThemeData theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.s),
          child: Text(
            text,
            style: theme.textTheme.caption?.copyWith(
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        const Divider()
      ],
    );
  }

  Widget buildMenuItem({
    required String text,
    required ThemeData theme,
    IconData? icon,
    required bool isDarkTheme,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      leading:
          Icon(icon, color: isDarkTheme ? AppColors.black : AppColors.white),
      title: Text(
        text,
        style: theme.textTheme.caption?.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: onClicked,
      selectedTileColor: isDarkTheme ? AppColors.black26 : AppColors.white26,
      selected: currentItem.text == text,
      style: ListTileStyle.drawer,
    );
  }
}
