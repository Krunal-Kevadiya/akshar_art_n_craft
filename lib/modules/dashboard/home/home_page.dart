import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import './drawer_menu.dart';
import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../navigators/navigators.dart';
import '../../../providers/providers.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawerMenuModel currentItem = DrawerMenuModel(
    text: DrawerMenuString.home.tr(),
    icon: Icons.cottage,
    routes: DrawerMenuString.home,
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
      menuScreen: Scaffold(
        backgroundColor: isDarkTheme ? AppColors.white : AppColors.offBlack,
        body: StreamBuilder<UserModel?>(
          stream: authProvider.user,
          builder: (context, snapshot) {
            final user = snapshot.data;
            return Builder(
              builder: (context) => DrawerMenu(
                currentItem: currentItem,
                user: user,
                onSelectedItem: (item) {
                  ZoomDrawer.of(context)?.close();
                  if (item.routes == DrawerMenuString.logout) {
                    authProvider.signOut().then(
                          (value) => {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.signIn,
                              arguments: {'currentWidget': this},
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
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  // ignore: avoid_field_initializers_in_const_classes
  final FirestoreOperationType type = FirestoreOperationType.product;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(DrawerMenuString.home.tr()),
        elevation: 0,
        leading: const MenuButton(),
        backgroundColor: AppColors.transparent,
      ),
      body: StreamBuilder(
        stream: firestoreDatabase.getAllProduct(
          type: widget.type,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lists =
                (snapshot.data ?? <ProductModel>[]) as List<ProductModel>;
            if (lists.isNotEmpty) {
              return productList(theme, lists);
            } else {
              return EmptyContent(
                topImage: Images.mainTop,
                title: widget.type.name,
                message: widget.type.name,
                press: () {},
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContent(
              topImage: Images.mainTop,
              title: widget.type.name,
              message: widget.type.name,
              press: () {},
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget productList(
    ThemeData theme,
    List<ProductModel> lists,
  ) {
    return SizedBox(
      height: 100.hp,
      child: Stack(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 70.hp,
              viewportFraction: 1,
            ),
            itemCount: lists.length,
            carouselController: _carouselController,
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return ProfileAvatar(
                photoUrl: lists[itemIndex].photoUrl.isNotEmpty
                    ? lists[itemIndex].photoUrl[0]
                    : null,
                name: lists[itemIndex].name,
                enabled: false,
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 70.hp,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.grey.shade50.withOpacity(1),
                    Colors.grey.shade50.withOpacity(1),
                    Colors.grey.shade50.withOpacity(1),
                    Colors.grey.shade50.withOpacity(1),
                    Colors.grey.shade50.withOpacity(0),
                    Colors.grey.shade50.withOpacity(0),
                    Colors.grey.shade50.withOpacity(0),
                    Colors.grey.shade50.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: 70.hp,
            width: 100.wp,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 500.vs,
                viewportFraction: 0.70,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  _carouselController.animateToPage(index);
                },
              ),
              itemCount: lists.length,
              itemBuilder: (context, itemIndex, pageViewIndex) {
                return productCard(lists, lists[itemIndex]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget productCard(List<ProductModel> list, ProductModel item) {
    return Container(
      width: 100.wp,
      margin: EdgeInsets.symmetric(horizontal: 7.s),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20.ms),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320.vs,
              margin: EdgeInsets.all(15.ms),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.ms),
              ),
              child: ProfileAvatar(
                photoUrl: item.photoUrl.isNotEmpty ? item.photoUrl[0] : null,
                name: item.name,
                enabled: false,
              ),
            ),
            SizedBox(height: 20.vs),
            Text(
              item.name.trim().capitalize(),
              style: TextStyle(
                fontSize: 16.ms,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            // rating
            Text(
              item.description.trim().capitalize(),
              style: TextStyle(
                fontSize: 14.ms,
                color: Colors.grey.shade600,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
