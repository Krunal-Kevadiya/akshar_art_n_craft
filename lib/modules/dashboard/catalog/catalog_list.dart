import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './catalog_share_model.dart';
import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../widgets/widgets.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({
    required this.type,
    required this.navBarState,
    super.key,
  });
  final FirestoreOperationType type;
  final CurvedNavigationBarState? navBarState;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firestoreDatabase = Provider.of<FirestoreDatabase>(context);

    return StreamBuilder(
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
          enabled: true,
          photoUrl: lists[index].photoUrl,
          name: lists[index].name,
          description: lists[index].description,
          startPressed: (BuildContext context) => handleDismissed(
            context: context,
            firestoreDatabase: firestoreDatabase,
            model: lists[index],
            endToStart: false,
          ),
          endPressed: (BuildContext context) => handleDismissed(
            context: context,
            firestoreDatabase: firestoreDatabase,
            model: lists[index],
            endToStart: true,
          ),
        );
      },
    );
  }

  void handleDismissed({
    required BuildContext context,
    required FirestoreDatabase firestoreDatabase,
    required CatalogModel model,
    required bool endToStart,
  }) {
    if (endToStart) {
      final deleteItem = CatalogModel(
        id: model.id,
        name: model.name,
        description: model.description,
        photoUrl: model.photoUrl,
        delete: true,
      );
      firestoreDatabase.deleteCatalog(
        type,
        deleteItem,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            CatalogString.deletedTitle.tr() + model.name,
          ),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: CatalogString.undoButton.tr(),
            onPressed: () {
              final deleteItem = CatalogModel(
                id: model.id,
                name: model.name,
                description: model.description,
                photoUrl: model.photoUrl,
                delete: false,
              );
              firestoreDatabase.deleteCatalog(
                type,
                deleteItem,
              );
            },
          ),
        ),
      );
    } else {
      Provider.of<CatalogShareModel>(context, listen: false)
          .passParameter(model);
      navBarState?.setPage(0);
    }
  }
}
