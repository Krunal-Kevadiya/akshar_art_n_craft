import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import './drawer_menu.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../navigators/navigators.dart';
import '../../../providers/providers.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawerMenuModel currentItem = DrawerMenuModel(
    text: DrawerString.homeMenu.tr(),
    icon: Icons.cottage,
    routes: DrawerString.homeMenu,
    type: MenuType.menuItem,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    return ZoomDrawer(
      borderRadius: 32.s,
      showShadow: true,
      slideWidth: 70.wp,
      angle: -8,
      mainScreenScale: 0.05,
      menuScreenWidth: 100.wp,
      mainScreenTapClose: true,
      menuScreenTapClose: true,
      menuBackgroundColor: isDarkTheme ? AppColors.white : AppColors.offBlack,
      shadowLayer1Color: AppColors.green,
      shadowLayer2Color: AppColors.yellow,
      mainScreen: Navigation.getDrawerScreen(currentItem),
      menuScreen: StreamBuilder(
        stream: authProvider.user,
        builder: (context, snapshot) {
          final user = snapshot.data as UserModel?;
          return Builder(
            builder: (context) => DrawerMenu(
              currentItem: currentItem,
              user: user,
              onSelectedItem: (item) {
                ZoomDrawer.of(context)!.close();
                if (item.routes == DrawerString.logoutMenu) {
                  authProvider.signOut().then(
                        (value) => {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.signIn,
                            arguments: {'currentWidget': context.widget},
                          )
                        },
                      );
                } else {
                  setState(() => currentItem = item);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backdrop'),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: const Center(
        child: Text(
          'Back Panel',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
