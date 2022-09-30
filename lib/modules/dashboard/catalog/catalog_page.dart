import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../navigators/navigators.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key, required this.title, required this.type});
  final String title;
  final FirestoreOperationType type;

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
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
        items: <Widget>[
          Icon(Icons.add, size: 30.s, color: AppColors.white),
          Icon(Icons.list, size: 30.s, color: AppColors.white),
          Icon(Icons.delete_sweep, size: 30.s, color: AppColors.white),
        ],
        color: AppColors.primaryColor,
        buttonBackgroundColor: AppColors.primaryColor,
        backgroundColor: AppColors.transparent,
        animationCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        letIndexChange: (index) => true,
      ),
      body: Navigation.getCatalogBottomTabScreen(currentIndex, widget.type),
    );
  }
}
