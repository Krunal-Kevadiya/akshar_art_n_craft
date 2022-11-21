import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import './firestore_service.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _firestoreService = FirestoreService.instance;

  String? getCatalogPath(FirestoreOperationType type, int? id) {
    switch (type) {
      case FirestoreOperationType.user:
        return id != null ? FirestorePath.user(id) : FirestorePath.users;
      case FirestoreOperationType.brand:
        return id != null ? FirestorePath.brand(id) : FirestorePath.brands;
      case FirestoreOperationType.fabric:
        return id != null ? FirestorePath.fabric(id) : FirestorePath.fabrics;
      case FirestoreOperationType.favorites:
        return id != null ? FirestorePath.favorites(uid, id) : null;
      case FirestoreOperationType.testimonial:
        return id != null
            ? FirestorePath.testimonial(id)
            : FirestorePath.testimonials;
      case FirestoreOperationType.category:
        return id != null
            ? FirestorePath.category(id)
            : FirestorePath.categories;
      case FirestoreOperationType.subCategory:
        return id != null
            ? FirestorePath.subCategory(id)
            : FirestorePath.subCategories;
      case FirestoreOperationType.product:
        return id != null ? FirestorePath.product(id) : FirestorePath.products;
    }
  }

  // Crud operation for category, sub category, brand and fabric
  Future<Result<bool, Exception>> addCatalog(
    FirestoreOperationType type,
    CatalogModel model,
    XFile? file,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      if (file != null) {
        final ref =
            FirebaseStorage.instance.ref().child(type.name).child(file.getName);
        final metadata = SettableMetadata(
          contentType: 'image/${file.getExtension}',
          customMetadata: {'picked-file-path': file.path},
        );
        final uploadTask = await ref.putFile(File(file.path), metadata);
        final downloadUrl = await uploadTask.ref.getDownloadURL();
        model.photoUrl = downloadUrl;
      }
      return _firestoreService.add(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Future<Result<bool, Exception>> updateCatalog(
    FirestoreOperationType type,
    CatalogModel model,
    XFile? file,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      if (file != null) {
        final ref =
            FirebaseStorage.instance.ref().child(type.name).child(file.getName);
        final metadata = SettableMetadata(
          contentType: 'image/${file.getExtension}',
          customMetadata: {'picked-file-path': file.path},
        );
        final uploadTask = await ref.putFile(File(file.path), metadata);
        final downloadUrl = await uploadTask.ref.getDownloadURL();
        final oldProfile = model.photoUrl ?? '';
        if (oldProfile != '') {
          await FirebaseStorage.instance.refFromURL(oldProfile).delete();
        }
        model.photoUrl = downloadUrl;
      }
      return _firestoreService.update(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Future<Result<bool, Exception>> deleteCatalog(
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
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Stream<List<CatalogModel>>? getAllCatalog({
    required FirestoreOperationType type,
    bool isDelete = false,
  }) {
    final path = getCatalogPath(type, null);
    if (path != null) {
      return _firestoreService.collectionStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? CatalogModel.fromJson(data) : null,
        queryBuilder: (query) => query.where('delete', isEqualTo: isDelete),
      );
    }
    return null;
  }

  Stream<CatalogModel?>? getCatalogById(
    FirestoreOperationType type,
    int id,
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

  // Crud operation for testimonial
  Future<Result<bool, Exception>> addTestimonial(
    FirestoreOperationType type,
    TestimonialModel model,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      return _firestoreService.add(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Stream<List<TestimonialModel>>? getAllTestimonial(
    FirestoreOperationType type,
  ) {
    final path = getCatalogPath(type, null);
    if (path != null) {
      return _firestoreService.collectionStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? TestimonialModel.fromJson(data) : null,
      );
    }
    return null;
  }

  // get ref for category, sub category, brand and fabric
  DocumentReference<Map<String, dynamic>>? getFirestoreRef(
    FirestoreOperationType type,
    int id,
  ) {
    final path = getCatalogPath(type, id);
    if (path != null) {
      return _firestoreService.ref(path);
    }
    return null;
  }

  // Crud operation for product
  Future<Result<bool, Exception>> addProduct(
    FirestoreOperationType type,
    ProductModel model,
    List<XFile?> files,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      final newFiles =
          files.where((item) => item != null).whereType<XFile>().toList();
      if (newFiles.isNotEmpty) {
        final list = newFiles.map(
          (file) {
            final ref = FirebaseStorage.instance
                .ref()
                .child(type.name)
                .child(file.getName);
            final metadata = SettableMetadata(
              contentType: 'image/${file.getExtension}',
              customMetadata: {'picked-file-path': file.path},
            );
            return ref.putFile(File(file.path), metadata);
          },
        );
        final uploadTask = await Future.wait(list);
        final downloadUrl = await Future.wait(
          uploadTask.map((task) => task.ref.getDownloadURL()),
        );
        model.photoUrl = downloadUrl;
      }
      return _firestoreService.add(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Future<Result<bool, Exception>> updateProduct(
    FirestoreOperationType type,
    ProductModel model,
    List<XFile?> files,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      final newFiles =
          files.where((item) => item != null).whereType<XFile>().toList();
      if (newFiles.isNotEmpty) {
        final list = newFiles.map(
          (file) {
            final ref = FirebaseStorage.instance
                .ref()
                .child(type.name)
                .child(file.getName);
            final metadata = SettableMetadata(
              contentType: 'image/${file.getExtension}',
              customMetadata: {'picked-file-path': file.path},
            );
            return ref.putFile(File(file.path), metadata);
          },
        );
        final uploadTask = await Future.wait(list);
        final downloadUrl = await Future.wait(
          uploadTask.map((task) => task.ref.getDownloadURL()),
        );
        // if (model.photoUrl) {
        //   await FirebaseStorage.instance.refFromURL(model.photoUrl).delete();
        // }
        model.photoUrl = downloadUrl;
      }
      return _firestoreService.update(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Future<Result<bool, Exception>> deleteProduct(
    FirestoreOperationType type,
    ProductModel model,
  ) async {
    final path = getCatalogPath(type, model.id);
    if (path != null) {
      return _firestoreService.update(
        path: path,
        data: model.toJson(),
      );
    }
    return Error(Exception(ErrorString.pathNotFound.tr()));
  }

  Stream<List<ProductModel>>? getAllProduct({
    required FirestoreOperationType type,
    bool isDelete = false,
  }) {
    final path = getCatalogPath(type, null);
    if (path != null) {
      return _firestoreService.collectionStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? ProductModel.fromJson(data) : null,
        queryBuilder: (query) => query.where('delete', isEqualTo: isDelete),
      );
    }
    return null;
  }

  Stream<ProductModel?>? getProductById(
    FirestoreOperationType type,
    int id,
  ) {
    final path = getCatalogPath(type, id);
    if (path != null) {
      return _firestoreService.documentStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? ProductModel.fromJson(data) : null,
      );
    }
    return null;
  }

  Stream<List<ProductModel>>? getAllProductByCategoryId({
    required FirestoreOperationType type,
    required int id,
    bool isDelete = false,
  }) {
    final path = getCatalogPath(type, null);
    if (path != null) {
      return _firestoreService.collectionStream(
        path: path,
        builder: (data, documentId) =>
            data != null ? ProductModel.fromJson(data) : null,
        queryBuilder: (query) => query
            .where('delete', isEqualTo: isDelete)
            .where('category', isEqualTo: id),
      );
    }
    return null;
  }

  // //Method to mark all todoModel to be complete
  // Future<void> setAllTodoComplete() async {
  //   final batchUpdate = FirebaseFirestore.instance.batch();

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestorePath.todo(uid))
  //       .get();

  //   for (DocumentSnapshot ds in querySnapshot.docs) {
  //     batchUpdate.update(ds.reference, {'complete': true});
  //   }
  //   await batchUpdate.commit();
  // }

  // Future<void> deleteAllTodoWithComplete() async {
  //   final batchDelete = FirebaseFirestore.instance.batch();

  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestorePath.todo(uid))
  //       .where('complete', isEqualTo: true)
  //       .get();

  //   for (DocumentSnapshot ds in querySnapshot.docs) {
  //     batchDelete.delete(ds.reference);
  //   }
  //   await batchDelete.commit();
  // }
}
