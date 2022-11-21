import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../navigators/navigators.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  FirestoreOperationType get type => FirestoreOperationType.category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DrawerMenuString.shopByCategory.tr()),
        elevation: 0,
        leading: const MenuButton(),
      ),
      body: StreamBuilder(
        stream: firestoreDatabase.getAllCatalog(type: type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lists =
                (snapshot.data ?? <CatalogModel>[]) as List<CatalogModel>;
            if (lists.isNotEmpty) {
              return catalogList(theme, lists, firestoreDatabase);
            } else {
              return EmptyContent(
                topImage: Images.mainTop,
                title: type.name,
                message: type.name,
                press: () {},
              );
            }
          } else if (snapshot.hasError) {
            return EmptyContent(
              topImage: Images.mainTop,
              title: type.name,
              message: type.name,
              press: () {},
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget catalogList(
    ThemeData theme,
    List<CatalogModel> lists,
    FirestoreDatabase firestoreDatabase,
  ) {
    return GridView.builder(
      itemCount: lists.length,
      padding: EdgeInsets.symmetric(horizontal: 10.s, vertical: 10.vs),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.s,
        mainAxisSpacing: 5.vs,
        childAspectRatio: 1 / 1.2,
      ),
      itemBuilder: (context, index) {
        return CatalogItem(
          key: Key('${lists[index].id}'),
          index: index,
          isDelete: true,
          enabled: false,
          photoUrl: lists[index].photoUrl,
          name: lists[index].name,
          description: lists[index].description,
          onClicked: () => Navigator.pushNamed(
            context,
            Routes.productList,
            arguments: {'currentWidget': this, 'model': lists[index]},
          ),
        );
      },
    );
  }
}
