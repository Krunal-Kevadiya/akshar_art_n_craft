import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({required this.title, required this.type, super.key});
  final String title;
  final FirestoreOperationType type;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int? currentIndex;
  GlobalKey<CurvedNavigationBarState>? _bottomNavigationKey;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    _bottomNavigationKey = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
    currentIndex = null;
    _bottomNavigationKey = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        leading: const MenuButton(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 60.s,
        items: MockDatas.getCatalogMenu(),
        color: AppColors.primaryColor,
        buttonBackgroundColor: AppColors.primaryColor,
        backgroundColor: AppColors.transparent,
        animationCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        letIndexChange: (index) => true,
      ),
      body: Navigation.getProductBottomTabScreen(
        currentIndex,
        widget.type,
        _bottomNavigationKey?.currentState,
      ),
    );
  }
}
