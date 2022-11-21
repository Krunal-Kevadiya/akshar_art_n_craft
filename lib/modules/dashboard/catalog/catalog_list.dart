import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/assets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../../services/services.dart';
import '../../../widgets/widgets.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({
    super.key,
    required this.type,
  });
  final FirestoreOperationType type;

  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder(
      stream: firestoreDatabase.getAllCatalog(type, false),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lists = (snapshot.data ?? []) as List<CatalogModel>;
          if (lists.isNotEmpty) {
            return ListView.separated(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  background: ColoredBox(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        CatalogString.deleteButton.tr(),
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      ),
                    ),
                  ),
                  key: Key('${lists[index].id}'),
                  onDismissed: (direction) {
                    final deleteItem = CatalogModel(
                      id: lists[index].id,
                      name: lists[index].name,
                      description: lists[index].description,
                      photoUrl: lists[index].photoUrl,
                      delete: true,
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
                  },
                  child: ListTile(
                    title: Text(lists[index].name),
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   Routes.create_edit_todo,
                      //   arguments: lists[index],
                      // );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0.5);
              },
            );
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
}
