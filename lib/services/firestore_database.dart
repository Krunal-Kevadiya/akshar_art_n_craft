import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:multiple_result/multiple_result.dart';

import './firestore_service.dart';
import '../constants/constants.dart';
import '../models/models.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _firestoreService = FirestoreService.instance;

  String? getCatalogPath(FirestoreOperationType type, String? id) {
    switch (type) {
      case FirestoreOperationType.user:
        return id != null ? FirestorePath.user(id) : FirestorePath.users;
      case FirestoreOperationType.brand:
        return id != null ? FirestorePath.brand(id) : FirestorePath.brands;
      case FirestoreOperationType.fabric:
        return id != null ? FirestorePath.fabric(id) : FirestorePath.fabrics;
      case FirestoreOperationType.favorites:
        return id != null ? FirestorePath.favorites(uid, id) : null;
      case FirestoreOperationType.category:
        return id != null
            ? FirestorePath.category(id)
            : FirestorePath.categories;
      case FirestoreOperationType.subCategory:
        return id != null
            ? FirestorePath.subCategory(id)
            : FirestorePath.subCategories;
      // ignore: no_default_cases
      default:
        return null;
    }
  }

  // Crud operation for category, sub category, brand and fabric
  Future<Result<Exception, bool>> addCatalog(
    FirestoreOperationType type,
    CatalogModel model,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      return _firestoreService.add(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFoundError.tr()));
  }

  Future<Result<Exception, bool>> updateCatalog(
    FirestoreOperationType type,
    CatalogModel model,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      return _firestoreService.update(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFoundError.tr()));
  }

  Future<Result<Exception, bool>> deleteCatalog(
    FirestoreOperationType type,
    CatalogModel model,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      return _firestoreService.update(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFoundError.tr()));
  }

  Stream<List<CatalogModel>>? getAllCatalog(FirestoreOperationType type) {
    final path = getCatalogPath(type, null);
    if (path != null) {
      return _firestoreService.collectionStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? CatalogModel.fromJson(data) : null,
      );
    }
    return null;
  }

  Stream<CatalogModel?>? getCatalogById(
    FirestoreOperationType type,
    String id,
  ) {
    final path = getCatalogPath(type, id);
    if (path != null) {
      return _firestoreService.documentStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? CatalogModel.fromJson(data) : null,
      );
    }
    return null;
  }

  // //Method to mark all todoModel to be complete
  // Future<void> setAllTodoComplete() async {
  //   final batchUpdate = FirebaseFirestore.instance.batch();

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestorePath.todos(uid))
  //       .get();

  //   for (DocumentSnapshot ds in querySnapshot.docs) {
  //     batchUpdate.update(ds.reference, {'complete': true});
  //   }
  //   await batchUpdate.commit();
  // }

  // Future<void> deleteAllTodoWithComplete() async {
  //   final batchDelete = FirebaseFirestore.instance.batch();

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestorePath.todos(uid))
  //       .where('complete', isEqualTo: true)
  //       .get();

  //   for (DocumentSnapshot ds in querySnapshot.docs) {
  //     batchDelete.delete(ds.reference);
  //   }
  //   await batchDelete.commit();
  // }
}
