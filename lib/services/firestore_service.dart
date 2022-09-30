import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import '../utils/utils.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<Result<Exception, bool>> add({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final reference = FirebaseFirestore.instance.doc(path);
      await reference.set(data);
      return const Success(true);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  Future<Result<Exception, bool>> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final reference = FirebaseFirestore.instance.doc(path);
      await reference.update(data);
      return const Success(true);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  Future<Result<Exception, bool>> delete({required String path}) async {
    try {
      final reference = FirebaseFirestore.instance.doc(path);
      await reference.delete();
      return const Success(true);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T? Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>?, snapshot.id),
          )
          .where((value) => value != null)
          .whereType<T>()
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T?> documentStream<T>({
    required String path,
    required T? Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) {
      final result =
          builder(snapshot.data() as Map<String, dynamic>?, snapshot.id);
      return result;
    });
  }

  Future<Result<Exception, String>> uploadImage({
    required XFile file,
    required String bucket,
  }) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child(bucket).child(file.getName);
      final metadata = SettableMetadata(
        contentType: 'image/${file.getExtension}',
        customMetadata: {'picked-file-path': file.path},
      );
      final uploadTask = await ref.putFile(File(file.path), metadata);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return Success(downloadUrl);
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }
}
