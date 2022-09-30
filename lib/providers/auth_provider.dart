import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import '../constants/constants.dart';
import '../models/models.dart';
import '../utils/utils.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  registering,
  forgetting,
  profiling
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- uninitialized -Checking user is logged or not, the Splash Screen will be shown
- authenticated -User is authenticated successfully, Home Page will be shown
- authenticating -Sign In button just been pressed, progress bar will be shown
- unauthenticated -User is not authenticated, login page will be shown
- registering -User just pressed registering, progress bar will be shown
- forgetting -User just pressed forgot password, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _auth.authStateChanges().listen(onAuthStateChanged);
  }
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  Status _status = Status.uninitialized;

  Status get status => _status;

  Stream<UserModel?> get user =>
      _auth.authStateChanges().asyncMap(_userFromFirebase);

  String handleAuthException(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = ErrorString.fbInvalidEmailError.tr();
        break;
      case 'wrong-password':
        errorMessage = ErrorString.fbWrongPasswordError.tr();
        break;
      case 'weak-password':
        errorMessage = ErrorString.fbWeakPasswordError.tr();
        break;
      case 'email-already-in-use':
        errorMessage = ErrorString.fbEmailAlreadyInUseError.tr();
        break;
      default:
        errorMessage = ErrorString.fbUnknownError.tr();
    }
    return errorMessage;
  }

  Future<UserModel?> _userFromFirebase(User? user) async {
    if (user == null) {
      return null;
    }
    final docSnapshot =
        await _firestore.collection(FirestorePath.users).doc(user.uid).get();
    final type = docSnapshot.data()?['type'] as String? ?? 'user';

    return UserModel(
      uid: user.uid,
      email: user.email,
      emailVerified: user.emailVerified,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
      type: type,
    );
  }

  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      await _userFromFirebase(firebaseUser);
      _status = Status.authenticated;
    }
    notifyListeners();
  }

  Future<Result<Exception, UserModel>> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      _status = Status.registering;
      notifyListeners();
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        final userDetails = <String, dynamic>{
          'type': 'admin',
        };
        await _firestore.collection('users').doc(user.uid).set(userDetails);
        await user.sendEmailVerification();
      }
      final userModel =
          await _userFromFirebase(FirebaseAuth.instance.currentUser);
      _status = Status.unauthenticated;
      notifyListeners();
      if (userModel != null) {
        return Success(userModel);
      } else {
        return Error(Exception(ErrorString.signInError.tr()));
      }
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(handleAuthException(e)));
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(e.toString()));
    }
  }

  Future<Result<Exception, UserModel>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.reload();
      final userModel =
          await _userFromFirebase(FirebaseAuth.instance.currentUser);
      _status = Status.unauthenticated;
      notifyListeners();
      if (userModel != null) {
        return Success(userModel);
      } else {
        return Error(Exception(ErrorString.signInError.tr()));
      }
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(handleAuthException(e)));
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(e.toString()));
    }
  }

  Future<Result<Exception, bool>> sendPasswordResetEmail(String email) async {
    try {
      _status = Status.forgetting;
      notifyListeners();
      await _auth.sendPasswordResetEmail(email: email);
      _status = Status.unauthenticated;
      notifyListeners();
      return const Success(true);
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(handleAuthException(e)));
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(e.toString()));
    }
  }

  Future<Result<Exception, bool>> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      return const Success(true);
    } on FirebaseAuthException catch (e) {
      return Error(Exception(handleAuthException(e)));
    } catch (e) {
      return Error(Exception(e.toString()));
    }
  }

  Future<Result<Exception, bool>> updateProfile(
    String name,
    String email,
    String phone,
    String password,
    XFile? file,
  ) async {
    try {
      _status = Status.profiling;
      notifyListeners();
      await _auth.currentUser?.updateDisplayName(name);
      await _auth.currentUser?.updateEmail(email);
      //await _auth.currentUser?.updatePhoneNumber(phone);
      if (password != '') {
        await _auth.currentUser?.updatePassword(password);
      }
      await _auth.currentUser?.reload();
      if (file != null) {
        final ref =
            FirebaseStorage.instance.ref().child('user').child(file.getName);
        final metadata = SettableMetadata(
          contentType: 'image/${file.getExtension}',
          customMetadata: {'picked-file-path': file.path},
        );
        final uploadTask = await ref.putFile(File(file.path), metadata);
        final downloadUrl = await uploadTask.ref.getDownloadURL();
        await _auth.currentUser?.updatePhotoURL(downloadUrl);
      }
      _status = Status.unauthenticated;
      notifyListeners();
      return const Success(true);
    } on FirebaseAuthException catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(handleAuthException(e)));
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
      return Error(Exception(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
