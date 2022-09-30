import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import './my_permissions.dart';
import '../assets/assets.dart';
import '../constants/constants.dart';
import '../models/models.dart';

class MediaSelection {
  static Future<XFile?> pickImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    if (source == ImageSource.camera) {
      if (await MyPermission.requestSinglePermission(
        context,
        Permission.camera,
        RationaleModel(
          title: SheetString.pmCameraTitle.tr(),
          message: SheetString.pmCameraNotDesc.tr(),
          buttonPositive: SheetString.allowButton.tr(),
          svg: Vectors.camera,
        ),
        RationaleModel(
          title: SheetString.pmCameraNotTitle.tr(),
          message: SheetString.pmCameraNotDesc.tr(),
          buttonPositive: SheetString.goToSettingsButton.tr(),
          buttonNegative: SheetString.noThanksButton.tr(),
          svg: Vectors.camera,
        ),
      )) {
        return ImagePicker().pickImage(source: source);
      }
      return null;
    } else if (source == ImageSource.gallery) {
      RationaleModel requestRationale, requestBlocked;
      if (Platform.isAndroid) {
        requestRationale = RationaleModel(
          title: SheetString.pmStorageTitle.tr(),
          message: SheetString.pmStorageDesc.tr(),
          buttonPositive: SheetString.allowButton.tr(),
          svg: Vectors.media,
        );
        requestBlocked = RationaleModel(
          title: SheetString.pmStorageNotTitle.tr(),
          message: SheetString.pmStorageNotDesc.tr(),
          buttonPositive: SheetString.goToSettingsButton.tr(),
          buttonNegative: SheetString.noThanksButton.tr(),
          svg: Vectors.media,
        );
      } else {
        requestRationale = RationaleModel(
          title: SheetString.pmLibraryTitle.tr(),
          message: SheetString.pmLibraryDesc.tr(),
          buttonPositive: SheetString.allowButton.tr(),
          svg: Vectors.media,
        );
        requestBlocked = RationaleModel(
          title: SheetString.pmLibraryNotTitle.tr(),
          message: SheetString.pmLibraryNotDesc.tr(),
          buttonPositive: SheetString.goToSettingsButton.tr(),
          buttonNegative: SheetString.noThanksButton.tr(),
          svg: Vectors.media,
        );
      }
      if (await MyPermission.requestSinglePermission(
        context,
        Platform.isAndroid ? Permission.storage : Permission.photos,
        requestRationale,
        requestBlocked,
      )) {
        return ImagePicker().pickImage(source: source);
      }
    }
    return null;
  }
}
