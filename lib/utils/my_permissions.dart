import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/models.dart';
import '../utils/my_bottom_sheet.dart';

class MyPermission {
  static Future<bool> checkPermissionStatus(
    BuildContext context,
    Permission permission,
    RationaleModel requestRationale,
    RationaleModel requestBlocked,
    PermissionStatus status,
  ) {
    if (status.isDenied || status.isRestricted) {
      return requestSinglePermission(
        context,
        permission,
        requestRationale,
        requestBlocked,
      );
    }
    if (status.isPermanentlyDenied) {
      return requestSinglePermission(
        context,
        permission,
        requestRationale,
        requestBlocked,
      );
    }
    if (status.isGranted || status.isLimited) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  static Future<bool> requestSinglePermission(
    BuildContext context,
    Permission permission,
    RationaleModel requestRationale,
    RationaleModel requestBlocked,
  ) async {
    if (await permission.shouldShowRequestRationale &&
        (await permission.isDenied || await permission.isRestricted)) {
      await MyBottomSheet.showPermissionSheet(
        context: context,
        title: requestRationale.title,
        message: requestRationale.message,
        labelPositive: requestRationale.buttonPositive,
        labelNegative: requestRationale.buttonNegative,
        svg: requestRationale.svg,
        pickPositive: () {},
      );
      return Future<bool>.value(false);
    }
    if (await permission.isPermanentlyDenied) {
      await MyBottomSheet.showPermissionSheet(
        context: context,
        title: requestBlocked.title,
        message: requestBlocked.message,
        labelPositive: requestBlocked.buttonPositive,
        labelNegative: requestRationale.buttonNegative,
        svg: requestBlocked.svg,
        pickPositive: openAppSettings,
      );
      return Future<bool>.value(false);
    }
    if (await permission.isGranted || await permission.isLimited) {
      return Future<bool>.value(true);
    }
    return checkPermissionStatus(
      context,
      permission,
      requestRationale,
      requestBlocked,
      await permission.request(),
    );
  }
}
