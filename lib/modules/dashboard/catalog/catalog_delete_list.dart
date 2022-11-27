import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../themes/themes.dart';
import '../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class CatalogDeleteList extends StatelessWidget {
  const CatalogDeleteList({
    super.key,
    required this.type,
  });
  final FirestoreOperationType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    return StreamBuilder(
      stream: firestoreDatabase.getAllCatalog(type: type, isDelete: true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lists = (snapshot.data ?? []) as List<CatalogModel>;
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
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Dismissible(
            background: slideRightBackground(context),
            secondaryBackground: slideLeftBackground(context),
            key: Key('${lists[index].id}'),
            onDismissed: (direction) {
              handleDismissed(
                direction,
                context,
                firestoreDatabase,
                lists,
                index,
              );
            },
            child: catalogCard(theme, lists, index),
          ),
        );
      },
    );
  }

  Widget catalogCard(
    ThemeData theme,
    List<CatalogModel> lists,
    int index,
  ) {
    return Stack(
      children: [
        ProfileAvatar(
          photoUrl: lists[index].photoUrl,
          name: lists[index].name,
          enabled: false,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.s),
                bottomRight: Radius.circular(10.s),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5.s,
              vertical: 5.vs,
            ),
            child: titleAndDescription(theme, lists, index),
          ),
        ),
      ],
    );
  }

  Widget titleAndDescription(
    ThemeData theme,
    List<CatalogModel> lists,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lists[index].name.trim().capitalize(),
          style: theme.textTheme.caption?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13.ms,
          ),
        ),
        Text(
          lists[index].description?.trim().capitalize() ?? '',
          maxLines: 2,
          style: theme.textTheme.caption?.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12.ms,
          ),
        )
      ],
    );
  }

  Widget slideLeftBackground(BuildContext context) {
    return Card(
      color: AppColors.yellow,
      margin: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 10.s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Expanded(child: Spacer()),
              Icon(
                Icons.undo,
                size: 25.s,
                color: AppColors.white,
              ),
              SizedBox(
                width: 5.s,
              ),
              Text(
                CatalogString.undoButton.tr(),
                style: TextStyle(color: Theme.of(context).canvasColor),
                textAlign: TextAlign.right,
              ),
              const Expanded(child: Spacer()),
            ],
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground(BuildContext context) {
    return Card(
      color: AppColors.green,
      margin: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 10.s),
          child: Column(
            children: <Widget>[
              const Expanded(child: Spacer()),
              Icon(
                Icons.edit,
                size: 25.s,
                color: AppColors.white,
              ),
              SizedBox(
                width: 5.s,
              ),
              Text(
                CatalogString.editButton.tr(),
                style: TextStyle(color: Theme.of(context).canvasColor),
                textAlign: TextAlign.left,
              ),
              const Expanded(child: Spacer()),
            ],
          ),
        ),
      ),
    );
  }

  void handleDismissed(
    DismissDirection direction,
    BuildContext context,
    FirestoreDatabase firestoreDatabase,
    List<CatalogModel> lists,
    int index,
  ) {
    if (direction == DismissDirection.endToStart) {
      final deleteItem = CatalogModel(
        id: lists[index].id,
        name: lists[index].name,
        description: lists[index].description,
        photoUrl: lists[index].photoUrl,
        delete: false,
      );
      firestoreDatabase.deleteCatalog(
        type,
        deleteItem,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            CatalogString.deletedTitle.tr() + lists[index].name,
          ),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: CatalogString.undoButton.tr(),
            onPressed: () {
              final deleteItem = CatalogModel(
                id: lists[index].id,
                name: lists[index].name,
                description: lists[index].description,
                photoUrl: lists[index].photoUrl,
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
    }
  }
}
